//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import Combine

protocol BalanceRepository {

    func setLastDailyAwardDate(date: Date)

    func getLastDailyAwardDate() -> Date?

    func createTransaction(value: Transaction) -> AnyPublisher<Bool, Never>

    func getAllTransactions() -> AnyPublisher<[Transaction], Never>
}
