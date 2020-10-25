//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct GameDto: Codable {
    let questions: [QuestionDto]
}

struct QuestionDto: Codable {
    let id: String
    let text: String
    let answers: [AnswerDto]
}

struct AnswerDto: Codable {
    let id: String
    let text: String
    let correct: Bool
}