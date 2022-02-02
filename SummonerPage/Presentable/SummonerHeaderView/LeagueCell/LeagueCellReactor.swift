//
//  LeagueCellReactor.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import Foundation
import ReactorKit

class LeagueCellReactor: Reactor {
    var initialState: State
    
    enum Action {}
    
    struct State {
        let league: League
    }
    
    init(league: League) {
        initialState = State(league: league)
    }
}
