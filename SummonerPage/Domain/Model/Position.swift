//
//  Position.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import Foundation

struct Position: Codable, WinningRateStringConvertible {
    enum PositionType: String, Codable {
        case support = "SUP"
        case jungle = "JNG"
        case top = "TOP"
        case adc = "ADC"
        case mid = "MID"
    }
    let position: PositionType
    var games: Int
    var wins: Int? = 0
    var losses: Int? = 0
}
