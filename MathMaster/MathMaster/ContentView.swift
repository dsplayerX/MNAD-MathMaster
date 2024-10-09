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
    @State private var isCorrect: Bool? = nil // To track if the answer was correct
    
    let operators = ["+", "-", "*", "/"]

    var body: some View {
        TabView(selection: $selectedIndex) {
            // Guess tab
            NavigationStack() {
                VStack(spacing: 20) {
                    // Title
                    Text("Guess the answer!")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color.blue)
                        .padding(.top, 20)

                    // Question display
                    Text(question)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(systemColor)
                        .padding()

                    // Answer input
                    HStack {
                        TextField("Answer", text: $userAnswer)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                            .padding()

                        Button(action: checkAnswer) {
                            Text("Submit")
                                .frame(width: 80, height: 40)
                                .background(systemColor.opacity(0.2))
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                        }
                        .disabled(userAnswer.isEmpty)
                    }

                    // Feedback message
                    if let isCorrect = isCorrect {
                        HStack {
                            Image(systemName: isCorrect ? "checkmark.circle" : "xmark.circle")
                                .foregroundColor(isCorrect ? .green : .red)
                            Text(feedback)
                                .foregroundColor(isCorrect ? .green : .red)
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }

                    // Points display
                    Text("\(points)")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundColor(systemColor)

                    // Instructions text
                    Text("Submit the correct answer and gain 1 point. Submit a wrong answer or press on \"NEXT\" and you will lose 1 point")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    // Next Button
                    Button(action: {
                        userAnswer = ""
                        feedback = ""
                        isCorrect = nil
                        generateQuestion()
                    }) {
                        Text("NEXT")
                            .frame(width: 120, height: 40)
                            .background(Color.green.opacity(0.2))
                            .foregroundColor(.green)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 20)
                }
                .navigationTitle("Guess the answer!")
                .onAppear(perform: generateQuestion)
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
            isCorrect = true
        } else {
            feedback = "Incorrect answer! The actual answer is \(correctAnswer)"
            points = max(points - 1, 0) // Avoid negative points
            isCorrect = false
        }
    }
}

#Preview {
    ContentView()
}

