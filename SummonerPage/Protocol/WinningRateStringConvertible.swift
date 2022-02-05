//
//  WinningRateStringConvertible.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import Foundation

protocol WinningRateStringConvertible {
    var wins: Int? { get }
    var losses: Int? { get }
}

extension WinningRateStringConvertible {
    func winningRate() -> Int {
        guard let wins = wins else { return 0 }
        guard let losses = losses else { return 0 }
        
        let record = Double(wins) / (Double(wins) + Double(losses)) * 100.0
        return Int(record)
    }
}
