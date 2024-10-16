//
//  SettingsView.swift
//  MathMaster
//
//  Created by Dumindu Sameendra on 2024-10-09.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Font Size Slider
                Text("Font Size: \(Int(gameViewModel.selectedFontSize))px")
                    .font(.headline)
                Slider(value: $gameViewModel.selectedFontSize, in: 8...24, step: 1)
                    .padding()
                
                // System Color Picker
                HStack {
                    Text("System Color")
                        .font(.headline)
                    Picker("", selection: $gameViewModel.systemColor) {
                        ForEach(GameViewModel.AppTheme.allCases, id: \.self) { theme in
                            Text(theme.rawValue)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    // Display selected color
                    gameViewModel.systemColor.color
                        .frame(width: 30, height: 30)
                        .cornerRadius(15)
                        .padding(.leading, 10)
                }
                .padding()
            }
            .navigationTitle(Text("Settings"))
        }
    }
}

#Preview {
    SettingsView(gameViewModel: GameViewModel())
}
