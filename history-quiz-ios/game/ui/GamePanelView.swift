//
// Created by Dmitrii Permiakov on 11/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct PanelUiModel {
    let questionNumber: Int
    let questionMax: Int
    let secondLeft: Int
    let mistakesLeft: Int
}

struct GamePanelView: View {
    let uiModel: PanelUiModel

    var body: some View {
        HStack {
            Image(systemName: "questionmark.circle")
            Text("\(uiModel.questionNumber) / \(uiModel.questionMax)").font(.system(size: 18))
            Spacer()
            Image(systemName: "timer")
            Text(String(uiModel.secondLeft)).font(.system(size: 18))
            Spacer()
            Image(systemName: "heart")
            Text(String(uiModel.mistakesLeft)).font(.system(size: 18))
        }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
    }

}