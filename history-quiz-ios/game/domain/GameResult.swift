//
// Created by Dmitrii Permiakov on 11/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct GameResult: Equatable {
    let test: Test
    let questionsAnswered: Int
    let timeConsumed: Int
    let mistakesMade: Int
}