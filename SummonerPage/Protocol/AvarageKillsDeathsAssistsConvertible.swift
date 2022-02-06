//
//  AvarageKillsDeathsAssistsConvertible.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/06.
//

import UIKit

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
        
        let killsString = decimalFommater.string(from: NSNumber(value: kills)) ?? ""
        let assistsString = decimalFommater.string(from: NSNumber(value: assists)) ?? ""
        let deathsString = decimalFommater.string(from: NSNumber(value: deaths)) ?? ""
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.darkishPink]
        result.append(.init(string: "\(killsString) / "))
        result.append(.init(string: "\(assistsString)", attributes: attributes))
        result.append(.init(string: " / \(deathsString)"))
        
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
