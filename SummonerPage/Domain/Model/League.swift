//
//  League.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import Foundation

struct League: Codable {
    let wins: Int
    let losses: Int
    let tierRank: Tier
}
