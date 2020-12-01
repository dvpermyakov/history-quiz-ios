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
        case DailyAward = 0
        case ArticleRead = 1
        case StartAward = 2
        case ArticleOpened = 3
        case Unknown = -1
    }
}

extension Transaction {
    var typeTitle: String {
        switch self.type {
        case .DailyAward:
            return "Daily bonus".localized()
        case .ArticleRead:
            return "Read article".localized()
        case .StartAward:
            return "Start bonus".localized()
        case .ArticleOpened:
            return "Article opened".localized()
        case .Unknown:
            return "Unknown".localized()
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
        case .DailyAward:
            return 30
        case .ArticleRead:
            return 5
        case .StartAward:
            return 50
        case .ArticleOpened:
            return 5
        default:
            return 0
        }
    }
}