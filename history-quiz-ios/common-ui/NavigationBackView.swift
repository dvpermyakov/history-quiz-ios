//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct NavigationBackView: View {

    var body: some View {
        HStack() {
            Image(systemName: "chevron.left")
            Text("Back")
        }.frame(
                maxWidth: .infinity,
                alignment: .leading
        )
    }
}