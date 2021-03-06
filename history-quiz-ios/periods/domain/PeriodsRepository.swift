//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

protocol PeriodsRepository {
    func getPeriods() -> AnyPublisher<[Period], Error>
}
