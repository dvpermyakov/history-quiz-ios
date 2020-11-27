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
        if let gameResult = viewModel.gameResult {
            Router.createTestResult(result: gameResult)
        } else if let question = viewModel.currentQuestion {
            VStack {
                QuestionGameView(question: question) { answer in
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

}

struct QuestionGameView: View {
    let question: Game.Question
    let answerTapHandler: (Game.Answer) -> Void

    var body: some View {
        VStack {
            QuestionView(question: self.question)
            VStack {
                ForEach(question.answers) { answer in
                    VStack {
                        AnswerView(answer: answer)
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
                    .cornerRadius(15)
                    .shadow(color: Color.gray, radius: 2)
        }.padding(50)
    }
}