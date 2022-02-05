//
//  MatchResponse.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/06.
//

import Foundation

struct MatchResponse: Codable {
    let games: [Match]
    let champions: [Champion]
    let summary: Summary
    let positions: [Position]
}
