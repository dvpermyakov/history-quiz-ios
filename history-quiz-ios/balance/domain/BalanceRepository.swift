//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

protocol BalanceRepository {
    var lastDailyAwardDate: Date? { get set }

    func createTransaction(value: Transaction) -> Bool

    func getAllTransactions() -> AnyPublisher<[Transaction], Never>
}
