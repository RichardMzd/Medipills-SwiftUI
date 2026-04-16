//
//  MedicationViewModel.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 28/12/2025.
//

import Foundation
import UserNotifications

class MedicationViewModel: ObservableObject {

    // 1️⃣ Source unique de vérité
    @Published private var medicationsByDate: [Date: [MedicationItem]] = [:]


    // 2️⃣ Médicaments pour une date donnée
    func medications(for date: Date) -> [MedicationItem] {
        let normalizedDate = Calendar.current.startOfDay(for: date)
        return medicationsByDate[normalizedDate] ?? []
    }
    
    func medicationsByMoment(for date: Date, moment: DayMoment) -> [MedicationItem] {
        return medications(for: date).filter { $0.moment == moment }
    }

    // 3️⃣ Ajouter un médicament
    func addMedication(
        name: String,
        doseValue: Double,
        form: String,
        date: Date,
        moment: DayMoment,
        isBeforeMeal: Bool,
        frequency: FrequencyForm,
        notes: String,
        reminderEnabled: Bool,
        reminderTime: Date
    ) {
        let normalizedDate = Calendar.current.startOfDay(for: date)

        let med = MedicationItem(
            name: name,
            doseValue: doseValue,
            form: form,
            moment: moment,
            isBeforeMeal: isBeforeMeal,
            frequency: frequency,
            startDate: normalizedDate,
            notes: notes,
            reminderEnabled: reminderEnabled,
            reminderTime: reminderTime
        )
        
        

        let range: ClosedRange<Int>

        switch frequency {
        case .everyDay: range = 0...6
        case .threeDay: range = 0...2
        case .oneWeek: range = 0...6

        }

        for dayOffset in range {
            let targetDate =
                Calendar.current.date(
                    byAdding: .day,
                    value: dayOffset,
                    to: normalizedDate
                ) ?? Date()

            if medicationsByDate[targetDate] != nil {
                medicationsByDate[targetDate]!.append(med)
            } else {
                medicationsByDate[targetDate] = [med]
            }
        }
        
        scheduleNotification(for: med)
    }

    func delete(_ medication: MedicationItem) {
        for (date, _) in medicationsByDate {
            medicationsByDate[date]?.removeAll { $0.id == medication.id }
        }
    }
    
    func takenKey(for med: MedicationItem, on date: Date) -> String {
        let day = Calendar.current.startOfDay(for: date)
        return "taken_\(med.id)_\(Int(day.timeIntervalSince1970))"
    }
    
    func isTaken(_ med: MedicationItem, on date: Date) -> Bool {
        UserDefaults.standard.bool(forKey: takenKey(for: med, on: date))
    }

    func toggleTaken(_ med: MedicationItem, on date: Date) {
        let key = takenKey(for: med, on: date)
        let current = UserDefaults.standard.bool(forKey: key)
        UserDefaults.standard.set(!current, forKey: key)
        objectWillChange.send() // force le refresh de la vue
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Erreur permission notifications: \(error)")
            }
        }
    }
    
    func scheduleNotification(for med: MedicationItem) {
        guard med.reminderEnabled, let reminderTime = med.reminderTime else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Rappel médicament"
        content.body = "Il est l'heure de prendre \(med.name)"
        content.sound = .default
        
        var triggerComponents = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
        triggerComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: true)
        let request = UNNotificationRequest(identifier: med.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

struct MedicationItem: Identifiable, Hashable {
    let name: String
    let doseValue: Double
    let form: String
    let moment: DayMoment
    let isBeforeMeal: Bool
    let frequency: FrequencyForm
    let startDate: Date
    let id: UUID = UUID()
    let notes: String
    let reminderEnabled: Bool
    let reminderTime: Date?
}
