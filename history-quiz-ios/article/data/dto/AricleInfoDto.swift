//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct ArticleInfoDto: Codable {
    let id: String
    let category: String
    let name: String
    let description: String
    let image: String
}