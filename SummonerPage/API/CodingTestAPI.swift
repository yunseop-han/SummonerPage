//
//  CodingTestAPI.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/03.
//

import Foundation
import Moya

enum CodingTest {
    case summoner(name: String)
    case matches(name: String, createDate: Int)
}

extension CodingTest: TargetType {
    var baseURL: URL { URL(string: "https://codingtest.op.gg/api")! }
    
    var path: String {
        switch self {
        case .summoner(let name):
            return "/summoner/\(name)"
        
        case .matches(let name, _):
            return "/summoner/\(name)/matches"
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Task {
        switch self {
        case .summoner:
            return .requestPlain
            
        case .matches(_, let createDate):
            let parameters = [ "lastMatch": createDate ]
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
    
    var sampleData: Data {
        switch self {
        case .summoner(_):
            return Bundle.jsonData(named: "SummonerResponse") ?? Data()
            
        case .matches(_, _):
            return Bundle.jsonData(named: "MatchResponse") ?? Data()
        }
    }
}
