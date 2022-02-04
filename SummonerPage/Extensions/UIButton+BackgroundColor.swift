//
//  UIButton+BackgroundColor.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/04.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let image = UIImage.from(color: color)
        setBackgroundImage(image, for: state)
    }
}
