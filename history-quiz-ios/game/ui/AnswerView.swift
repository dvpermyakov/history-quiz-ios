//
// Created by Dmitrii Permiakov on 11/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct AnswerView: View {
    let answer: Game.Answer

    var body: some View {
        Text(answer.text)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.system(size: 20))
                .lineLimit(nil)
                .padding(10)
    }
}