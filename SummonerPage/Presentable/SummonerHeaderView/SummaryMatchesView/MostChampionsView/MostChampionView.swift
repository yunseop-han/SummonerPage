//
//  MostChampionView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import UIKit
import Then
import SnapKit

class MostChampionView: UIView {
    var champion: Champion? {
        didSet {
            guard let champion = champion else { return }
            setupWinningRateLabel()
            imageView.sd_setImage(with: URL(string: champion.imageUrl),
                                  placeholderImage: .from(color: .darkGrey))
        }
    }
    
    private let imageView = RoundImageView()
    private let winningRateLabel = UILabel().then {
        $0.font = .systemFont10
        $0.textAlignment = .center
        $0.textColor = .darkGrey
    }
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWinningRateLabel() {
        guard let champion = champion else { return }
        let rate = champion.winningRate()
        winningRateLabel.textColor = rate == 100 ? .darkishPink : .darkGrey
        winningRateLabel.text = "\(rate)%"
    }
    
    private func setupConstraints() {
        addSubview(imageView)
        addSubview(winningRateLabel)
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(30).priority(.high)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        winningRateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
    }
}
