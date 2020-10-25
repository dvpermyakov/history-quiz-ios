//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct Period: Identifiable, Hashable {
    let id: String
    let category: String
    let image: String
    let name: String
    let description: String
    let developing: Bool
}
