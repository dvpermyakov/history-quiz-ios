//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ParagraphsView: View {
    @State
    private var showingReadArticle = false

    let text: ArticleText
    let haveRead: Bool
    let onReadClick: () -> Void
    let moveToTestInfo: () -> Void
    let startTest: () -> Void
    let onLinkTap: (String, String) -> Void

    init(
            text: ArticleText,
            haveRead: Bool,
            onReadClick: @escaping () -> Void,
            moveToTestInfo: @escaping () -> Void,
            startTest: @escaping () -> Void,
            onLinkTap: @escaping (String, String) -> Void
    ) {
        self.text = text
        self.haveRead = haveRead
        self.onReadClick = onReadClick
        self.moveToTestInfo = moveToTestInfo
        self.startTest = startTest
        self.onLinkTap = onLinkTap
    }

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
                            paragraphTexts: paragraph.text.parse(),
                            onLinkTap: onLinkTap
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