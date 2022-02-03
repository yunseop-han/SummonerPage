//
//  SummonerViewReactor.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import Foundation
import ReactorKit
import Moya

class SummonerViewReactor: Reactor {
    var initialState: State = State()
    
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case setUser(String)
        case setSummoner(Summoner)
    }
    
    struct State {
        var user: String = "gentory"
        var summoner: Summoner?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return.concat([
                Observable.just(.setUser(currentState.user)),
                search(query: currentState.user)
                    .map({ Mutation.setSummoner($0) })
            ])

        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setUser(let string):
            newState.user = string
            
        case .setSummoner(let summoner):
            newState.summoner = summoner
        }
        return newState
    }
    
    func search(query: String) -> Observable<Summoner> {
        return codingTestProvider.rx
            .request(.summoner(name: query))
            .map(SummonerResponse.self)
            .compactMap({ $0.summoner })
            .asObservable()
    }
}
