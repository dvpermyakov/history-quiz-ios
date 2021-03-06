//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct Person: Identifiable, Hashable, ArticleAvailable, ArticleDescription {
    let id: String
    let category: String
    let created: Date
    let name: String
    let description: String
    let image: String
    let yearTitle: String
    let personTitles: [PersonTitle]
}

struct PersonTitle: Hashable {
    let name: String
    let yearTitle: String
}
