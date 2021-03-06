//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

class BalanceRepositoryImpl: BalanceRepository {
    private let LAST_DAILY_AWARD_KEY = "LAST_DAILY_AWARD_KEY"

    func setLastDailyAwardDate(date: Date) {
        UserDefaults.standard.set(date, forKey: LAST_DAILY_AWARD_KEY)
    }

    func getLastDailyAwardDate() -> Date? {
        UserDefaults.standard.value(forKey: LAST_DAILY_AWARD_KEY) as? Date
    }

    func createTransaction(value: Transaction) -> AnyPublisher<Bool, Never> {
        Future<Bool, Never> { promise in
            guard let context = getBalanceContext() else {
                return promise(.success(false))
            }
            value.setEntity(for: context)
            try? context.save()

            return promise(.success(true))
        }.eraseToAnyPublisher()
    }

    func getAllTransactions() -> AnyPublisher<[Transaction], Never> {
        Future<[Transaction], Never> { promise in
            guard let context = getBalanceContext() else {
                return promise(.success([]))
            }
            let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
            request.predicate = NSPredicate(format: "TRUEPREDICATE")
            let transactions = try! context.fetch(request).map { entity in
                (entity as TransactionEntity).map()
            }
            return promise(.success(transactions))
        }.eraseToAnyPublisher()
    }

}