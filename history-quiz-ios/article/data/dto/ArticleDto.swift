//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct ArticleDto: Codable {
    let text: ArticleTextDto
    let test: TestDto
    let persons: [PersonDto]
    let events: [EventDto]
}

struct ArticleTextDto: Codable {
    let paragraphs: [ParagraphDto]
}

struct ParagraphDto: Codable {
    let header: String
    let text: String
    let image: String?
}

struct TestDto: Codable {
    let id: String
    let max_questions: Int
    let max_mistakes: Int
    let max_seconds: Int
}