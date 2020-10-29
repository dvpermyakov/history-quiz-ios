//
// Created by Dmitrii Permiakov on 10/25/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct BalanceView: View {
    @ObservedObject
    var viewModel: BalanceViewModel

    var body: some View {
        VStack {
            Text("Balance:")
            ForEach(viewModel.transactions) { transaction in
                Text(transaction.title)
            }
        }
    }
}

extension Transaction {
    var title: String {
        return " amount: \(self.amount)"
    }
}
