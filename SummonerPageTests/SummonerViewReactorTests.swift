//
//  SummonerViewReactorTests.swift
//  SummonerViewReactorTests
//
//  Created by 한윤섭 on 2022/02/02.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking
import Moya

@testable import SummonerPage

class SummonerViewReactorTests: XCTestCase {
    var mockMatchResponse: MatchResponse {
        let sampleData = CodingTest.matches(name: "", createDate: 0).sampleData
        let data = try! JSONDecoder().decode(MatchResponse.self, from: sampleData)
        return data
    }
    
    var mockSummonerResponse: SummonerResponse {
        let sampleDta = CodingTest.summoner(name: "").sampleData
        let data = try! JSONDecoder().decode(SummonerResponse.self, from: sampleDta)
        return data
    }
    
    var apiProvider = MoyaProvider<CodingTest>(stubClosure: MoyaProvider.immediatelyStub)
    var reactor: SummonerViewReactor!
    
    override func setUp() {
        super.setUp()
        reactor = SummonerViewReactor(apiProvider: apiProvider)
    }

    override func tearDown() {
        super.tearDown()
        reactor = nil
    }
    // MARK: - View -> Action
    func test_reactor_bind시_refresh_확인() throws {
        // given
        reactor.isStubEnabled = true
        let view = SummonerViewController()
        
        // when
        view.reactor = reactor


        // then
        XCTAssertEqual(reactor.stub.actions, [.refresh])
    }
    
    func test_갱신버튼_클릭시_refresh_action_확인() throws {
        // given
        reactor.isStubEnabled = true
        let view = SummonerViewController()

        // when
        view.reactor = reactor
        view.summonerView
            .refreshButton
            .sendActions(for: .touchUpInside)

        // then
        XCTAssertEqual(reactor.stub.actions, [.refresh, .refresh])
    }
    
    func test_테이블뷰_스크롤시_loadmore_action_확인() throws {
        // given
        reactor.isStubEnabled = true
        let view = SummonerViewController()
        view.reactor = reactor
                
        // when
        var position = view.tableView.contentOffset
        position.y += 100
        view.tableView.rx.contentOffset.onNext(position)
        
        // then
        XCTAssertEqual(try reactor.stub.action.toBlocking(timeout: 1).first(), .loadMore)
    }
    
    // MARK: - Reactor
    func test_refresh할때_createDate_변경() {
        // given
        let schedular = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        
        // when
        schedular
            .createHotObservable([
                .next(100, .refresh)
            ])
            .subscribe(reactor.action)
            .disposed(by: disposeBag)
        
        // then
        let response = schedular.start(created: 0, subscribed: 0, disposed: 1000) {
            self.reactor.state.map(\.lastMatchCreatedDate).distinctUntilChanged()
        }
        
        XCTAssertEqual(response.events.map(\.value.element), [0, 1643715310])
    }
    
    func test_refresh_할때_games_추가() {
        // given
        let schedular = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        
        // when
        schedular
            .createHotObservable([
                .next(100, .refresh),
            ])
            .subscribe(reactor.action)
            .disposed(by: disposeBag)
        
        // then
        let response = schedular.start(created: 0, subscribed: 0, disposed: 1000) {
            self.reactor.state.map { $0.games }.distinctUntilChanged()
        }
        
        XCTAssertEqual(response.events.map(\.value.element), [[], mockMatchResponse.games])
    }
    
    func test_refresh_loadmore_games_확인() {
        // given
        let schedular = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        
        // when
        schedular
            .createHotObservable([
                .next(100, .refresh),
                .next(110, .loadMore),
            ])
            .subscribe(reactor.action)
            .disposed(by: disposeBag)
        
        // then
        let response = schedular.start(created: 0, subscribed: 0, disposed: 1000) {
            self.reactor.state.map { $0.games }.distinctUntilChanged()
        }
        let refreshData = mockMatchResponse.games
        let loadMoreData = mockMatchResponse.games + mockMatchResponse.games
        XCTAssertEqual(response.events.map(\.value.element), [[], refreshData, loadMoreData])
    }

    func test_refresh_loadmore_refresh_games_확인() {
        // given
        let schedular = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        
        // when
        schedular
            .createHotObservable([
                .next(100, .refresh),
                .next(110, .loadMore),
                .next(120, .refresh),
            ])
            .subscribe(reactor.action)
            .disposed(by: disposeBag)
        
        // then
        let response = schedular.start(created: 0, subscribed: 0, disposed: 1000) {
            self.reactor.state.map { $0.games }.distinctUntilChanged()
        }
        let refreshData = mockMatchResponse.games
        let loadMoreData = mockMatchResponse.games + mockMatchResponse.games
        let secondRefreshData = mockMatchResponse.games
        XCTAssertEqual(response.events.map(\.value.element), [[], refreshData, loadMoreData, secondRefreshData])
    }
    
    func test_refresh_champions_확인() {
        // given
        let schedular = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        
        // when
        schedular
            .createHotObservable([
                .next(100, .refresh),
            ])
            .subscribe(reactor.action)
            .disposed(by: disposeBag)
        
        // then
        let response = schedular.start(created: 0, subscribed: 0, disposed: 1000) {
            self.reactor.state.compactMap { $0.champions }.distinctUntilChanged()
        }

        let sampleData = mockMatchResponse.champions
        XCTAssertEqual(response.events.map(\.value.element), [[], sampleData])
    }
    
    func test_refresh_positions_확인() {
        // given
        let schedular = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        
        // when
        schedular
            .createHotObservable([
                .next(100, .refresh),
            ])
            .subscribe(reactor.action)
            .disposed(by: disposeBag)
        
        // then
        let response = schedular.start(created: 0, subscribed: 0, disposed: 1000) {
            self.reactor.state.compactMap { $0.positions }.distinctUntilChanged()
        }

        let resultData = mockMatchResponse.positions
        XCTAssertEqual(response.events.map(\.value.element), [resultData])
    }
    
    func test_refresh_summoner_확인() {
        // given
        let schedular = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        
        // when
        schedular
            .createHotObservable([
                .next(100, .refresh),
            ])
            .subscribe(reactor.action)
            .disposed(by: disposeBag)
        
        // then
        let response = schedular.start(created: 0, subscribed: 0, disposed: 1000) {
            self.reactor.state.compactMap { $0.summoner }.distinctUntilChanged()
        }
        let sampleData = mockSummonerResponse.summoner
        XCTAssertEqual(response.events.map(\.value.element), [sampleData])
    }
    
    func test_refresh_summary_확인() {
        // given
        let schedular = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        
        // when
        schedular
            .createHotObservable([
                .next(100, .refresh),
            ])
            .subscribe(reactor.action)
            .disposed(by: disposeBag)
        
        // then
        let response = schedular.start(created: 0, subscribed: 0, disposed: 1000) {
            self.reactor.state.compactMap { $0.summary }.distinctUntilChanged()
        }

        let sampleData = mockMatchResponse.summary
        XCTAssertEqual(response.events.map(\.value.element), [sampleData])
    }
}
