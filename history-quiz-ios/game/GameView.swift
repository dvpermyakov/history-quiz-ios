//
//  ContentView.swift
//  history-quiz-ios
//
//  Created by Dmitrii Permiakov on 10/8/20.
//  Copyright © 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

public struct GameView: View {
    var viewModel = GameViewModel()

    private var question: Game.Question {
        viewModel.currentQuestion
    }
    public var body: some View {
        VStack {
            QuestionView(question: self.question)
            VStack {
                ForEach(0..<self.question.answers.count) { index in
                    AnswerView(answer: self.question.answers[index])
                            .onTapGesture {
                                self.viewModel.setAnswer(answer: self.question.answers[index])
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
    var question: Game.Question

    var body: some View {
        Text(question.text)
                .font(.largeTitle)
                .padding(30)
    }
}

struct AnswerView: View {
    var answer: Game.Question.Answer

    var body: some View {
        Text(answer.text)
                .font(.caption)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
