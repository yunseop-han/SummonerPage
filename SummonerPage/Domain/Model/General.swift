//
//  General.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/03.
//

import Foundation

struct General: Codable {
    let kill: Int
    let death: Int
    let assist: Int
    let contributionForKillRate: String
    let largestMultiKillString: String
    let opScoreBadge: Badge
    
    enum Badge: String, Codable {
        case ace = "ACE"
        case none = ""
    }
}
