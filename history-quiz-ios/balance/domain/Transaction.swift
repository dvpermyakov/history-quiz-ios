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
        case .Unknown:
            return "Unknown".localized()
        }
    }
}