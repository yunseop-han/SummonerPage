//
//  SummaryMatchsView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import UIKit
import Then
import SnapKit

class SummaryMatchsView: UIView {
    var summary: Summary? {
        didSet {
            guard let summary = summary else { return }
            summaryGeneralView.summary = summary
        }
    }
    
    var champions: [Champion] = [] {
        didSet {
            summaryMostChampionView.champions = champions
        }
    }
    
    private let summaryGeneralView = SummaryGeneralView()
    private let summaryMostChampionView = MostChampionsView()
    private let summaryLeadingView = UIView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.makeShadow(color: .steelGrey.withAlphaComponent(0.1), x: 0, y: 4, blur: 2, spread: 0)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(summaryGeneralView)
        addSubview(summaryMostChampionView)
        
        summaryGeneralView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(12)
            make.width.equalTo(134)
        }
        
        summaryMostChampionView.snp.makeConstraints { make in
            make.top.equalTo(summaryGeneralView)
            make.leading.equalTo(summaryGeneralView.snp.trailing).offset(10)
            make.width.equalTo(98)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}
