//
// Created by Dmitrii Permiakov on 10/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

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

}