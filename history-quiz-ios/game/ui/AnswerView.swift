//
// Created by Dmitrii Permiakov on 11/27/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

enum AnswerType {
    case Unknown
    case Wrong
    case Right
}

extension AnswerType {
    var backgroundColor: Color {
        switch self {
        case .Unknown:
            return Color.white
        case .Wrong:
            return Color.red
        case .Right:
            return Color.green
        }
    }

    var textColor: Color {
        switch self {
        case .Unknown:
            return Color.black
        case .Wrong:
            return Color.white
        case .Right:
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