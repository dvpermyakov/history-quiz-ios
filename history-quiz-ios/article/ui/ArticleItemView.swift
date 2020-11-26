//
// Created by Dmitrii Permiakov on 10/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ArticleItemView: View {
    let item: ArticleItemUiModel

    var body: some View {
        Group {
            HStack(alignment: .center) {
                ArticleItemImageView(url: item.image)

                VStack(alignment: .leading) {
                    Text(item.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.black)
                            .font(.system(size: 17))
                    Text(item.subtitle)
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                    NavigationLink(destination: Router.createArticle(for: item)
                            .navigationBarTitle(item.title)
                    ) {
                        NavigationSeeView()
                                .padding(.top, 10)
                                .padding(.trailing, 20)
                    }
                }.frame(maxWidth: .infinity).padding(10)
            }
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.gray, radius: 2)
        }.padding()
    }
}

struct ArticleItemImageView: View {
    @ObservedObject
    var imageLoader: ImageLoader

    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        Group {
            if let data = imageLoader.data, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                        .centerCropped()
                        .clipShape(Circle())
            } else {
                Spacer()
            }
        }.frame(width: 100, height: 100).padding(.leading, 10)
    }
}

struct ArticleItemView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleItemView(item: ArticleItemUiModel(id: "", category: "", image: "", title: "Петр 1", subtitle: "Император всея Руси Император всея Руси Император всея Руси Император всея Руси Император всея Руси Император всея Руси"))
    }
}
