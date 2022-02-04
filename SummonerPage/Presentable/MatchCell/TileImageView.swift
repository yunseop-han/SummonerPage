//
//  TileImageView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/04.
//

import UIKit
import Then
import SDWebImage

class TileImageView: UIStackView {
    
    var imageUrls: [[String]] = [] {
        didSet {
            removeAllArangeSubviews()
            makeImageView(imageUrls: imageUrls)
        }
    }
    
    init() {
        super.init(frame: .zero)
        axis = .horizontal
        distribution = .fillEqually
        spacing = 2
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeImageView(imageUrls: [[String]]) {
        for urls in imageUrls {
            let stackView = UIStackView().then {
                $0.distribution = .fillEqually
                $0.spacing = 2
                $0.axis = .vertical
            }
            
            for url in urls {
                let imageView = UIImageView().then {
                    $0.sd_setImage(with: URL(string: url))
                }
                stackView.addArrangedSubview(imageView)
            }
            addArrangedSubview(stackView)
        }
    }
}
