//
//  SummonerHeaderView.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import UIKit
import SnapKit
import SDWebImage
import Then
import ReactorKit
import RxSwift
import RxCocoa

class SummonerHeaderView: UIView, View {
    var disposeBag: DisposeBag = DisposeBag()
    
    typealias Reactor = SummonerHeaderViewReactor
    
    let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 44
        $0.layer.masksToBounds = true
    }
    
    let levelLabel = PaddingLabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.layer.cornerRadius = 12
        // TODO: change color
        $0.backgroundColor = .darkGray
        $0.textColor = .white
        $0.paddingInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
    }
    
    let summonerNameLabel = UILabel().then {
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
        addSubview(levelLabel)
        
        addSubview(summonerNameLabel)
        addSubview(refreshButton)
        addSubview(leagueCollectionView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: Reactor) {
        reactor.state
            .map { URL(string: $0.summoner.profileImageUrl) }
            .subscribe(onNext: { [weak self] in
                self?.profileImageView.sd_setImage(with: $0, completed: nil)
            }).disposed(by: disposeBag)
        
        reactor.state
            .map { $0.summoner.name }
            .bind(to: summonerNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { String($0.summoner.level) }
            .bind(to: levelLabel.rx.text)
            .disposed(by: disposeBag)
        
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
        
        levelLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImageView)
        }
    }
}
