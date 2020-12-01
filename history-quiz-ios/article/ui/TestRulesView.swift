//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct TestRulesView: View {

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Rules").font(Font.system(size: 24)).padding(.bottom, 10)
                Text("Rules information".localized())
            }.padding()
        }
    }

}