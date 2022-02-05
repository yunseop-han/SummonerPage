//
//  General.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/03.
//

import Foundation

struct General: Codable, KillsDeathsAssitsConvertible, Equatable {
    let kills: Int
    let deaths: Int
    let assists: Int
    let contributionForKillRate: String
    let largestMultiKillString: String
    let opScoreBadge: Badge
    
    enum Badge: String, Codable, Equatable {
        case ace = "ACE"
        case none = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case kills = "kill"
        case deaths = "death"
        case assists = "assist"
        case contributionForKillRate, largestMultiKillString, opScoreBadge
    }
}
