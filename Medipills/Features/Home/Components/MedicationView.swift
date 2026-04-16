//
//  MedicationView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 22/12/2025.
//

import SwiftUI

struct MedicationView: View {
    let name: String
    let doseValue: Double
    let form: MedicationForm
    let doseText: String
    let moment: DayMoment  // ← NOUVEAU
    let isBeforeMeal: String
    let startDate: Date
    let currentDate: Date
    let frequency: FrequencyForm
    let isTaken: Bool
    
    var frequencyLabel: String {
        
        let diff = Calendar.current.dateComponents([.day], from: startDate, to: currentDate).day ?? 0
        // switch ici
        
        switch frequency {
        case .everyDay:
            return "Tous les jours"
        case .threeDay:
            return "Jour \(diff + 1) / 3"
        case .oneWeek:
            return "Jour \(diff + 1) / 7"
        }
    }
    
    // Fonction pour choisir la couleur selon le moment
    private func cardColor(for moment: DayMoment) -> Color {
        switch moment {
        case .morning:
            return Color.morningGlow
        case .noon:
            return Color.noonSun
        case .evening:
            return Color.nightRest
        }
    }
    
    // Fonction pour l'icône selon le moment (bonus)
    private func momentIcon(for moment: DayMoment) -> String {
        switch moment {
        case .morning:
            return "sunrise.fill"
        case .noon:
            return "sun.max.fill"
        case .evening:
            return "moon.stars.fill"
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Icône médicament avec fond blanc
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 55, height: 55)
                    .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                
                Image(form.iconName)
                //                    .frame(width: 40, height: 40)
                    .foregroundColor(.icyBlue)
            }
            
            // Infos médicament
            VStack(alignment: .leading, spacing: 6) {
                Text(name)
                    .font(.custom("Inter", size: 16))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                Text("\(doseText) • \(isBeforeMeal)")
                    .font(.custom("Inter", size: 13))
                    .foregroundColor(.graphite)
                    .lineLimit(1)
            }.strikethrough(isTaken)

            
            Spacer()
                        
        }
        .padding(18)
        .background(
            // Dégradé avec la couleur du moment
            LinearGradient(
                colors: [
                    cardColor(for: moment),
                    cardColor(for: moment).opacity(0.85)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
        
    }
}

struct MedicationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            MedicationView(
                name: "Doliprane",
                doseValue: 1,
                form: .comprime,
                doseText: MedicationForm.comprime.finalDoseText(value: 1),
                moment: .morning,
                isBeforeMeal: "Après repas",
                startDate: Date(),
                currentDate: Date(),
                frequency: .everyDay,
                isTaken: true,
            )
            
            MedicationView(
                name: "Metformine",
                doseValue: 2,
                form: .gelule,
                doseText: MedicationForm.gelule.finalDoseText(value: 2),
                moment: .noon,
                isBeforeMeal: "Avant repas",
                startDate: Date(),
                currentDate: Date(),
                frequency: .threeDay,
                isTaken: true,
            )
            
            MedicationView(
                name: "Vitamine C",
                doseValue: 1,
                form: .sirop,
                doseText: MedicationForm.comprime.finalDoseText(value: 1),
                moment: .evening,
                isBeforeMeal: "Après repas",
                startDate: Date(),
                currentDate: Date(),
                frequency: .oneWeek,
                isTaken: true,
            )
            
        }
        .padding()
        .background(Color.aliceBlue)
    }
}
