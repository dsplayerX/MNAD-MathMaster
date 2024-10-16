//
//  HomeView.swift
//  MathMaster
//
//  Created by Dumindu Sameendra on 2024-10-09.
//

import SwiftUI

struct HomeView: View {
    @StateObject var gameViewModel = GameViewModel()

    var body: some View {
        TabView {
            GuessView(gameViewModel: gameViewModel)
                .tabItem {
                    Label("Guess", systemImage: "checkmark.seal.fill").foregroundColor(gameViewModel.systemColor.color)
                }
                .tag(0)

            SettingsView(gameViewModel: gameViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gearshape").foregroundColor(gameViewModel.systemColor.color)
                }
                .tag(1)
        }
        .accentColor(gameViewModel.systemColor.color)
    }
}

#Preview {
    HomeView()
}
