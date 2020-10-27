//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct PersonsView: View {
    var persons: [Person]

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(persons) { person in
//                HStack(alignment: .top) {
//
//                    Group {
//                        UrlImageView(url: person.image).clipShape(Circle())
//                    }
//                            .frame(width: 100, height: 100, alignment: .leading)
//
//                    VStack(alignment: .leading) {
//                        NavigationLink(destination: Router.createArticle(for: person)
//                                .navigationBarTitle(person.name)
//                        ) {
//                            Text(person.name)
//                        }
//                        Text(person.description)
//                    }.frame(width: 200)
//                }
//            }
////                    .padding()
//                    .background(Color(UIColor(hex: "#f7f7f7")))
            }
        }
    }
}
