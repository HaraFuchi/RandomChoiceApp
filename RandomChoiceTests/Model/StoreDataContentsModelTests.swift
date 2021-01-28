//
//  StoreDataContentsModelTests.swift
//  RandomChoiceTests
//
//  Created by 渕一真 on 2021/01/25.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import XCTest
@testable import Debugさいころdeごはん

class StoreDataContentsModelTests: XCTestCase {
    func test_イニシャライザ時_正しく値が入る() {
        let model = StoreDataContentsModel(childID: "123456789",
                                           store: "日高屋",
                                           place: "千葉",
                                           genre: "中華")
        XCTAssertEqual(model.childID, "123456789")
        XCTAssertEqual(model.storeName, "日高屋")
        XCTAssertEqual(model.placeName, "千葉")
        XCTAssertEqual(model.genreName, "中華")
    }
    func test_イニシャライザ時_空の値が入る() {
        let model = StoreDataContentsModel(childID: "ABCDEFGHI",
                                           store: "",
                                           place: "",
                                           genre: "")
        XCTAssertEqual(model.childID, "ABCDEFGHI")
        XCTAssertEqual(model.storeName, "")
        XCTAssertEqual(model.placeName, "")
        XCTAssertEqual(model.genreName, "")
    }
}
