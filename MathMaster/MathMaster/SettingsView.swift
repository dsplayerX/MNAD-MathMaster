//
//  SettingsView.swift
//  MathMaster
//
//  Created by Dumindu Sameendra on 2024-10-09.
//

import SwiftUI

enum AppTheme : String, CaseIterable {
    case blue = "Blue"
    case red = "Red"
    case orange = "Orange"
    case green = "Green"
    
    var color: Color {
            switch self {
            case .blue: return .blue
            case .red: return .red
            case .orange: return .orange
            case .green: return .green
            }
    }
}

struct SettingsView: View {
    @Binding var selectedFontSize: CGFloat
    @Binding var systemColor: AppTheme

    var body: some View {
            NavigationStack {
                VStack(spacing: 20) {
                    Text("Font Size: \(Int(selectedFontSize))px")
                        .font(.headline)
                    Slider(value: $selectedFontSize, in: 8...24, step: 1)
                        .padding()
                    HStack {
                        Text("System Color")
                            .font(.headline)
                        Picker("", selection: $systemColor) {
                            ForEach(AppTheme.allCases, id: \.self){ theme in
                                Text(theme.rawValue)
                            }
                        }.pickerStyle(.wheel)
                        
                        Color(systemColor.rawValue).frame(width: 30, height: 30)
                    }.padding()                    
                }
                .navigationTitle(Text("Settings"))
            }
        }
}

#Preview {
    SettingsView(selectedFontSize: .constant(16), systemColor: .constant(.blue))
}
