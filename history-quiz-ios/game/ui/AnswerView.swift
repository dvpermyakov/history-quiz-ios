//
// Created by Dmitrii Permiakov on 11/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

enum AnswerType {
    case unknown
    case wrong
    case right
}

extension AnswerType {
    var backgroundColor: Color {
        switch self {
        case .unknown:
            return Color.white
        case .wrong:
            return Color.red
        case .right:
            return Color.green
        }
    }

    var textColor: Color {
        switch self {
        case .unknown:
            return Color.black
        case .wrong:
            return Color.white
        case .right:
            return Color.white
        }
    }
}

struct AnswerView: View {
    let answer: Game.Answer
    let type: AnswerType

    var body: some View {
        Text(answer.text)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.system(size: 20))
                .lineLimit(nil)
                .padding(10)
                .foregroundColor(type.textColor)
                .background(type.backgroundColor)
    }
}