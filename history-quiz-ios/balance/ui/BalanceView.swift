//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct BalanceView: View {
    @ObservedObject
    var viewModel: BalanceViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: HorizontalAlignment.leading) {
                    if (viewModel.receiveBonusesInfo != nil) {
                        Text("Way to receive money").padding(.bottom, 10)
                        CommonListView(model: viewModel.receiveBonusesInfo!)
                    }
                    if (viewModel.spendBonusesInfo != nil) {
                        Text("Way to spend money").padding(.top, 25).padding(.bottom, 10)
                        CommonListView(model: viewModel.spendBonusesInfo!)
                    }
                    if (viewModel.transactionsInfo?.list.isEmpty == false) {
                        Text("Balance history")
                                .padding(.top, 25)
                                .padding(.bottom, 10)
                        CommonListView(model: viewModel.transactionsInfo!)
                    }
                }.navigationBarTitle("Balance : \(viewModel.balanceSum)").padding()
            }
        }
    }
}