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
    typealias Reactor = SummonerViewReactor
    
    var disposeBag: DisposeBag = .init()
    private let summonerView: SummonerHeaderView = .init()
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .paleGrey
        $0.tableHeaderView = summonerView
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 100
        $0.register(MatchCell.self, forCellReuseIdentifier: "test")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .paleGrey
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        summonerView.snp.makeConstraints { make in
            make.width.equalTo(tableView.snp.width)
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: SummonerViewReactor) {
        // Action
        Observable.just(Void())
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        summonerView
            .refreshButton.rx.tap
            .map { Reactor.Action.refresh}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        tableView.rx
            .contentOffset
            .filter { [weak self] in
                guard let self = self else { return false }
                return $0.y > self.tableView.contentSize.height - self.tableView.frame.height
            }.map { _ in Reactor.Action.loadMore }
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .compactMap { $0.summoner }
            .map { SummonerHeaderViewReactor(summoner: $0) }
            .bind(to: summonerView.rx.reactor )
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.games }
            .bind(to: tableView.rx.items) { tableView, index, element in
                let cell = tableView.dequeueReusableCell(withIdentifier: "test") as! MatchCell
                cell.reactor = MatchCellReactor(match: element)
                return cell
            }.disposed(by: disposeBag)
    }
}

