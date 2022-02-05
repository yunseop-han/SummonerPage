//
//  SummaryGeneralView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/05.
//

import UIKit
import Then
import SnapKit

class SummaryGeneralView: UIView {
    var summary: Summary? {
        didSet {
            guard let summary = summary else { return }
            titleLabel.text = "최근 20게임 분석"
            resultLabel.text = "\(summary.wins ?? 0)승 \(summary.losses ?? 0)패"
            kdaLabel.attributedText = summary.kdaAttributedString()
            let ratio = String(format: "%.3f", summary.kdaRatio())
            let rate = Int(summary.winningRate())
            kdaRatioLabel.text = "\(ratio):1 (\(rate)%)"
        }
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .coolGrey
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let resultLabel = UILabel().then {
        $0.textColor = .coolGrey
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let kdaLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    private let kdaRatioLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
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
        addSubview(resultLabel)
        addSubview(kdaLabel)
        addSubview(kdaRatioLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        kdaLabel.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        kdaRatioLabel.snp.makeConstraints { make in
            make.top.equalTo(kdaLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview()
        }
    }
}
