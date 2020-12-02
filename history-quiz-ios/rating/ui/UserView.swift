//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct UserView: View {
    let user: User

    var body: some View {
        Group {
            HStack(alignment: .center) {
                Group {
                    if let avatar = user.image {
                        KFImage(URL(string: avatar))
                                .placeholder {
                                    AvatarPlaceholderView()
                                }
                                .centerCropped()
                                .clipShape(Circle())
                                .frame(width: 80, height: 80)
                    } else {
                        AvatarPlaceholderView()
                    }
                }.padding()
                VStack(alignment: .leading) {
                    Text(user.name)
                            .foregroundColor(.black)
                            .font(.system(size: 17))
                            .padding(.bottom, 1)
                    Text(String(format: "Test done with parameter".localized(), String(user.testDone)))
                            .foregroundColor(.gray)
                            .font(.system(size: 15))
                }
            }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .asCard()
                    .padding(.horizontal)
                    .padding(.bottom, 10)
        }
    }
}

struct AvatarPlaceholderView: View {
    var body: some View {
        Image(systemName: "person.crop.circle")
                .font(.system(size: 80))
                .foregroundColor(Color.gray)
    }
}
