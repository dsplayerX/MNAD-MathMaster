//
//  HomeView.swift
//  MathMaster
//
//  Created by Dumindu Sameendra on 2024-10-09.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            GuessView()
                .tabItem {
                    Text("Guess")
                    Image(systemName: "house.fill")
                        .renderingMode(.template)
                }
                .tag(0)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(1)
        }
    }
}

#Preview {
    HomeView()
}
