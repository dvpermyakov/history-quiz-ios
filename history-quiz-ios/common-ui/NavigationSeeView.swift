//
// Created by Dmitrii Permiakov on 10/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct NavigationSeeView: View {

    var body: some View {
        HStack {
            Text("See")
            Image(systemName: "chevron.right")
        }.frame(
                maxWidth: .infinity,
                alignment: .trailing
        )
    }
}