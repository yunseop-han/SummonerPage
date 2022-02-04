//
//  LeadingView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/04.
//

import UIKit
import Then
import SnapKit

class LeadingView: UIView {
    var match: Match? {
        didSet {
            guard let match = match else { return }

            multiKillLabel.text = match.stats.general.largestMultiKillString
            typeLabel.text = match.gameType

            if #available(iOS 13.0, *) {
                let date = Date(timeIntervalSince1970: .init(match.createDate))
                let formatter = RelativeDateTimeFormatter()
                formatter.dateTimeStyle = .named
                let dateString = formatter.localizedString(for: date, relativeTo:.init())
                timeLabel.text = dateString
            } else {
                // Fallback on earlier versions
            }
        }
    }
    private let multiKillLabel = PaddingLabel().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkishPink.cgColor
        $0.textColor = .darkishPink
        $0.font = .systemFont(ofSize: 10)
        $0.paddingInsets = .init(top: 4, left: 8, bottom: 3, right: 8)
    }
    private let typeLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = .coolGrey
        $0.font = .systemFont(ofSize: 12)
    }
    private let timeLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = .coolGrey
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
        addSubview(typeLabel)
        addSubview(timeLabel)
        addSubview(multiKillLabel)
        
        typeLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(1)
            make.trailing.equalTo(typeLabel)
        }
        
        multiKillLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(2)
        }
    }
}
