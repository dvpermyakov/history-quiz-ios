//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation
import CoreData

extension TransactionEntity {
    func map() -> Transaction {
        let type = Transaction.TransactionType(rawValue: Int(self.type))!
        return Transaction(
                id: self.id!,
                amount: Int(self.amount),
                date: self.date!,
                type: type
        )
    }
}

extension Transaction {
    func setEntity(for context: NSManagedObjectContext) {
        let entity = TransactionEntity(context: context)
        entity.id = self.id
        entity.amount = Int32(self.amount)
        entity.date = self.date
        entity.type = Int32(self.type.rawValue)
    }
}