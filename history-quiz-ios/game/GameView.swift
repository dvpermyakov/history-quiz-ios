//
//  ContentView.swift
//  history-quiz-ios
//
//  Created by Dmitrii Permiakov on 10/8/20.
//  Copyright © 2020 Dmitrii Permiakov. All rights reserved.
//

import SwiftUI

public struct GameView: View {
    var viewModel = GameViewModel()
    
    public var body: some View {
        Text(text)
    }
    
    var text: String {
        viewModel.game.questions.first?.text ?? ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
