//
// Created by Dmitrii Permiakov on 10/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ArticleItemView: View {
    let item: ArticleItemUiModel

    var body: some View {
        Group {
            HStack(alignment: .center) {
                KFImage(URL(string: item.image))
                        .placeholder {
                            ProgressView()
                        }
                        .centerCropped()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                        .padding(.leading, 10)
                        .padding(.vertical, 10)

                VStack(alignment: .leading) {
                    Text(item.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.black)
                            .font(.system(size: 17))
                    Text(item.subtitle)
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    NavigationLink(destination: getRouter().createArticle(for: item)
                            .navigationBarTitle(item.title)
                    ) {
                        NavigationSeeView()
                                .padding(.top, 10)
                                .padding(.trailing, 20)
                    }
                }.frame(maxWidth: .infinity).padding(10)
            }
                    .background(Color.white)
                    .asCard()
        }.padding()
    }
}

struct ArticleItemView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleItemView(item: ArticleItemUiModel(id: "", category: "", image: "", title: "Петр 1", subtitle: "Император всея Руси Император всея Руси Император всея Руси Император всея Руси Император всея Руси Император всея Руси"))
    }
}
