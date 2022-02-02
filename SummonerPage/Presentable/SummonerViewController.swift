//
//  SummonerViewController.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import UIKit

class SummonerViewController: UIViewController {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(summonerView)
        
        summonerView.snp.makeConstraints { make in
            
            if #available(iOS 11.0, *) {
                make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            } else {
//                make.edges.equalToSuperview()
            }
        }
    }


}

