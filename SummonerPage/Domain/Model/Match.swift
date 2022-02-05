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

extension Match {
    var gameLengthString: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        
        return formatter.string(from: .init(gameLength)) ?? ""
    }
    
    var createDateString: String {
        let date = Date(timeIntervalSince1970: .init(createDate))
        
        if #available(iOS 13.0, *) {
            let formatter = RelativeDateTimeFormatter()
            formatter.dateTimeStyle = .named
            
            let dateString = formatter.localizedString(for: date, relativeTo:.init())
            return dateString
        } else {
            return date.getRelativeDate()
        }
    }
}
