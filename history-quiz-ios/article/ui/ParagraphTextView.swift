//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

enum ParagraphText: Hashable {
    case text(
            value: String
    )
    case link(
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
                case let .text(value):
                    return Text(value)
                            .font(Font.system(.body))
                            .foregroundColor(Color.black)
                case let .link(value, _, _):
                    return Text(value)
                            .font(Font.system(.body))
                            .foregroundColor(Color.blue)
                            .underline()
                }
            }.reduce(Text(""), +)
        }.onTapGesture(perform: {
            if let firstLink = paragraphTexts.first(where: { text in
                switch text {
                case .text:
                    return false
                case .link:
                    return true
                }
            }) {
                if case let .link(_, articleId, articleCategory) = firstLink {
                    onLinkTap(articleId, articleCategory)
                }
            }
        })
    }
}