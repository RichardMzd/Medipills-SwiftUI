//
//  ProfilView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 10/04/2026.
//

import SwiftUI

struct ProfilView: View {
    
    @AppStorage("username") var username: String = ""
    @State private var nameInput: String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        ZStack {
            Color.aliceBlue
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Illustration
                ZStack {
                    Circle()
                        .fill(Color.icyBlue.opacity(0.15))
                        .frame(width: 90, height: 90)
                    Image(systemName: "person.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.icyBlue)
                }
                .padding(.bottom, 24)
                
                // Titre
                Text("Bienvenue sur Medipills")
                    .font(.custom("Poppins-Bold", size: 22))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                // Sous-titre
                Text("Comment dois-je t'appeler ?")
                    .font(.custom("Inter", size: 14))
                    .foregroundColor(.dimGrey)
                    .padding(.bottom, 32)
                
                // Champ texte
                LabeledCapsuleTextField(
                    title: "Ton prénom",
                    placeholder: "Richard...",
                    text: $nameInput
                )
//                .padding(.bottom, 28)
                
                // Bouton
                Button {
                    if !nameInput.isEmpty {
                        username = nameInput
                    } else {
                        showError = true
                    }
                } label: {
                    Text("Commencer →")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.icyBlue)
                        .clipShape(Capsule())
                }
                .alert("Aucun nom", isPresented: $showError) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text("Merci d'entrer ton prénom pour continuer.")
                }
                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                .padding()

            }
            .padding(.horizontal, 28)
        }
    }}

#Preview {
    ProfilView()
}
