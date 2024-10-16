import SwiftUI

struct GuessView: View {
    @ObservedObject var gameViewModel: GameViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Title
                Text("Guess the answer!")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(gameViewModel.systemColor.color)
                    .padding(.top, 20)

                // Question display
                Text(gameViewModel.question)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.black)
                    .padding()

                // Answer input
                HStack {
                    TextField("Answer", text: $gameViewModel.userAnswer)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 200)
                        .padding()

                    Button(action:{
                        gameViewModel.checkAnswer()
                    }) {
                        Text("Submit")
                            .frame(width: 80, height: 40)
                            .background(gameViewModel.userAnswer.isEmpty || gameViewModel.buttonDisabled ? Color.gray.opacity(0.2) : gameViewModel.systemColor.color.opacity(0.2))
                            .foregroundColor(gameViewModel.userAnswer.isEmpty || gameViewModel.buttonDisabled ? Color.gray : gameViewModel.systemColor.color)
                            .cornerRadius(8)
                    }
                    .disabled(gameViewModel.userAnswer.isEmpty || gameViewModel.buttonDisabled)
                }

                // Feedback message
                if let isCorrect = gameViewModel.isCorrect {
                    HStack {
                        Image(systemName: isCorrect ? "checkmark.circle" : "xmark.circle")
                            .foregroundColor(isCorrect ? .green : .red)
                        Text(gameViewModel.feedback)
                            .foregroundColor(isCorrect ? .green : .red)
                            .font(.system(size: 18, weight: .semibold))
                    }
                }

                // Points display
                Text("\(gameViewModel.points)")
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(Color.black)

                // Instructions text
                Text("Instructions").font(.system(size: gameViewModel.selectedFontSize))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                Text("Submit the correct answer and gain 1 point. Submit a wrong answer or press on \"NEXT\" without an answer to lose 1 point.")
                    .font(.system(size: gameViewModel.selectedFontSize))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

                // Next Button
                Button(action: {
                    gameViewModel.nextQuestion()
                }) {
                    Text("NEXT")
                        .frame(width: 120, height: 40)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .cornerRadius(8)
                }
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    GuessView(gameViewModel: GameViewModel())
}
