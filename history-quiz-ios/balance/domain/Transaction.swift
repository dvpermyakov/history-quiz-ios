//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

struct Transaction: Identifiable, Hashable {
    let id: UUID
    let amount: Int
    let date: Date
    let type: TransactionType

    enum TransactionType: Int {
        case dailyAward = 0
        case articleRead = 1
        case startAward = 2
        case articleOpened = 3
    }
}

extension Transaction {
    var typeTitle: String {
        switch self.type {
        case .dailyAward:
            return "Daily bonus".localized()
        case .articleRead:
            return "Read article".localized()
        case .startAward:
            return "Start bonus".localized()
        case .articleOpened:
            return "Article opened".localized()
        }
    }

    static func create(_ type: Transaction.TransactionType) -> Transaction {
        Transaction(
                id: UUID(),
                amount: type.amount,
                date: Date(),
                type: type
        )
    }
}

extension Transaction.TransactionType {
    var amount: Int {
        switch self {
        case .dailyAward:
            return 30
        case .articleRead:
            return 5
        case .startAward:
            return 50
        case .articleOpened:
            return 5
        }
    }
}