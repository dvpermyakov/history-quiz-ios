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
        if let question = viewModel.currentQuestion {
            QuestionGameView(question: question) { answer in
                self.viewModel.setAnswer(answer: answer)
            }
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
                    AnswerView(answer: answer)
                            .onTapGesture {
                                answerTapHandler(answer)
                            }
                }
            }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(20)
        }.padding(50)
    }
}

struct QuestionView: View {
    let question: Game.Question

    var body: some View {
        Text(question.text)
                .font(.largeTitle)
                .padding(30)
    }
}

struct AnswerView: View {
    let answer: Game.Answer

    var body: some View {
        Text(answer.text)
                .font(.caption)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(20)
    }
}