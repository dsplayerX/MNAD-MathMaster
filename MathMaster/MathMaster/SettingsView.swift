//
//  SettingsView.swift
//  MathMaster
//
//  Created by Dumindu Sameendra on 2024-10-09.
//

import SwiftUI

struct SettingsView: View {
    @Binding var selectedFontSize: CGFloat
        @Binding var selectedColor: Color

        var body: some View {
            NavigationStack {
                VStack(spacing: 20) {
                    Text("Font Size: \(Int(selectedFontSize))")
                        .font(.headline)
                    Slider(value: $selectedFontSize, in: 8...32, step: 1)
                        .padding()

                    Text("Select Color")
                        .font(.headline)

                    ColorPicker("System Color", selection: $selectedColor)
                        .padding()
                }
                .navigationTitle(Text("Settings").foregroundColor(selectedColor))
            }
        }
}

#Preview {
    SettingsView(selectedFontSize: .constant(24), selectedColor: .constant(Color.primary))
}
