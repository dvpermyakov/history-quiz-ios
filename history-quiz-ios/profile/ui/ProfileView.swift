//
// Created by Dmitrii Permiakov on 12/2/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    let onBack: () -> Void

    var body: some View {
        NavigationView {
            ScrollView {
                Text("Profile!!!")
            }
                    .navigationBarTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: Button(action: onBack) {
                        Text("Back")
                    })
        }
    }
}
