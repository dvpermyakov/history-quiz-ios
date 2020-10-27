//
// Created by Dmitrii Permiakov on 10/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct EventsView: View {
    var events: [Event]

    var body: some View {
        VStack {
            ForEach(events) { event in
                NavigationLink(destination: Router.createArticle(for: event)
                        .navigationBarTitle(event.name)
                ) {
                    Text(event.name)
                }
            }
        }
    }
}