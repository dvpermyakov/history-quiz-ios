//
// Created by Dmitrii Permiakov on 11/29/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

public struct SimpleButtonModifier: ViewModifier {
    let color: Color

    public func body(content: Content) -> some View {
        content
                .padding(.vertical, 15)
                .padding(.horizontal, 25)
                .foregroundColor(Color.white)
                .background(color)
                .cornerRadius(5)
                .shadow(color: Color.gray, radius: 2)
    }
}

extension Text {
    func asSimpleButton(_ color: Color) -> some View {
        self.modifier(SimpleButtonModifier(color: color))
    }
}