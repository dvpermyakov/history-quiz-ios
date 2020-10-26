//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct Article {
    let text: ArticleText
    let test: Test
    let persons: [Person]
    let events: [Event]
}

struct ArticleText {
    let paragraphs: [Paragraph]
}

struct Paragraph: Identifiable, Hashable {
    var id: String {
        title
    }
    let title: String
    let text: String
    let image: String?
}

struct Test {
    let id: String
}