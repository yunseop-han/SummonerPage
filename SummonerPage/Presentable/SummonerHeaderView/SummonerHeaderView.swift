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
    
    let profileImageView = RoundImageView()
    
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
    
    lazy var leagueCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = 8
            $0.estimatedItemSize = .init(width: UIScreen.main.bounds.width * 0.85,
                                         height: 100)
        }
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.register(LeagueCell.self, forCellWithReuseIdentifier: "test")
            $0.backgroundColor = .clear
            $0.contentInset = .init(top: 24, left: 16, bottom: 16, right: 16)
            $0.showsHorizontalScrollIndicator = false
        }
        
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .init(red: 247 / 255, green: 247 / 255, blue: 249 / 255, alpha: 1)
        
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
        
        reactor.state
            .map { $0.summoner.leagues }
            .bind(to: leagueCollectionView.rx.items) { collectionView, index, league in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! LeagueCell
                cell.reactor = LeagueCellReactor(league: league)
                
                return cell
            }.disposed(by: disposeBag)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(88)
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(24)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImageView)
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
            make.top.equalTo(profileImageView.snp.bottom)
            make.height.equalTo(140)
            make.bottom.equalToSuperview()
        }
    }
}
