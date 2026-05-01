//
//  HomePageView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 17/10/2025.
//

import SwiftUI

struct HomePageView: View {
    
    @EnvironmentObject var medicationVM: MedicationViewModel
    
    @State private var selectedDate: Date? = Calendar.current.startOfDay(for: Date())
    @State private var selectedMedication: MedicationItem? = nil
    @State private var medicationToModify: MedicationItem? = nil
    @State private var navigationTarget: MedicationItem? = nil
    @State private var isLongPressing = false
    @State private var showToast = false
    @State private var toastMessage = ""

    var dateArray: [Date] = (0...6).compactMap {
        Calendar.current.date(byAdding: .day, value: $0, to: Calendar.current.startOfDay(for: Date()))
    }
    
    func showToastMessage(_ message: String) {
        toastMessage = message
        withAnimation(.easeInOut) { showToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeInOut) { showToast = false }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            Color.aliceBlue
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    HomeHeaderView(selectedDate: selectedDate)
                    
                    HorizontalDateView(dateArray: dateArray, selectedDate: $selectedDate)
                    
                    MedicationListView(
                        selectedDate: $selectedDate,
                        isLongPressing: $isLongPressing,
                        navigationTarget: $navigationTarget,
                        selectedMedication: $selectedMedication,
                        onShowToast: showToastMessage
                    )
                }
                .padding(.bottom, 120)
            }
            
            if showToast {
                VStack {
                    Spacer()
                    ToastView(message: toastMessage)
                        .padding(.bottom, 100)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .frame(maxWidth: .infinity)
                .allowsHitTesting(false)
            }
            
            AddMedicationButtonView()
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
    let context = PersistenceController.preview.container.viewContext
    let vm = MedicationViewModel(context: context)
    
    HomePageView()
        .environmentObject(vm)
        .environment(\.managedObjectContext, context)
}
