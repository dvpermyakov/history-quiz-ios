//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct PeriodsDto : Codable {
    let periods: [PeriodDto]
}

struct PeriodDto : Codable {
    let id: String
    let name: String
    let image: String
    let group_title: String
    let year_title: String
    let developing: Bool
}
