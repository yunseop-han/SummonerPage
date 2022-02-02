//
//  SummonerHeaderViewReactor.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import Foundation
import ReactorKit

class SummonerHeaderViewReactor: Reactor {
    
    enum Action {}
    struct State {
        var summoner: Summoner
    }
    
    var initialState: State
    
    init(summoner: Summoner) {
        initialState = State(summoner: summoner)
    }
}
