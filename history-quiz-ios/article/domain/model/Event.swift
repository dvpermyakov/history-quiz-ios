//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct Event : Identifiable, Hashable, ArticleAvailable, ArticleDescription {
    let id: String
    let category: String
    let created: Date
    let name: String
    let description: String
    let image: String
    let yearTitle: String
}
