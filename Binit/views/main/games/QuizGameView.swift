//
//  QuizGameView.swift
//  Binit
//
//  Created by Nikita on 09.10.2023.
//

import SwiftUI

struct QuizGameView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let questions: [QuizObject]
    
    @State private var gameQuestions: [QuizObject] = []
    
    @State private var starsCount: Int = 0
    
    @State private var currentQuestionNumber: Int = 1
    
    @State private var currentItem: AnswerObject? = nil
    @State private var showExplainDialog: Bool = false
    
    @State private var showResultsDialog: Bool = false
    
    let arrowBackIcon = "ic_back_circle_arrow"
    let startIcon = "ic_start"
    let backImage = "ic_quiz_game_back"
    
    var body: some View {
        ZStack (alignment: .top) {
          
            TopBarView
            
            VStack {
                
                
                Spacer()
                
                if showResultsDialog {
                    ResultsDialogView(count: starsCount, callback: {
                        self.startAgain()
                    })
                } else if showExplainDialog {
                    if let item = currentItem {
                        ExplainDialogView(item: item, callback: {
                            goToNext()
                            showExplainDialog = false
                            currentItem = nil
                        })
                    }
                } else {
                    if gameQuestions.count > 0 {
                        QuestionDialog
                    }
                }
                
                Spacer()
            }
            
            
        }
        .background(
            Image(backImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .offset(x: 380)
        )
        .navigationBarBackButtonHidden()
        .onAppear {
            gameQuestions.append(contentsOf: questions)
        }
    }
    
    private var TopBarView: some View {
        HStack (alignment: .center) {
            Button(action: {
                dismiss()
            }, label: {
                Image(arrowBackIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            })
            
            Spacer()
            
            Image(startIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text("\(starsCount)")
                .font(.custom(FontUtils.FONT_BOLD, size: 24))
                .foregroundColor(.white)
        }
        .padding()
        
    }
    
    private var QuestionDialog: some View {
        VStack {
            Text("\(currentQuestionNumber)")
                .font(.custom(FontUtils.FONT_REGULAR, size: 18))
                .foregroundColor(.orangeColor) +
            Text("/5").font(.custom(FontUtils.FONT_REGULAR, size: 18))
                .foregroundColor(.mainColor)
            
            Text("\(gameQuestions[currentQuestionNumber - 1].question)")
                .font(.custom(FontUtils.FONT_SEMIBOLD, size: 18))
                .foregroundColor(.mainColor)
                .multilineTextAlignment(.center)
                .padding(.vertical, 10)
            
            VStack {
                ForEach(gameQuestions[currentQuestionNumber - 1].answers) { answer in
                    AnswerButton(answer: answer, callback: { isCorrect in
                        if (isCorrect) {
                            starsCount += 1
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                goToNext()
                            })
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                if (!answer.explanation.isEmpty) {
                                    currentItem = answer
                                    showExplainDialog = true
                                } else {
                                    goToNext()
                                }
                            })
                        }
                    })
                        .padding(.top, 5)
                }
            }
            
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .padding()
        .padding(.top, 50)
    }
    
    func goToNext() {
        if (gameQuestions.count > currentQuestionNumber) {
            currentQuestionNumber += 1
        } else {
            if (gameQuestions.count == currentQuestionNumber) {
                showResultsDialog = true
            } else {
                showExplainDialog = true
            }
        }
    }
    
    func startAgain() {
        starsCount = 0
        currentQuestionNumber = 1
        showExplainDialog = false
        showResultsDialog = false
        gameQuestions.removeAll()
        gameQuestions.append(contentsOf: GameUtils.shared.getBatchOfQuestions())
    }
}

struct QuizGameView_Previews: PreviewProvider {
    static var previews: some View {
        QuizGameView(questions: [
            QuizObject(question: "Which of the following items should be sorted into the \"Recycle\" bin?", answers: [
                AnswerObject(answer: "a) Plastic bottles", explanation: "", isCorrect: true),
                AnswerObject(answer: "b) Soiled pizza box", explanation: "Laaal", isCorrect: false),
                AnswerObject(answer: "c) Food scraps", explanation: "", isCorrect: false),
                AnswerObject(answer: "d) Soiled paper towels", explanation: "", isCorrect: false),
            ])
        ])
    }
}

struct AnswerButton: View {
    
    let answer: AnswerObject
    let callback: (Bool) -> Void
    
    @State private var clicked: Bool = false
    
    let correctIcon = "ic_game_correct"
    let wrongIcon = "ic_game_wrong"
    
    var body: some View {
        Button(action: {
            clicked.toggle()
            callback(answer.isCorrect)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                clicked.toggle()
            })
        }, label: {
            HStack (alignment: .center) {
                Text("\(answer.answer)")
                    .font(.custom(FontUtils.FONT_REGULAR, size: 18))
                    .foregroundColor(clicked ? .white : .mainColor)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(answer.isCorrect ? correctIcon : wrongIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .padding()
        })
        .background(
            RoundedRectangle(cornerRadius: 6)
                .strokeBorder(Color.gray.opacity(0.2), lineWidth: 1)
                .background(clicked ? answer.isCorrect ? Color.correctColor : Color.wrongColor : Color.white)
                .cornerRadius(6)
        )
        
    }
}

struct ExplainDialogView: View {
    
    let item: AnswerObject
    let callback: () -> Void
    
    var body: some View {
        VStack (alignment: .center) {
            Text(item.isCorrect ? LocalizedStringKey("Good_to_know") : LocalizedStringKey("Oooops"))
                .font(.custom(FontUtils.FONT_SEMIBOLD, size: 20))
                .foregroundColor(item.isCorrect ? .correctColor : .wrongColor)
            
            Text(item.explanation)
                .multilineTextAlignment(.center)
                .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                .foregroundColor(.mainColor)
                .padding(.vertical, 5)
            
            Button(action: {
                callback()
            }, label: {
                Text(LocalizedStringKey("Got_it"))
                    .font(.custom(FontUtils.FONT_SEMIBOLD, size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                    .padding(.vertical, PaddingConsts.pDefaultPadding10)
            })
            .background(item.isCorrect ? Color.correctColor : Color.wrongColor)
            .cornerRadius(6)
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .padding()
    }
}

struct ResultsDialogView: View {
    
    let count: Int
    let callback: () -> Void
    
    let startIcon = "ic_start"
    
    var body: some View {
        VStack (alignment: .center) {
            
            Text("\(count)/5")
                .font(.custom(FontUtils.FONT_BOLD, size: 18))
                .foregroundColor(.orangeColor)
            
            if (count >= 1) {
                HStack {
                    Spacer()
                    ForEach((0...count - 1), id: \.self){ _ in
                        Image(startIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    Spacer()
                }
            }
            
            Text(GameUtils.shared.getCongratsTextBasedOnScore(score: count))
                .font(.custom(FontUtils.FONT_SEMIBOLD, size: 16))
                .foregroundColor(.mainColor)
            
            Text(GameUtils.shared.getCongratsSubsTextBasedOnScore(score: count))
                .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                .foregroundColor(.mainColor)
                .padding(.vertical, 5)
            
            Button(action: {
                callback()
            }, label: {
                Text(LocalizedStringKey("Play_again"))
                    .font(.custom(FontUtils.FONT_SEMIBOLD, size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                    .padding(.vertical, PaddingConsts.pDefaultPadding10)
            })
            .background(Color.orangeColor)
            .cornerRadius(6)
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
        .padding()
    }
}
