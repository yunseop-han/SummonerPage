//
//  RoundImageView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/03.
//

import UIKit

class RoundImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
