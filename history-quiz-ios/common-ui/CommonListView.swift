//
// Created by Dmitrii Permiakov on 10/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

struct CommonListUiModel {
    var list = [Item]()

    struct Item : Hashable {
        let name: String
        let value: String
    }
}

struct CommonListView: View {
    let model: CommonListUiModel

    var body: some View {
        Group {
            VStack {
                ForEach(model.list, id: \.self) { item in
                    VStack {
                        HStack {
                            Text(item.name).foregroundColor(.gray).fixedSize()
                            Text(item.value).foregroundColor(.gray)
                                    .frame(
                                            maxWidth: .infinity,
                                            alignment: .trailing
                                    )
                        }.frame(
                                maxWidth: .infinity,
                                alignment: .leading
                        ).padding(.leading, 10).padding(.trailing, 10)
                        Divider()
                    }.padding(.top, 10)
                }
            }
                    .background(Color.white)
                    .asCard()
        }
    }
}

struct CommonListView_Previews: PreviewProvider {
    static var previews: some View {
        CommonListView(model: CommonListUiModel(list: [
            CommonListUiModel.Item(name: "Открыть любую статью", value: "10"),
            CommonListUiModel.Item(name: "Начать недоступный тест", value: "10"),
            CommonListUiModel.Item(name: "Открыть любую статью", value: "10")
        ]))
    }
}
