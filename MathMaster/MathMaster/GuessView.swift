import SwiftUI

struct GuessView: View {
    @Binding var fontSize: CGFloat
    @Binding var systemColor:  AppTheme

    @State private var selectedIndex: Int = 0
    @State private var userAnswer = ""
    @State private var question = ""
    @State private var correctAnswer = 0
    @State private var points = 0
    @State private var feedback = ""
    @State private var isCorrect: Bool? = nil
    @State private var buttonDisabled: Bool = false
    @State private var answeredCorrectly: Bool = false


    // Enum for mathematical operators
    enum Operator: String, CaseIterable {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "x"
        case division = "/"
        
        // Perform the operation
        func perform(_ num1: Int, _ num2: Int) -> Int {
            switch self {
            case .addition:
                return num1 + num2
            case .subtraction:
                return num1 - num2
            case .multiplication:
                return num1 * num2
            case .division:
                return num1 / (num2 == 0 ? 1 : num2) // Handle division by zero
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Title
                Text("Guess the answer!")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(systemColor.color)
                    .padding(.top, 20)

                // Question display
                Text(question)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.black)
                    .padding()

                // Answer input
                HStack {
                    TextField("Answer", text: $userAnswer)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                        .padding()

                    Button(action:{
                        checkAnswer()
                        userAnswer = ""
                        buttonDisabled = true
                    }) {
                        Text("Submit")
                            .frame(width: 80, height: 40)
                            .background(userAnswer.isEmpty || buttonDisabled ? Color.gray.opacity(0.2) : systemColor.color.opacity(0.2))
                            .foregroundColor(userAnswer.isEmpty || buttonDisabled ? Color.gray : systemColor.color)
                            .cornerRadius(8)
                    }
                    .disabled(userAnswer.isEmpty || buttonDisabled)
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
                    .foregroundColor(Color.black)

                // Instructions text
                Text("Instructions").font(.system(size: fontSize))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                Text("Submit the correct answer and gain 1 point. Submit a wrong answer or press on \"NEXT\" without an answer to lose 1 point.")
                    .font(.system(size: fontSize))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

                // Next Button
                Button(action: {
                    if userAnswer.isEmpty && !answeredCorrectly {
                        points = max(points - 1, 0) // Decrease points only if no answer and previous answer was wrong
                    }
                    answeredCorrectly = false // Reset for the next round
                    userAnswer = ""
                    feedback = ""
                    isCorrect = nil
                    buttonDisabled = false // Re-enable the button for the next question
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
            .onAppear(perform: generateQuestion).navigationTitle("Math Master")
        }
    }

    // Function to generate a new math question
    func generateQuestion() {
        let num1 = Int.random(in: 1...10)
        let num2 = Int.random(in: 1...10)
        let op = Operator.allCases.randomElement()!

        // Generate the correct answer using the selected operator
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
            answeredCorrectly = false
        }
    }
}

#Preview {
    GuessView(fontSize: .constant(16), systemColor: .constant(.blue))
}
