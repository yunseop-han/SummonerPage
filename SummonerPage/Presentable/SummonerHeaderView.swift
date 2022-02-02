//
//  SummonerHeaderView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import UIKit
import SnapKit
import Then

class SummonerHeaderView: UIView {
    let profileImageView: UIView = UIView().then {
        $0.backgroundColor = .red
    }
    
    let summonerNameLabel = UILabel().then {
        $0.text = "OPGG"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    let refreshButton = UIButton().then {
        $0.setTitle("전적갱신", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let leagueCollectionView = UIView().then {
        $0.backgroundColor = .red
    }
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .cyan
        
        addSubview(profileImageView)
        addSubview(summonerNameLabel)
        addSubview(refreshButton)
        addSubview(leagueCollectionView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(88)
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(24)
        }
        
        summonerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
        }
        
        refreshButton.snp.makeConstraints { make in
            make.leading.equalTo(summonerNameLabel)
            make.bottom.equalTo(profileImageView)
        }
        
        leagueCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(24)
            make.height.equalTo(100)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
