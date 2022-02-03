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
        case loadMore
    }
    
    enum Mutation {
        case setUser(String)
        case setSummoner(Summoner)
        case setGames([Match])
        case appendGames([Match])
        case initDate
    }
    
    struct State {
        var user: String = "gentory"
        var summoner: Summoner?
        var lastMatchCreatedDate: Int = 0
        var games: [Match] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .concat([
                Observable.just(.setUser(currentState.user)),
                Observable.just(.initDate),
                searchSummoner(query: currentState.user)
                    .map({ Mutation.setSummoner($0) }),
                fetchMatchs(name: currentState.user, createdData: 0)
                    .map({ Mutation.setGames($0) })
            ])
            
        case .loadMore:
            return .concat([
                fetchMatchs(name: currentState.user,
                            createdData: currentState.lastMatchCreatedDate)
                    .map({ Mutation.appendGames($0) })
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
        
        case .setGames(let games):
            newState.games = games
            let lastDate = games.last?.createDate ?? 0
            newState.lastMatchCreatedDate = lastDate
            
        case .appendGames(let games):
            newState.games.append(contentsOf: games)
            let lastDate = games.last?.createDate ?? 0
            newState.lastMatchCreatedDate = lastDate
            
        case .initDate:
            newState.lastMatchCreatedDate = 0
        }
        
        return newState
    }
    
    func searchSummoner(query: String) -> Observable<Summoner> {
        return codingTestProvider.rx
            .request(.summoner(name: query))
            .map(SummonerResponse.self)
            .compactMap({ $0.summoner })
            .asObservable()
    }
    
    func fetchMatchs(name: String, createdData: Int) -> Observable<[Match]> {
        return codingTestProvider.rx
            .request(.matches(name: name, createDate: createdData))
            .map(MatchResponse.self)
            .debug()
            .compactMap { $0.games }
            .asObservable()
    }
}
