//
//  Match.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/03.
//

import Foundation

struct Match: Codable, Equatable {
    let mmr: Int?
    let champion: Champion
    let spells: [Spell]
    let items: [Item]
    let createDate: Int
    let gameLength: Int
    let peak: [String]
    let isWin: Bool
    let gameType: String
    let stats: Stats
}
