//
//  ItemListView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/04.
//

import UIKit
import SDWebImage
import Then

class ItemListView: UIStackView {
    var items: [Item] = [] {
        didSet {
            guard let imageView = arrangedSubviews.last as? UIImageView else {
                return
            }
            imageView.sd_setImage(with: URL(string: items.removeLast().imageUrl))
            items.enumerated().forEach { (index, item) in
                guard let imageView = arrangedSubviews[index] as? UIImageView else { return }
                
                imageView.sd_setImage(with: URL(string: item.imageUrl))
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        spacing = 2
        axis = .horizontal
        distribution = .fillEqually
        
        (0..<5).forEach { _ in
            let imageview = UIImageView().then {
                $0.image = .from(color: .blue)
                $0.layer.cornerRadius = 3
                $0.layer.masksToBounds = true
            }
            addArrangedSubview(imageview)
        }
        
        addArrangedSubview(RoundImageView())
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
