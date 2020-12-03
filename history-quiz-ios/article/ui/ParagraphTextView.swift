//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

enum ParagraphText: Identifiable, Hashable {
    var id: String {
        switch self {
        case .Text(value: let value):
            return value
        case .Link(value: let value, articleId: _, articleCategory: _):
            return value
        }
    }
    case Text(
            value: String
    )
    case Link(
            value: String,
            articleId: String,
            articleCategory: String
    )
}

struct ParagraphTextView: View {
    let paragraphTexts: [ParagraphText]
    let onLinkTap: (String, String) -> Void

    var body: some View {
        VStack {
            paragraphTexts.map { paragraphText in
                switch paragraphText {
                case let .Text(value):
                    return Text(value)
                            .font(Font.system(.body))
                            .foregroundColor(Color.black)
                case let .Link(value, _, _):
                    return Text(value)
                            .font(Font.system(.body))
                            .foregroundColor(Color.blue)
                            .underline()
                }
            }.reduce(Text(""), +)
        }.onTapGesture(perform: {
            if let firstLink = paragraphTexts.first(where: { text in
                switch text {
                case .Text(_):
                    return false
                case .Link(_, _, _):
                    return true
                }
            }) {
                if case let .Link(_, articleId, articleCategory) = firstLink {
                    onLinkTap(articleId, articleCategory)
                }
            }
        })
    }
}