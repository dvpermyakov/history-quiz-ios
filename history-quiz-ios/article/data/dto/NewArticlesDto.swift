//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct NewArticlesDto: Decodable {
    let persons: [PersonDto]
    let events: [EventDto]
}
