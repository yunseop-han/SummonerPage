//
//  PositionView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import UIKit
import SnapKit
import Then

class PositionView: UIView {
    var positions: [Position] = [] {
        didSet{
            imageView.image = UIImage(named: positions.first?.position.iconName ?? "")
            let rate = positions.first?.winningRate()
            rateLabel.text = "\(Int(rate ?? 0))%"
        }
    }
    private let titleLabel = UILabel().then {
        $0.text = "포지션"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = .coolGrey
        $0.textAlignment = .center
    }
    private let imageView = UIImageView()
    private let rateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = .darkGrey
        $0.textAlignment = .center
    }
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(rateLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        rateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
    }
}
