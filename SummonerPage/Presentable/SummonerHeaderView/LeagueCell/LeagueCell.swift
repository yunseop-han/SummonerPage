//
//  LeagueCell.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import SnapKit

class LeagueCell: UICollectionViewCell, View {
    typealias Reactor = LeagueCellReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let leagueImageView = UIImageView()
    
    private let leagueNameLabel = UILabel().then {
        $0.textColor = .softBlue
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let tierLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    private let lpLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let recordLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
    }
    
    private let detailButton = UIButton(type: .custom).then {
        $0.setImage(.init(named: "iconArrowRight"), for: .normal)
        $0.setBackgroundColor(.paleGrey, for: .normal)
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true
        layer.makeShadow(color: .steelGrey20, x: 0, y: 4, blur: 6, spread: 0)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        contentView.backgroundColor = .white
        contentView.addSubview(leagueImageView)
        
        contentView.addSubview(leagueNameLabel)
        contentView.addSubview(tierLabel)
        contentView.addSubview(lpLabel)
        contentView.addSubview(recordLabel)
        
        contentView.addSubview(detailButton)
        
        leagueImageView.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.leading.equalToSuperview().offset(12)
            make.top.bottom.equalToSuperview().inset(18)
        }
        
        detailButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }

        leagueNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueImageView.snp.trailing).offset(8)
            make.top.equalTo(leagueImageView)
            make.trailing.lessThanOrEqualTo(detailButton.snp.leading)
        }

        tierLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueNameLabel)
            make.top.equalTo(leagueNameLabel.snp.bottom).offset(1)
            make.trailing.lessThanOrEqualTo(detailButton.snp.leading)
        }

        lpLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueNameLabel)
            make.top.equalTo(tierLabel.snp.bottom).offset(2)
            make.trailing.lessThanOrEqualTo(detailButton.snp.leading)
        }

        recordLabel.snp.makeConstraints { make in
            make.leading.equalTo(leagueNameLabel)
            make.top.equalTo(lpLabel.snp.bottom).offset(2)
            make.trailing.lessThanOrEqualTo(detailButton.snp.leading)
            make.bottom.equalToSuperview().inset(16)
        }
        
    }
    
    func bind(reactor: LeagueCellReactor) {
        reactor.state
            .map { URL(string: $0.league.tierRank.imageUrl) }
            .bind { self.leagueImageView.sd_setImage(with: $0, completed: nil) }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.league.tierRank.name }
            .bind(to: leagueNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.league.tierRank.tier }
            .bind(to: tierLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { "\($0.league.tierRank.lp) LP" }
            .bind(to: lpLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map {
                let wins = $0.league.wins ?? 0
                let losses = $0.league.losses ?? 0
                
                return "\(wins)승 \(losses)패 (\(Int($0.league.winningRate()))%)"
            }
            .bind(to: recordLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
