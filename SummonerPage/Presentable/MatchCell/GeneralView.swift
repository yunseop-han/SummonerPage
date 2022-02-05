//
//  GeneralView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/04.
//

import UIKit
import Then
import SnapKit

class GeneralView: UIView {
    var general: General? {
        didSet {
            guard let general = general else { return }
            kdaLabel.attributedText = general.kdaAttributedString()
            contributionRateLabel.text = "킬관여 \(general.contributionForKillRate)"
        }
    }
    private let kdaLabel = UILabel().then {
        // TODO: - AttributeString
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    private let contributionRateLabel = UILabel().then {
        $0.textColor = .gunmetal
        $0.font = .systemFont(ofSize: 12)
    }
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(kdaLabel)
        addSubview(contributionRateLabel)
        
        kdaLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.trailing.equalToSuperview()
        }
        
        contributionRateLabel.snp.makeConstraints { make in
            make.top.equalTo(kdaLabel.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(2)
        }
    }
}
