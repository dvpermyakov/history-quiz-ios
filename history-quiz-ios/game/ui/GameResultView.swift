//
// Created by Dmitrii Permiakov on 11/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct GameResultView: View {
    var result: GameResult

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Result").padding(.bottom, 10)
                CommonListView(model: CommonListUiModel(list: [
                    CommonListUiModel.Item(name: "Question answered".localized(), value: "\(result.questionsAnswered)/\(result.test.questionAmount)"),
                    CommonListUiModel.Item(name: "Time spent".localized(), value: "\(result.timeConsumed)/\(result.test.seconds)"),
                    CommonListUiModel.Item(name: "Mistakes".localized(), value: "\(result.mistakesMade)/\(result.test.mistakesAmount)")
                ]))
            }.padding()
        }
    }
}
