//
// Created by Dmitrii Permiakov on 11/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

public struct SimpleCardModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
                .cornerRadius(15)
                .shadow(color: Color.gray, radius: 2)
    }
}

extension View {
    func asCard() -> some View {
        self.modifier(SimpleCardModifier())
    }
}