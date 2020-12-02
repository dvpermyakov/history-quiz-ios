//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct UserDto: Codable {
    let id: String
    let name: String
    let image: String
    let test_done_amount: Int
}