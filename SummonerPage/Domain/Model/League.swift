//
//  League.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import Foundation

struct League: Codable, Equatable, WinningRateStringConvertible {
    var wins: Int? = 0
    var losses: Int? = 0
    let tierRank: Tier
}
