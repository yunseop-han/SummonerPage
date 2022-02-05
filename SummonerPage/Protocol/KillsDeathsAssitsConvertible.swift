//
//  KillsDeathsAssitsConvertible.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import Foundation
import UIKit

protocol KillsDeathsAssitsConvertible {
    var kills: Int { get }
    var deaths: Int { get }
    var assists: Int { get }
}

extension KillsDeathsAssitsConvertible {
    func kdaAttributedString() -> NSAttributedString {
        let string = NSMutableAttributedString()
        string.append(.init(string: "\(kills) / "))
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.darkishPink]
        string.append(.init(string: "\(assists)", attributes: attributes))
        string.append(.init(string: " / \(deaths)"))
        return string
    }
}


protocol AvarageKillsDeathsAssistsConvertible: KillsDeathsAssitsConvertible, WinningRateStringConvertible {

}

extension AvarageKillsDeathsAssistsConvertible {
    var decimalFommater: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        return formatter
    }
    
    func kdaAttributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()
        
        let gameCount = (wins ?? 0) + (losses ?? 0)
        let kills = Double(kills) / Double(gameCount)
        let assists = Double(assists) / Double(gameCount)
        let deaths = Double(deaths) / Double(gameCount)
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.darkishPink]
        result.append(.init(string: "\(kills) / "))
        result.append(.init(string: "\(assists)", attributes: attributes))
        result.append(.init(string: " / \(deaths)"))
        
        return result
    }
    
    func kdaRatioAndWinningRateAttributedString() -> NSAttributedString {
        let result = NSMutableAttributedString()
        
        let ratio = (Double(kills) + Double(assists)) / Double(deaths)
        if var ratioString = decimalFommater.string(from: NSNumber(value: ratio)) {
            ratioString = "\(ratioString):1"
            result.append(.init(string: ratioString, attributes: [.foregroundColor: UIColor.greenBlue]))
        }
        
        let rate = Int(winningRate())
        let rateString = " (\(rate)%)"
        result.append(.init(string: rateString, attributes: [.foregroundColor: UIColor.darkishPink]))
        
        return result
    }
}
