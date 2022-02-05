//
//  ProtocolTests.swift
//  SummonerPageTests
//
//  Created by 한윤섭 on 2022/02/06.
//

import XCTest
@testable import SummonerPage

class ProtocolTests: XCTestCase {

    struct MockKDAStruct: KillsDeathsAssitsConvertible {
        var kills: Int
        var deaths: Int
        var assists: Int
    }

    func test_infinity_kda() throws {
        let kda = MockKDAStruct(kills: 10, deaths: 0, assists: 10)
        XCTAssertEqual(kda.kdaRatio(), .infinity)
    }

//    func test_infinity_kda() throws {
//        let kda = MockKDAStruct(kills: 10, deaths: 0, assists: 10)
//        XCTAssertEqual(kda.kdaRatio(), .infinity)
//    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
