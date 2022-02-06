//
//  Position.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import Foundation

struct Position: Codable, Equatable, WinningRateStringConvertible {
    enum PositionType: String, Codable, Equatable {
        case support = "SUP"
        case jungle = "JNG"
        case top = "TOP"
        case adc = "ADC"
        case mid = "MID"
        
        var iconName: String {
            switch self {
            case .support:
                return "iconLolSup"
            case .jungle:
                return "iconLolJng"
            case .top:
                return "iconLolTop"
            case .adc:
                return "iconLolBot"
            case .mid:
                return "iconLolMid"
            }
        }
    }
    let position: PositionType
    var games: Int
    var wins: Int? = 0
    var losses: Int? = 0
}
