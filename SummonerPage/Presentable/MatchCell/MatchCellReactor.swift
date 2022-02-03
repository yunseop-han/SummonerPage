//
//  MatchCellReactor.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/03.
//

import Foundation
import ReactorKit

class MatchCellReactor: Reactor {
    typealias Action = NoAction
    
    var initialState: State
    
    struct State {
        let match: Match
    }
    
    init(match: Match) {
        initialState = State(match: match)
    }
}
