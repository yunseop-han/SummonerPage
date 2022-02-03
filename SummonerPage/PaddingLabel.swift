//
//  PaddingLabel.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import Foundation
import UIKit

class PaddingLabel: UILabel {
    var paddingInsets: UIEdgeInsets = .zero
    
    override var text: String? {
        didSet {
            isHidden = text?.isEmpty ?? true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.masksToBounds = true
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: paddingInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + paddingInsets.left + paddingInsets.right
        let height = size.height + paddingInsets.top + paddingInsets.bottom
        return CGSize(width: width, height: height)
    }
}
