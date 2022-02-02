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
        view.reactor = SummonerHeaderViewReactor(summoner: Summoner(name: "gentory",
                                                                    level: 120,
                                                                    profileImageUrl: "https://opgg-static.akamaized.net/images/profile_icons/profileIcon1625.jpg",
                                                                    profileBorderImageUrl: "https://opgg-static.akamaized.net/images/borders2/challenger.png",
                                                                    url: "https://www.op.gg/summoner/userName=genetory",
                                                                    leagues: []))
        return view

    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(summonerView)
        
        summonerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }


}

