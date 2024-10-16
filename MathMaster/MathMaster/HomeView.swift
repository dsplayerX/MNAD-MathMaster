//
//  HomeView.swift
//  MathMaster
//
//  Created by Dumindu Sameendra on 2024-10-09.
//

import SwiftUI

struct HomeView: View {
    @State var selectedFontSize: CGFloat = 12
    @State var systemColor: AppTheme = .blue

        var body: some View {
            TabView {
                GuessView(fontSize: $selectedFontSize, systemColor: $systemColor)
                    .tabItem {
                        Label("Guess", systemImage: "checkmark.seal.fill").foregroundColor(systemColor.color)
                    }
                    .tag(0)

                SettingsView(selectedFontSize: $selectedFontSize, systemColor: $systemColor)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape").foregroundColor(systemColor.color)
                    }
                    .tag(1)
            }.accentColor(systemColor.color)
        }
}

#Preview {
    HomeView()
}
