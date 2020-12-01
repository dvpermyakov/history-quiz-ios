//
//  ContentView.swift
//  history-quiz-ios
//
//  Created by Dmitrii Permiakov on 10/8/20.
//  Copyright © 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @ObservedObject
    var viewModel: GameViewModel

    var body: some View {
        Group {
            if let gameResult = viewModel.gameResult {
                GameResultView(result: gameResult).environmentObject(viewModel)
            } else if let question = viewModel.currentQuestion {
                VStack {
                    QuestionGameView(
                            question: question,
                            wrongAnswers: viewModel.wrongAnswers,
                            rightAnswer: viewModel.rightAnswer
                    ) { answer in
                        self.viewModel.setAnswer(answer: answer)
                    }
                    Spacer()
                    GamePanelView(uiModel: PanelUiModel(
                            questionNumber: viewModel.questionNumber,
                            questionMax: viewModel.questionMax,
                            secondLeft: viewModel.secondsLeft,
                            mistakesLeft: viewModel.mistakeLeft
                    ))
                }.frame(maxHeight: .infinity)
            } else {
                ProgressView()
            }
        }
                .onDisappear {
                    viewModel.restartGame()
                }
                .navigationBarTitle("Test")
                .navigationBarTitleDisplayMode(.inline)
    }

}

struct QuestionGameView: View {
    let question: Game.Question
    let wrongAnswers: [Game.Answer]
    let rightAnswer: Game.Answer?
    let answerTapHandler: (Game.Answer) -> Void

    var body: some View {
        VStack {
            QuestionView(question: self.question)
            VStack {
                ForEach(question.answers) { answer in
                    VStack {
                        AnswerView(
                                answer: answer,
                                type: getAnswerType(answer: answer)
                        )
                                .onTapGesture {
                                    answerTapHandler(answer)
                                }
                        Divider()
                    }
                }
            }
                    .padding(.top, 10)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.white)
                    .asCard()
        }.padding(50)
    }

    func getAnswerType(answer: Game.Answer) -> AnswerType {
        if answer == rightAnswer {
            return AnswerType.Right
        }
        if wrongAnswers.firstIndex(of: answer) != nil {
            return AnswerType.Wrong
        }
        return AnswerType.Unknown
    }
}