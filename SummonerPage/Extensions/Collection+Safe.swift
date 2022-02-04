//
//  Collection+Safe.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/04.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
