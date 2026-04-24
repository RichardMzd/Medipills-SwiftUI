//
//  HistoricView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 12/04/2026.
//

import SwiftUI

struct HistoricView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var medicationVM: MedicationViewModel
    
    let lastDays: [Date] = (0...13).reversed().compactMap {
        Calendar.current.date(byAdding: .day, value: -$0, to: Calendar.current.startOfDay(for: Date()))
    }
    static let fullDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "fr_FR")
        f.setLocalizedDateFormatFromTemplate("EEEE d MMMM")
        return f
    }()
        
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.aliceBlue
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    let history = medicationVM.historyMedication()
                    ForEach(lastDays, id: \.self) { day in
                        if let medsForDay = history[day] {
                            Text(HistoricView.fullDateFormatter.string(from: day).capitalized)
                                .font(.custom("Poppins-Bold", size: 18))
                                .padding(.horizontal, 25)
                                .padding(.top, 8)
                            
                            ForEach(DayMoment.allCases, id: \.self) { moment in
                                let medsForMoment = medsForDay.filter {
                                    DayMoment(rawValue: $0.moment ?? "") == moment
                                }
                                
                                if !medsForMoment.isEmpty {
                                    Text(moment.rawValue)
                                        .font(.custom("Poppins-Bold", size: 14))
                                        .foregroundColor(.dimGrey)
                                        .padding(.horizontal, 25)
                                    
                                    ForEach(medsForMoment, id: \.self) { meds in
                                        if let formEnum = MedicationForm(rawValue: meds.form ?? "") {
                                            MedicationView(
                                                name: meds.name ?? "",
                                                doseValue: meds.doseValue,
                                                form: formEnum,
                                                doseText: formEnum.finalDoseText(value: meds.doseValue),
                                                moment: DayMoment(rawValue: meds.moment ?? "") ?? .morning,
                                                isBeforeMeal: formEnum.beforeOfAfterMeal(value: meds.isBeforeMeal),
                                                startDate: meds.startDate ?? Date(),
                                                currentDate: Date(),
                                                frequency: FrequencyForm(rawValue: meds.frequency ?? "") ?? .everyDay,
                                                isTaken: false
                                            )
                                            .padding(.horizontal, 25)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 120)
            }        }
    }
}

#Preview {
    HistoricView()
}
