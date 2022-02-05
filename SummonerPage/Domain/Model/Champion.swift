//
//  Champion.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/03.
//

import Foundation

struct Champion: Codable, Equatable, WinningRateStringConvertible {
    let imageUrl: String
    var losses: Int? = 0
    var wins: Int? = 0
}
