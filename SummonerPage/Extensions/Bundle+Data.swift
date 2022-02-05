//
//  Bundle+Data.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/06.
//

import Foundation

extension Bundle {
    class func jsonData(named: String?) -> Data? {
        guard let named = named else { return nil }
        guard let url = main.url(forResource: named, withExtension: "json") else {
            return nil
        }
        return try? Data(contentsOf: url)
        
    }
}
