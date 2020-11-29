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
            Button(action: onReadClick) {
                Text("I have read the article").asSimpleButton(buttonColor)
            }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 30)
                    .frame(maxWidth: .infinity, alignment: .center)
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
