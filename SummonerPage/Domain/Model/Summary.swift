//
//  Summary.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import Foundation

struct Summary: Codable, AvarageKillsDeathsAssistsConvertible, WinningRateStringConvertible {
    var wins: Int? = 0
    var losses: Int? = 0
    let kills: Int
    let deaths: Int
    let assists: Int
}
