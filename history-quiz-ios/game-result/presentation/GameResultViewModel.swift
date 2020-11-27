//
// Created by Dmitrii Permiakov on 11/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

class GameResultViewModel: ObservableObject {
    @Published
    var resultInfo: CommonListUiModel

    init(result: GameResult) {
        self.resultInfo = CommonListUiModel(list: [
            CommonListUiModel.Item(name: "Question answered".localized(), value: "\(result.questionsAnswered)/\(result.test.questionAmount)"),
            CommonListUiModel.Item(name: "Time spent".localized(), value: "\(result.timeConsumed)/\(result.test.seconds)"),
            CommonListUiModel.Item(name: "Mistakes".localized(), value: "\(result.mistakesMade)/\(result.test.mistakesAmount)")
        ])
    }
}