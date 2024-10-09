//
//  ContentView.swift
//  MathMaster
//
//  Created by Dumindu Sameendra on 2024-10-09.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
                    NavigationStack() {
                        Text("Guess content here!")
                            .navigationTitle("Guess the answer!")
                    }
                    .tabItem {
                        Text("Guess")
                        Image(systemName: "house.fill")
                            .renderingMode(.template)
                    }
                    .tag(0)
                    
                    NavigationStack() {
                        Text("Settings")
                            .navigationTitle("Settings")
                    }
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                    .tag(1)
            
        }
    }
}

#Preview {
    ContentView()
}
