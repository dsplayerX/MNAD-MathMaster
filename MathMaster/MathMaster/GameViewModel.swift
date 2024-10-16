//
//  GameViewModel.swift
//  MathMaster
//
//  Created by Dumindu Sameendra on 2024-10-16.
//

import SwiftUI



class GameViewModel: ObservableObject {
    
    // -- Theming Related --
    // Enum for app theme
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

    // Store color and font size in appstoragee
    @AppStorage("selectedFontSize") var selectedFontSize: Double = 16
    @AppStorage("systemColor") private var storedSystemColor: String = AppTheme.blue.rawValue
        
    // Get color and font size from storage
    var systemColor: AppTheme {
        get { AppTheme(rawValue: storedSystemColor) ?? .blue }
        set { storedSystemColor = newValue.rawValue }
    }

    // -- Game Logic Related --
    // Game states
    @Published var selectedIndex: Int = 0
    @Published var userAnswer = ""
    @Published var question = ""
    @Published var correctAnswer = 0
    @Published var points = 0
    @Published var feedback = ""
    @Published var isCorrect: Bool? = nil
    @Published var buttonDisabled: Bool = false
    @Published var answeredCorrectly: Bool = false

    init() {
        generateQuestion()
    }
    
    // Enum for mathematical operators
    enum Operator: String, CaseIterable {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "x"
        case division = "/"
               
        func perform(_ num1: Int, _ num2: Int) -> Int {
            switch self {
            case .addition:
                return num1 + num2
            case .subtraction:
                return num1 - num2
            case .multiplication:
                return num1 * num2
            case .division:
                return num1 / (num2 == 0 ? 1 : num2)
            }
        }
    }

    // Function to generate a new math question
    func generateQuestion() {
        let num1 = Int.random(in: 1...10)
        let num2 = Int.random(in: 1...10)
        let op = Operator.allCases.randomElement()!
        correctAnswer = op.perform(num1, num2)
        question = "\(num1) \(op.rawValue) \(num2) = ?"
    }

    // Function to check if the user's answer is correct
    func checkAnswer() {
        if let userAnswerInt = Int(userAnswer), userAnswerInt == correctAnswer {
            feedback = "Correct! Well done!"
            points += 1
            isCorrect = true
            answeredCorrectly = true // Mark that the answer was correct
        } else {
            feedback = "Incorrect answer! The actual answer is \(correctAnswer)."
            points = max(points - 1, 0) // To avoid negative points
            isCorrect = false
            answeredCorrectly = false // Mark incorrect
        }
        userAnswer = ""
        buttonDisabled = true
    }

    // Function to move to the next question
    func nextQuestion() {
        if userAnswer.isEmpty && !answeredCorrectly {
            points = max(points - 1, 0) // Decrease points if no answer is given and previous answer was wrong
        }
        answeredCorrectly = false
        userAnswer = ""
        feedback = ""
        isCorrect = nil
        buttonDisabled = false
        generateQuestion()
    }
}
