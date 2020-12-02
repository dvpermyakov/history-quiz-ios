//
// Created by Dmitrii Permiakov on 10/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ArticleItemView: View {
    @EnvironmentObject
    var router: Router

    let item: ArticleItemUiModel

    var body: some View {
        Group {
            VStack {
                HStack(alignment: .center) {
                    KFImage(URL(string: item.image))
                            .placeholder {
                                ProgressView()
                            }
                            .centerCropped()
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .padding(.leading, 10)
                            .padding(.top, 10)

                    VStack(alignment: .leading) {
                        Text(item.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                        Text(item.subtitle)
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                        ForEach(0..<item.additionalInfo.count) { additionalIndex in
                            Text(item.additionalInfo[additionalIndex].title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15))
                            Text(item.additionalInfo[additionalIndex].subtitle)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13))
                        }
                    }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 10)
                            .padding(.horizontal, 10)
                }
                NavigationLink(destination: router.createArticle(for: item)
                        .navigationBarTitle(item.title)
                ) {
                    NavigationSeeView()
                            .padding(.bottom, 10)
                            .padding(.trailing, 20)
                }
            }
                    .background(Color.white)
                    .asCard()
        }
    }
}
