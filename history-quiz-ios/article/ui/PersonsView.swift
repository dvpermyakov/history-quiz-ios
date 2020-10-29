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
                PersonView(person: person)
            }
        }
    }
}

struct PersonView: View {
    let person: Person

    var body: some View {
        Group {
            HStack(alignment: .center) {
                Group {
                    UrlImageView(url: person.image).clipShape(Circle())
                }.frame(width: 100, height: 100)

                VStack(alignment: .leading) {
                    Text(person.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                    Text(person.description)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                    NavigationLink(destination: Router.createArticle(for: person)
                            .navigationBarTitle(person.name)
                    ) {
                        HStack {
                            Text("See")
                            Image(systemName: "chevron.right")
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .trailing
                        )
                        .padding(.top, 10)
                        .padding(.trailing, 20)
                    }
                }.frame(maxWidth: .infinity).padding(10)
            }
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.gray, radius: 50)
        }.padding()
    }
}

struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonView(person: Person(
                        id: "1",
                        category: "1",
                        name: "Петр 1",
                        description: "Последнийийский",
                        image: ""
            ))
        }
    }
}
