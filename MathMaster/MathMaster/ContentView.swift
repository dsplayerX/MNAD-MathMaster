// ContentView.swift
// MathMaster
//
// Created by Dumindu Sameendra on 2024-10-09.

import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int = 0
    @State private var userAnswer = ""
    @State private var question = ""
    @State private var correctAnswer = 0
    @State private var points = 0
    @State private var fontSize: CGFloat = 24 // Default font size
    @State private var systemColor = Color.primary // Default color scheme
    @State private var feedback = ""
    let operators = ["+", "-", "*", "/"]

    var body: some View {
        TabView(selection: $selectedIndex) {
            // Guess tab
            NavigationStack() {
                VStack(spacing: 20) {
                    Text(question)
                        .font(.system(size: fontSize))
                        .foregroundColor(systemColor)
                        .padding()
                        .onAppear(perform: generateQuestion)
                    
                    TextField("Enter your answer", text: $userAnswer)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: checkAnswer) {
                        Text("Submit")
                            .font(.system(size: fontSize))
                            .padding()
                            .background(systemColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Text(feedback)
                        .foregroundColor(systemColor)
                        .font(.system(size: fontSize))
                        .padding()
                    
                    Text("Points: \(points)")
                        .font(.system(size: fontSize))
                        .foregroundColor(systemColor)
                }
                .navigationTitle("Guess the answer!")
            }
            .tabItem {
                Text("Guess")
                Image(systemName: "house.fill")
                    .renderingMode(.template)
            }
            .tag(0)
            
            // Settings tab
            NavigationStack() {
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
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
            .tag(1)
        }
    }
    
    // Function to generate a new math question
    func generateQuestion() {
        let num1 = Int.random(in: 0...9)
        let num2 = Int.random(in: 1...9) // Avoid division by 0
        let op = operators.randomElement()!
        
        switch op {
        case "+":
            correctAnswer = num1 + num2
        case "-":
            correctAnswer = num1 - num2
        case "*":
            correctAnswer = num1 * num2
        case "/":
            correctAnswer = num1 / num2
        default:
            break
        }
        
        question = "\(num1) \(op) \(num2) = ?"
    }
    
    // Function to check if the user's answer is correct
    func checkAnswer() {
        if let userAnswerInt = Int(userAnswer), userAnswerInt == correctAnswer {
            feedback = "Correct! Well done!"
            points += 1
        } else {
            feedback = "Incorrect. The correct answer was \(correctAnswer)."
            points = max(points - 1, 0) // Avoid negative points
        }
        
        userAnswer = "" // Clear input
        generateQuestion() // Generate a new question
    }
}

#Preview {
    ContentView()
}
