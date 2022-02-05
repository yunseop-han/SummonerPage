//
//  KillsDeathsAssistsAttributeStringConvertible.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import Foundation
import UIKit

protocol KillsDeathsAssistsAttributeStringConvertible {
    var kills: Int { get }
    var deaths: Int { get }
    var assists: Int { get }
}

extension KillsDeathsAssistsAttributeStringConvertible {
    func kdaAttributedString() -> NSAttributedString {
        let string = NSMutableAttributedString()
        string.append(.init(string: "\(kills) / "))
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.darkishPink]
        string.append(.init(string: "\(assists)", attributes: attributes))
        string.append(.init(string: " / \(deaths)"))
        return string
    }
    
    func kdaRatio() -> Double {
        return (Double(kills) + Double(assists)) / Double(deaths)
    }
}
