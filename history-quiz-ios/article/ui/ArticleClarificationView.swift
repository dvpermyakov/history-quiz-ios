//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ArticleClarificationView: View {
    let articleClarification: ArticleClarificationUiModel?
    let onBack: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: onBack) {
                NavigationBackView()
            }
            ScrollView {
                if let articleClarification = self.articleClarification {
                    VStack(alignment: .leading) {
                        Text(articleClarification.article.name)
                                .font(Font.system(size: 20))
                                .bold()
                        KFImage(URL(string: articleClarification.article.image))
                                .placeholder {
                                    ProgressView()
                                }
                                .resizable()
                                .scaledToFit()
                        Text(articleClarification.article.description)
                        if (articleClarification.newArticle) {
                            VStack(alignment: .center) {
                                Text("Congrats, you have opened a new article! 🎉🎉🎉")
                                        .font(Font.system(size: 20))
                                        .bold()
                                        .multilineTextAlignment(.center)
                            }
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 30)
                        }
                    }.padding(.top, 20)
                } else {
                    ProgressView()
                }
            }
        }.padding()
    }
}
