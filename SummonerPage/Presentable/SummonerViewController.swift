//
//  SummonerViewController.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import UIKit
import ReactorKit
import Then
import RxSwift
import RxCocoa

class SummonerViewController: UIViewController, View {
    var disposeBag: DisposeBag = DisposeBag()
    
    typealias Reactor = SummonerViewReactor
    
    let summonerView: SummonerHeaderView = {
        var view = SummonerHeaderView()
        let league = [League(wins: 99, losses: 800, tierRank: Tier(name: "솔랭", tier: "Diamond", tierDivision: "Diamond", string: "Diamond (736LP)", shortString: "D1", imageUrl: "https://opgg-static.akamaized.net/images/medals/diamond_1.png", lp: 736, tierRankPoint: 327)), League(wins: 99, losses: 800, tierRank: Tier(name: "솔랭", tier: "Diamond", tierDivision: "Diamond", string: "Diamond (736LP)", shortString: "D1", imageUrl: "https://opgg-static.akamaized.net/images/medals/diamond_1.png", lp: 736, tierRankPoint: 327))]
        view.reactor = SummonerHeaderViewReactor(summoner: Summoner(name: "gentory",
                                                                    level: 120,
                                                                    profileImageUrl: "https://opgg-static.akamaized.net/images/profile_icons/profileIcon1625.jpg",
                                                                    profileBorderImageUrl: "https://opgg-static.akamaized.net/images/borders2/challenger.png",
                                                                    url: "https://www.op.gg/summoner/userName=genetory",
                                                                    leagues: league))
        return view

    }()
    
    lazy var tableView = UITableView().then {
        $0.backgroundColor = .red
        $0.tableHeaderView = summonerView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        setupConstraints()
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        summonerView.snp.makeConstraints { make in
            make.width.equalTo(tableView.snp.width)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: SummonerViewReactor) {
        
    }
}

