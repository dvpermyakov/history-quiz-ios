//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct EventDto: Codable {
    let id: String
    let category: String
    let created: String
    let name: String
    let description: String
    let image: String
    let year_title: String
}
