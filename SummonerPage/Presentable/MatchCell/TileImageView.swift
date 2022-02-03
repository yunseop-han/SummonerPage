//
//  TileImageView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/04.
//

import UIKit

class TileImageView: UIStackView {
    var match: Match? {
        didSet {
            guard let match = match else { return }

            match.spells.forEach {
                let imageView = UIImageView()
                imageView.sd_setImage(with: URL(string: $0.imageUrl))
                spellStackView.addArrangedSubview(imageView)
            }
            
            match.peak.forEach {
                let imageView = UIImageView()
                imageView.sd_setImage(with: URL(string: $0))
                luneStackView.addArrangedSubview(imageView)
            }
        }
    }
    
    private let spellStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 2
        $0.axis = .vertical
    }

    private let luneStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 2
        $0.axis = .vertical
    }

    init() {
        super.init(frame: .zero)
        axis = .horizontal
        distribution = .fillEqually
        spacing = 2
        addArrangedSubview(spellStackView)
        addArrangedSubview(luneStackView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
