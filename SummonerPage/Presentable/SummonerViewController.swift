//
//  SummonerViewController.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/02.
//

import UIKit

class SummonerViewController: UIViewController {
    let summonerView = SummonerHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(summonerView)
        
        summonerView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }


}

