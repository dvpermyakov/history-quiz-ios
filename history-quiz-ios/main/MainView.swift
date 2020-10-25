//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Router.createPeriods()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Periods")
                    }
            Router.createBalance()
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("Balance")
                    }
        }
    }
}
