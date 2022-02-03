//
//  Summoner.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import Foundation

struct Summoner: Codable {
    let name: String
    let level: Int
    let profileImageUrl: String
    let profileBorderImageUrl: String
    let url: String
    let leagues: [League]
}

struct SummonerResponse: Codable {
    let summoner: Summoner
}
