//
//  TabView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 12/04/2026.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomePageView()
            }
            .tabItem {
                Label("Accueil", systemImage: "house")
            }
            
            NavigationStack {
                HistoricView()
            }
            .tabItem {
                Label("Historique", systemImage: "clock.circle")
            }
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Paramètres", systemImage: "gear")
            }
        }
        .tint(.icyBlue)
    }
}

#Preview {
    MainTabView()
}
