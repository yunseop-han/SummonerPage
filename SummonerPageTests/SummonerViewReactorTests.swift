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
    lazy var mockMatchResponse = try! JSONDecoder().decode(MatchResponse.self, from: CodingTest.matches(name: "", createDate: 0).sampleData)
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
    
    func test_refresh_할때_데이터_추가() {
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
    
    func test_loadmore_할때_데이터_추가() {
        // given
        let schedular = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        
        // when
        schedular
            .createHotObservable([
                .next(100, .refresh),
                .next(110, .loadMore)
            ])
            .subscribe(reactor.action)
            .disposed(by: disposeBag)
        
        // then
        let response = schedular.start(created: 0, subscribed: 0, disposed: 1000) {
            self.reactor.state.map { $0.games }.distinctUntilChanged()
        }
        
        XCTAssertEqual(response.events.map(\.value.element), [[], mockMatchResponse.games, mockMatchResponse.games + mockMatchResponse.games])
    }

}
