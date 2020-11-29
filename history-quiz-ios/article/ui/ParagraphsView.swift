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
        VStack {
            ForEach(text.paragraphs) { paragraph in
                VStack(alignment: .leading) {
                    Text(paragraph.title).font(Font.system(.body)).bold()
                    Group {
                        if let url = paragraph.image {
                            KFImage(URL(string: url))
                                    .resizable()
                                    .scaledToFit()
                        }
                    }
                    Text(paragraph.text).font(Font.system(.body))
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
