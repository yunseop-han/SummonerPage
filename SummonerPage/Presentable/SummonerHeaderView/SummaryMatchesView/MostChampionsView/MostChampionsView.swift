//
//  MostChampionsView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import UIKit
import Then
import SnapKit

class MostChampionsView: UIView {
    var champions: [Champion] = [] {
        didSet {
            firstChampionView.champion = champions[safe: 0]
            secondChampionView.champion = champions[safe: 1]
        }
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "모스트 승률"
        $0.textColor = .coolGrey
        $0.font = .systemFont10
        $0.textAlignment = .center
    }
    
    private let firstChampionView = MostChampionView()
    private let secondChampionView = MostChampionView()
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(titleLabel)
        addSubview(firstChampionView)
        addSubview(secondChampionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        firstChampionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.centerX).offset(-8)
            make.bottom.equalToSuperview()
        }
        
        secondChampionView.snp.makeConstraints { make in
            make.top.equalTo(firstChampionView)
            make.trailing.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.centerX).offset(8)
            make.bottom.equalToSuperview()
        }
    }
}
