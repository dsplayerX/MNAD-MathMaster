//
//  HomeView.swift
//  MathMaster
//
//  Created by Dumindu Sameendra on 2024-10-09.
//

import SwiftUI

struct HomeView: View {
    @State private var fontSize: CGFloat = 18
    @State private var systemColor: Color = .blue

        var body: some View {
            TabView {
                GuessView(fontSize: $fontSize, systemColor: $systemColor)
                    .tabItem {
                        Label("Guess", systemImage: "house.fill").foregroundColor(systemColor)
                    }
                    .tag(0)

                SettingsView(selectedFontSize: $fontSize, selectedColor: $systemColor)
                    .tabItem {
                        Label("Settings", systemImage: "gear").foregroundColor(systemColor)
                    }
                    .tag(1)
            }.accentColor(systemColor)
        }
}

#Preview {
    HomeView()
}
