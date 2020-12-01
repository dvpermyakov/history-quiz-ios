//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct TestRulesView: View {
    let onBack: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: onBack) {
                NavigationBackView()
            }
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Rules")
                            .font(Font.system(size: 24))
                            .bold()
                            .padding(.bottom, 10)
                    Text("Rules information".localized())
                }.padding(.top, 20)
            }
        }.padding()
    }

}