//
//  ResultView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/03.
//

import UIKit
import SnapKit
import Then

class ResultView: UIView {
    var match: Match? {
        didSet {
            guard let match = match else { return }
            backgroundColor = match.isWin ? .softBlue : .darkishPink
            resultLabel.text = match.isWin ? "승" : "패"
            let time = secondsToHoursMinutesSeconds(match.gameLength)
            timeLabel.text = "\(time.1):\(time.2)"
        }
    }
    
    private let resultLabel = UILabel().then {
        $0.font = .systemFont16Bold
        $0.textColor = .white
    }
    
    private let divider = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let timeLabel = UILabel().then {
        $0.font = .systemFont12
        $0.textColor = .white
    }
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(resultLabel)
        addSubview(divider)
        addSubview(timeLabel)
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(divider.snp.top).offset(-6)
        }
        
        divider.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(16)
            make.height.equalTo(1)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(divider.snp.bottom).offset(6)
        }
    }
}

func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}
