//
//  SettingsView.swift
//  MathMaster
//
//  Created by Dumindu Sameendra on 2024-10-09.
//

import SwiftUI

struct SettingsView: View {
    @State private var fontSize: CGFloat = 24
    @State private var systemColor = Color.primary

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Font Size: \(Int(fontSize))")
                    .font(.headline)
                Slider(value: $fontSize, in: 16...40, step: 1)
                    .padding()

                Text("Select Color")
                    .font(.headline)

                ColorPicker("System Color", selection: $systemColor)
                    .padding()
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
