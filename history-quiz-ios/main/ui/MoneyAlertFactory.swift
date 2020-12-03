//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

class MoneyAlertFactory {

    static func createMoneyAlert(_ awardInfo: AwardInfo?) throws -> Alert {
        guard let awardInfo = awardInfo else {
            Swift.fatalError()
        }
        return Alert(
                title: Text(awardInfo.title),
                message: Text(awardInfo.description),
                dismissButton: Alert.Button.default(Text(awardInfo.confirmButton))
        )
    }

}
