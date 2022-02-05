//
//  Reusable.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import UIKit

public protocol Reusable {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UICollectionViewCell: Reusable {}
