//
//  Tier.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import Foundation

struct Tier: Codable {
    let name: String
    let tier: String
    let tierDivision: String
    let string: String
    let shortString: String
    let imageUrl: String
    let lp: Int
    let tierRankPoint: Int
}
