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
            removeAllArangeSubviews()
            makeItemLists(items: items)
        }
    }
    
    init() {
        super.init(frame: .zero)
        spacing = 2
        axis = .horizontal
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeItemLists(items: [Item]) {
        var items = items
        let trinket = items.removeLast()
        
        let placeholderImage: UIImage = .from(color: .paleGrey)
        let itemSize = 6
        for index in 0..<itemSize {
            let imageView = UIImageView().then {
                let imageUrl = items[safe: index]?.imageUrl ?? ""
                $0.sd_setImage(with: URL(string: imageUrl),
                               placeholderImage: placeholderImage)
                $0.layer.cornerRadius = 3
                $0.layer.masksToBounds = true
            }
            addArrangedSubview(imageView)
        }
        
        let trinketImageView = RoundImageView().then {
            $0.sd_setImage(with: URL(string: trinket.imageUrl),
                           placeholderImage: placeholderImage)
        }
        addArrangedSubview(trinketImageView)
    }
}
