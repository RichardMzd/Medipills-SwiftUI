//
//  MedicationViewModel.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 28/12/2025.
//

import Foundation
import CoreData
import UserNotifications

class MedicationViewModel: ObservableObject {
    
    @Published var fetchedMedications: [MedicationItem] = []
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchMedications()
    }
    
    // MARK: - Fetch
    func fetchMedications() {
        let request = NSFetchRequest<MedicationItem>(entityName: "MedicationItem")
        do {
            fetchedMedications = try context.fetch(request)
        } catch {
            print("Erreur fetch : \(error)")
        }
    }
    
    // MARK: - Filter par date
    func medications(for date: Date) -> [MedicationItem] {
        let normalizedDate = Calendar.current.startOfDay(for: date)
        
        return fetchedMedications.filter { med in
            guard let startDate = med.startDate else { return false }
            let start = Calendar.current.startOfDay(for: startDate)
            
            guard normalizedDate >= start else { return false }
            
            switch FrequencyForm(rawValue: med.frequency ?? "") {
            case .everyDay:
                return true
            case .threeDay:
                let end = Calendar.current.date(byAdding: .day, value: 3, to: start)!
                return normalizedDate < end
            case .oneWeek:
                let end = Calendar.current.date(byAdding: .day, value: 7, to: start)!
                return normalizedDate < end
            case .none:
                return false
            }
        }
    }
    
    func medicationsByMoment(for date: Date, moment: DayMoment) -> [MedicationItem] {
        return medications(for: date).filter {
            DayMoment(rawValue: $0.moment ?? "") == moment
        }
    }
    
    // MARK: - Ajouter
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
        let med = MedicationItem(context: context)
        med.id = UUID()
        med.name = name
        med.doseValue = doseValue
        med.form = form
        med.moment = moment.rawValue
        med.isBeforeMeal = isBeforeMeal
        med.frequency = frequency.rawValue
        med.startDate = Calendar.current.startOfDay(for: date)
        med.notes = notes
        med.reminderEnabled = reminderEnabled
        med.reminderTime = reminderEnabled ? reminderTime : nil
        
        save()
        scheduleNotification(for: med)
        fetchMedications()
    }
    
    // MARK: - Supprimer
    func delete(_ medication: MedicationItem) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: [medication.id?.uuidString ?? ""]
        )
        context.delete(medication)
        save()
        fetchMedications()
    }
    
    func historyMedication() -> [Date: [MedicationItem]] {
        var previousMed = [Date: [MedicationItem]]()
        let lastDays: [Date] = (0...13).reversed().compactMap {
            Calendar.current.date(byAdding: .day, value: -$0, to: Calendar.current.startOfDay(for: Date()))
        }
        
        for date in lastDays {
            // 1. médicaments prévus ce jour
            let medsForDay = medications(for: date)
            
            // 2. garde seulement ceux qui sont cochés
            let takenMeds = medsForDay.filter {
                isTaken($0, on: date)
            }
            
            if !takenMeds.isEmpty {
                previousMed[date] = takenMeds
            }
        }
        return previousMed
    }
    
    // MARK: - Save
    private func save() {
        do {
            try context.save()
        } catch {
            print("Erreur save : \(error)")
        }
    }
    
    // MARK: - Taken (UserDefaults)
    func takenKey(for med: MedicationItem, on date: Date) -> String {
        let day = Calendar.current.startOfDay(for: date)
        return "taken_\(med.id?.uuidString ?? "")_\(Int(day.timeIntervalSince1970))"
    }
    
    func isTaken(_ med: MedicationItem, on date: Date) -> Bool {
        UserDefaults.standard.bool(forKey: takenKey(for: med, on: date))
    }
    
    func toggleTaken(_ med: MedicationItem, on date: Date) {
        let key = takenKey(for: med, on: date)
        let current = UserDefaults.standard.bool(forKey: key)
        UserDefaults.standard.set(!current, forKey: key)
        objectWillChange.send()
    }
    
    // MARK: - Notifications
    func scheduleNotification(for med: MedicationItem) {
        guard med.reminderEnabled, let reminderTime = med.reminderTime else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Rappel médicament"
        content.body = "Il est l'heure de prendre \(med.name ?? "")"
        content.sound = .default
        
        var triggerComponents = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
        triggerComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: true)
        let request = UNNotificationRequest(
            identifier: med.id?.uuidString ?? UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}
