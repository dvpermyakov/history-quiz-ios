//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import CoreData

class BalanceRepositoryImpl: BalanceRepository {
    private let LAST_DAILY_AWARD_KEY = "LAST_DAILY_AWARD_KEY"

    var lastDailyAwardDate: Date? {
        get {
            UserDefaults.standard.value(forKey: LAST_DAILY_AWARD_KEY) as? Date
        }
        set {
            if let value = newValue {
                UserDefaults.standard.set(value, forKey: LAST_DAILY_AWARD_KEY)
            }
        }
    }

    func createTransaction(value transaction: Transaction) -> Bool {
        guard let context = getContext() else {
            return false
        }
        transaction.setEntity(for: context)
        try? context.save()

        return true
    }

    func getAllTransactions() -> [Transaction] {
        guard let context = getContext() else {
            return []
        }
        let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        return try! context.fetch(request).map { entity in
            let x = (entity as TransactionEntity)
            print(x.amount)
            return x.map()
        }
    }

    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }

}