//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ParagraphsView: View {
    let text: ArticleText
    let haveRead: Bool
    let onReadClick: () -> Void
    let moveToTestInfo: () -> Void
    let startTest: () -> Void

    @State
    private var showingReadArticle = false

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(text.paragraphs) { paragraph in
                VStack(alignment: .leading) {
                    Text(paragraph.title)
                            .font(Font.system(.body))
                            .bold()
                    Group {
                        if let url = paragraph.image, !url.isEmpty {
                            KFImage(URL(string: url))
                                    .placeholder {
                                        ProgressView()
                                    }
                                    .resizable()
                                    .scaledToFit()
                        }
                    }
                    ParagraphTextView(
                            paragraphTexts: paragraph.text.parse()
                    )
                }.padding()
            }
            Button(action: {
                onReadClick()
                self.showingReadArticle = true
            }) {
                Text("I have read the article").asSimpleButton(buttonColor)
            }
                    .disabled(haveRead)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity, alignment: .center)
        }
                .actionSheet(isPresented: $showingReadArticle) {
                    ActionSheet(
                            title: Text("You have read this article!"),
                            message: Text("Would you like to start test of this article?"),
                            buttons: [
                                .default(Text("Move to test information"), action: moveToTestInfo),
                                .default(Text("Start test"), action: startTest),
                                .cancel()
                            ]
                    )
                }
    }

    private var buttonColor: Color {
        if haveRead {
            return Color.gray
        } else {
            return Color.blue
        }
    }
}

extension String {
    func parse() -> [ParagraphText] {
        var result = [ParagraphText]()
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: "<a href=\"app\\.opened:\\/\\/mark\\?id=(\\d*)&cat=(\\d)\">(.*?)<\\/a>")
        var lastIndex = 0
        regex.matches(in: self, range: range).forEach { match in
            result.append(
                    ParagraphText.Text(
                            value: self.substring(
                                    lastIndex,
                                    match.range(at: 0).lowerBound
                            )
                    )
            )
            result.append(
                    ParagraphText.Link(
                            value: self.substring(
                                    match.range(at: 3).lowerBound,
                                    match.range(at: 3).upperBound
                            ),
                            articleId: self.substring(
                                    match.range(at: 1).lowerBound,
                                    match.range(at: 1).upperBound
                            ),
                            articleCategory: self.substring(
                                    match.range(at: 2).lowerBound,
                                    match.range(at: 2).upperBound
                            )
                    )
            )
            lastIndex = match.range(at: 0).upperBound
        }
        result.append(
                ParagraphText.Text(
                        value: self.substring(lastIndex, self.count - 1)
                )
        )
        return result
    }
}

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
    var paragraphTexts: [ParagraphText]

    var body: some View {
        VStack {
            paragraphTexts.map { paragraphText in
                switch paragraphText {
                case .Text(value: let value):
                    return Text(value)
                            .font(Font.system(.body))
                            .foregroundColor(Color.black)
                case .Link(value: let value, articleId: _, articleCategory: _):
                    return Text(value)
                            .font(Font.system(.body))
                            .foregroundColor(Color.blue)
                            .underline()
                }
            }.reduce(Text(""), +)
        }
    }
}