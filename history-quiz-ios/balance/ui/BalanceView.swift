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
                    Text("Way to receive money").padding(.bottom, 10)
                    if (viewModel.receiveBonusesInfo != nil) {
                        CommonListView(model: viewModel.receiveBonusesInfo!)
                    }
                    Text("Way to spend money").padding(.top, 25).padding(.bottom, 10)
                    if (viewModel.spendBonusesInfo != nil) {
                        CommonListView(model: viewModel.spendBonusesInfo!)
                    }
                    if (!viewModel.transactions.isEmpty) {
                        Text("Balance history")
                                .padding(.top, 25)
                                .padding(.bottom, 10)
                        ForEach(viewModel.transactions) { transaction in
                            Text(transaction.title)
                        }
                    }
                }.navigationBarTitle("Balance : \(viewModel.balanceSum)").padding()
            }
        }
    }
}

extension Transaction {
    var title: String {
        " amount: \(self.amount)"
    }
}
