//
//  HomePageView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 17/10/2025.
//

import SwiftUI

struct HomePageView: View {
    
    @AppStorage("username") var username: String = ""
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var medicationVM: MedicationViewModel
    
    @State private var showAddMedicationSheet = false
    @State private var selectedDate: Date? = Calendar.current.startOfDay(for: Date())
    @State private var selectedMedication: MedicationItem? = nil
    @State private var medicationToModify: MedicationItem? = nil
    @State private var navigationTarget: MedicationItem? = nil
    @State private var isLongPressing = false
    
    static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.setLocalizedDateFormatFromTemplate("d")
        f.locale = Locale(identifier: "fr_FR")
        return f
    }()
    
    static let dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "EEE"
        f.locale = Locale(identifier: "fr_FR")
        return f
    }()
    
    static let fullDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "fr_FR")
        f.setLocalizedDateFormatFromTemplate("EEEE d MMMM")
        return f
    }()
    
    var dateArray: [Date] = (0...6).compactMap {
        Calendar.current.date(byAdding: .day, value: $0, to: Calendar.current.startOfDay(for: Date()))
    }
    
    var time: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 5 {
            return "Bonne nuit"
        } else if hour >= 17 {
            return "Bonsoir"
        } else {
            return "Bonjour"
        }
    }
    
    var isTodaySelected: Bool {
        guard let selectedDate else { return false }
        return Calendar.current.isDateInToday(selectedDate)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            Color.aliceBlue
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 5) {
                            Text(time)
                                .font(.custom("Poppins-Bold", size: 24))
                                .foregroundColor(.black)
                            Text(username)
                                .font(.custom("Inter", size: 24))
                                .foregroundColor(.black)
                        }
                        
                        Text(isTodaySelected ? "Aujourd'hui" : HomePageView.fullDateFormatter
                            .string(from: selectedDate ?? Date())
                            .capitalized
                        )
                        .font(.custom("Inter", size: 16))
                        .foregroundColor(.dimGrey)
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(dateArray, id: \.self) { date in
                                DateCircleView(
                                    date: date,
                                    selectedDate: selectedDate
                                ) { newDate in
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        selectedDate = Calendar.current.startOfDay(for: newDate)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.vertical, 16)
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                    .padding(.horizontal, 25)
                    
                    if let date = selectedDate {
                        let meds = medicationVM.medications(for: date)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Médicaments du jour")
                                .font(.custom("Inter", size: 16))
                                .foregroundColor(.dimGrey)
                                .padding(.horizontal, 25)
                            
                            if meds.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 48))
                                        .foregroundColor(.icyBlue.opacity(0.3))
                                    
                                    Text("Aucune prise prévue")
                                        .font(.custom("Inter", size: 16))
                                        .foregroundColor(.dimGrey)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 40)
                            } else {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(DayMoment.allCases, id: \.self) { moment in
                                        let meds = medicationVM.medicationsByMoment(for: date, moment: moment)
                                        
                                        if !meds.isEmpty {
                                            Text(moment.rawValue)
                                                .font(.custom("Poppins-Bold", size: 16))
                                                .padding(.horizontal, 25)
                                            
                                            HStack(alignment: .top, spacing: 12) {
                                                Rectangle()
                                                    .frame(width: 1.5)
                                                    .cornerRadius(2)
                                                    .foregroundColor(.icyBlue)
                                                
                                                VStack(alignment: .leading, spacing: 10) {
                                                    ForEach(meds) { med in
                                                        if let formEnum = MedicationForm(rawValue: med.form ?? "") {
                                                            let doseText = formEnum.finalDoseText(value: med.doseValue)
                                                            let beforeOrAfter = formEnum.beforeOfAfterMeal(value: med.isBeforeMeal)
                                                            
                                                            ZStack(alignment: .trailing) {
                                                                Button {
                                                                    if !isLongPressing {
                                                                        navigationTarget = med
                                                                    }
                                                                    isLongPressing = false
                                                                } label: {
                                                                    MedicationView(
                                                                        name: med.name ?? "",
                                                                        doseValue: med.doseValue,
                                                                        form: formEnum,
                                                                        doseText: doseText,
                                                                        moment: DayMoment(rawValue: med.moment ?? "") ?? .morning,
                                                                        isBeforeMeal: beforeOrAfter,
                                                                        startDate: med.startDate ?? Date(),
                                                                        currentDate: Date(),
                                                                        frequency: FrequencyForm(rawValue: med.frequency ?? "") ?? .everyDay,
                                                                        isTaken: medicationVM.isTaken(med, on: date)
                                                                    )
                                                                }
                                                                .buttonStyle(.plain)
                                                                .swipeActions(edge: .trailing) {
                                                                    Button(role: .destructive) {
                                                                        medicationVM.delete(med)
                                                                    } label: {
                                                                        Label("Delete", systemImage: "trash")
                                                                    }
                                                                }
                                                                .lineLimit(1)
                                                                .onLongPressGesture(minimumDuration: 0.4) {
                                                                    selectedMedication = med
                                                                }
                                                                
                                                                Button {
                                                                    medicationVM.toggleTaken(med, on: date)
                                                                } label: {
                                                                    Image(systemName: medicationVM.isTaken(med, on: date) ? "checkmark.circle.fill" : "circle")
                                                                        .font(.system(size: 24))
                                                                        .foregroundColor(medicationVM.isTaken(med, on: date) ? .icyBlue : .gray.opacity(0.4))
                                                                }
                                                                .buttonStyle(.plain)
                                                                .padding(.trailing, 18)
                                                            }
                                                            .simultaneousGesture(
                                                                LongPressGesture(minimumDuration: 0.4).onEnded { _ in
                                                                    isLongPressing = true
                                                                    selectedMedication = med
                                                                }
                                                            )
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.horizontal, 25)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 120)
            }
            
            Button(action: {
                showAddMedicationSheet = true
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(
                        LinearGradient(
                            colors: [Color.icyBlue, Color.icyBlue.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
            }
            .padding(.trailing, 24)
            .padding(.bottom, 24)
            .sheet(isPresented: $showAddMedicationSheet) {
                AddMedicationView { name, doseValue, form, date, moment, isBeforeMeal, frequency, notes, reminderEnabled, reminderTime in
                    medicationVM.addMedication(
                        name: name,
                        doseValue: doseValue,
                        form: form,
                        date: date,
                        moment: moment,
                        isBeforeMeal: isBeforeMeal,
                        frequency: frequency,
                        notes: notes,
                        reminderEnabled: reminderEnabled,
                        reminderTime: reminderTime
                    )
                }
                .presentationDetents([.large])
                .presentationBackground(.clear)
                .presentationCornerRadius(45)
                .presentationDragIndicator(.hidden)
                .presentationBackground(Color.aliceBlue)
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
        }
        .navigationDestination(item: $navigationTarget) { med in
            DetailsView(medication: med)
        }
        .alert("Supprimer ?", isPresented: .constant(selectedMedication != nil)) {
            Button("Supprimer", role: .destructive) {
                if let med = selectedMedication {
                    medicationVM.delete(med)
                }
                selectedMedication = nil
            }
            Button("Modifier") {
                medicationToModify = selectedMedication
                selectedMedication = nil
            }
            Button("Annuler", role: .cancel) {
                selectedMedication = nil
            }
        } message: {
            Text("Voulez-vous vraiment supprimer ce médicament ?")
        }
        .sheet(item: $medicationToModify) { med in
            AddMedicationView(medicationToEdit: med) {
                name, doseValue, form, date, moment, isBeforeMeal, frequency, notes, reminderEnabled, reminderTime in
                medicationVM.delete(med)
                medicationVM.addMedication(
                    name: name,
                    doseValue: doseValue,
                    form: form,
                    date: date,
                    moment: moment,
                    isBeforeMeal: isBeforeMeal,
                    frequency: frequency,
                    notes: notes,
                    reminderEnabled: reminderEnabled,
                    reminderTime: reminderTime
                )
                medicationToModify = nil
            }
        }
    }
}

#Preview {
    HomePageView()
}
