//
// Created by Dmitrii Permiakov on 11/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ArticleTestView: View {
    let test: Test
    let testInfo: CommonListUiModel

    @Binding
    var showRules: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Test info").padding(.bottom, 10)
            CommonListView(model: testInfo)
            HStack {
                Button(action: {
                    showRules = true
                }) {
                    Text("Rules")
                }.padding()
                NavigationLink(destination: Router.createTest(testId: test.id)
                        .navigationBarTitle("Test")
                ) {
                    HStack {
                        Text("Start")
                        Image(systemName: "chevron.right")
                    }.padding()
                }.frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                )
            }
        }.padding()
    }
}