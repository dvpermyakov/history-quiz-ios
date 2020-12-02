//
// Created by Dmitrii Permiakov on 11/26/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct ArticleTestView: View {
    @EnvironmentObject
    var router: Router

    let test: Test
    let testInfo: CommonListUiModel

    @Binding
    var showRules: Bool
    @Binding
    var moveToTest: Bool

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
                NavigationLink(
                        destination: router.createTest(test: test),
                        isActive: $moveToTest
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