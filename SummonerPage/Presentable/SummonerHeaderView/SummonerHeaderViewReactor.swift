//
//  SummonerHeaderViewReactor.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import Foundation
import ReactorKit

class SummonerHeaderViewReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        var summoner: Summoner
        var summary: Summary
        var champions: [Champion] = []
    }
    
    var initialState: State
    
    init(summoner: Summoner, summary: Summary, champions: [Champion]) {
        initialState = State(summoner: summoner,
                             summary: summary,
                             champions: champions)
    }
}
