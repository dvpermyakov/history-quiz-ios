//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct UrlImageView: View {
    @ObservedObject
    var imageLoader: ImageLoader

    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }

//    var body: some View {
//        if let uiImage = UIImage(data: imageLoader.data) {
//            Image(uiImage: uiImage)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//        }
//    }

    var body: some View {
        if let uiImage = UIImage(data: imageLoader.data) {
            Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
//                    .frame(width: 100, height: 100, alignment: .center)
                    .clipped()
        }
    }
}
