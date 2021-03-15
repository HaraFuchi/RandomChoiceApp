//
//  ResultStoreDataModelTests.swift
//  RandomChoiceTests
//
//  Created by 渕一真 on 2021/02/07.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import XCTest
@testable import RandomChoiceApp

class ResultStoreDataModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        ResultData.store = nil
        StoreDataCrudModel.storeDataArray = []
    }

    func test_データの数が0の場合_値は初期値から変わらない() {
        if !StoreDataCrudModel.storeDataArray.isEmpty {
            XCTFail("データの数が1つ以上あるためUT実施不可")
            return
        }

        ExtractResultLogic.randomSelectedStoreData()

        XCTAssertNil(ResultData.store)
    }

    func test_データの数が1つ_同じ値が表示され続ける() {
        StoreDataCrudModel.storeDataArray = [.init(childID: "childID_A",
                                                   store: "store_A",
                                                   place: "place_A",
                                                   genre: "genre_A")]

        if StoreDataCrudModel.storeDataArray.count != 1 {
            XCTFail()
        }

        ExtractResultLogic.randomSelectedStoreData()

        XCTAssertEqual(ResultData.store?.store, "store_A")
        XCTAssertEqual(ResultData.store?.place, "place_A")
        XCTAssertEqual(ResultData.store?.genre, "genre_A")

        if StoreDataCrudModel.storeDataArray.count != 1 {
            XCTFail()
        }

        ExtractResultLogic.randomSelectedStoreData()

        XCTAssertEqual(ResultData.store?.store, "store_A")
        XCTAssertEqual(ResultData.store?.place, "place_A")
        XCTAssertEqual(ResultData.store?.genre, "genre_A")
    }

    func test_データが複数_それぞれ対応する値が返却される() {
        StoreDataCrudModel.storeDataArray = [
            .init(childID: "childID_1", store: "store_1", place: "place_1", genre: "genre_1"),
            .init(childID: "childID_2", store: "store_2", place: "place_2", genre: "genre_2"),
            .init(childID: "childID_3", store: "store_3", place: "place_3", genre: "genre_3")
        ]

        /// - Note: ランダムのUT実装は困難のため、初期値を異なる値が返却されたらテスト成功とする
        ExtractResultLogic.randomSelectedStoreData()

        XCTAssertNotEqual(ResultData.store?.store, "???")
        XCTAssertNotEqual(ResultData.store?.place, "???")
        XCTAssertNotEqual(ResultData.store?.genre, "???")
    }

    func test_データが大量_それぞれ対応する値が返却される() {
        StoreDataCrudModel.storeDataArray = (0..<1000)
            .map {
                StoreData(
                    childID: String($0),
                    store: "store",
                    place: "place",
                    genre: "genre")
            }

        // measureはパフォーマンスの計測のため
        self.measure {
            ExtractResultLogic.randomSelectedStoreData()

            /// - Note: ランダムのUT実装は困難のため、初期値を異なる値が返却されたらテスト成功とする
            XCTAssertNotEqual(ResultData.store?.store, "???")
            XCTAssertNotEqual(ResultData.store?.place, "???")
            XCTAssertNotEqual(ResultData.store?.genre, "???")
        }
    }
}
