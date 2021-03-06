//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct PersonDto: Codable {
    let id: String
    let category: String
    let created: String
    let name: String
    let description: String
    let image: String
    let year_title: String
    let person_titles: [PersonTitleDto]
}

struct PersonTitleDto: Codable {
    let name: String
    let year_title: String
}