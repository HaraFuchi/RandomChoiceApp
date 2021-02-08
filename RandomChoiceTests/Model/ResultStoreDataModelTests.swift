//
//  ResultStoreDataModelTests.swift
//  RandomChoiceTests
//
//  Created by 渕一真 on 2021/02/07.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import XCTest
@testable import Debugさいころdeごはん

class ResultStoreDataModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        ResultStoreDate.store = "???"
        ResultStoreDate.place = "???"
        ResultStoreDate.genre = "???"
        StoreDataCrudModel.storeDataArray = []
    }
    
    func test_データの数が0の場合_値は初期値から変わらない() {
        if !StoreDataCrudModel.storeDataArray.isEmpty {
            XCTFail("データの数が1つ以上あるためUT実施不可")
            return
        }
        
        ResultStoreDataModel.showResultStoreData()
        
        XCTAssertEqual(ResultStoreDate.store, "???")
        XCTAssertEqual(ResultStoreDate.place, "???")
        XCTAssertEqual(ResultStoreDate.genre, "???")
    }
    
    func test_データの数が1つ_同じ値が表示され続ける() {
        StoreDataCrudModel.storeDataArray = [.init(childID: "childID_A",
                                                   store: "store_A",
                                                   place: "place_A",
                                                   genre: "genre_A")]
        
        if StoreDataCrudModel.storeDataArray.count != 1 {
            XCTFail()
        }
        
        ResultStoreDataModel.showResultStoreData()
        
        XCTAssertEqual(ResultStoreDate.store, "store_A")
        XCTAssertEqual(ResultStoreDate.place, "place_A")
        XCTAssertEqual(ResultStoreDate.genre, "genre_A")
        
        if StoreDataCrudModel.storeDataArray.count != 1 {
            XCTFail()
        }
        
        ResultStoreDataModel.showResultStoreData()
        
        XCTAssertEqual(ResultStoreDate.store, "store_A")
        XCTAssertEqual(ResultStoreDate.place, "place_A")
        XCTAssertEqual(ResultStoreDate.genre, "genre_A")
    }
    
    func test_データが複数_それぞれ対応する値が返却される() {
        StoreDataCrudModel.storeDataArray = [
            .init(childID: "childID_1", store: "store_1", place: "place_1", genre: "genre_1"),
            .init(childID: "childID_2", store: "store_2", place: "place_2", genre: "genre_2"),
            .init(childID: "childID_3", store: "store_3", place: "place_3", genre: "genre_3")
        ]
        
        /// - Note: ランダムのUT実装は困難のため、初期値を異なる値が返却されたらテスト成功とする
        ResultStoreDataModel.showResultStoreData()
        
        XCTAssertNotEqual(ResultStoreDate.store, "???")
        XCTAssertNotEqual(ResultStoreDate.place, "???")
        XCTAssertNotEqual(ResultStoreDate.genre, "???")
    }
    
    func test_データが大量_それぞれ対応する値が返却される() {
            StoreDataCrudModel.storeDataArray = (0..<1000)
                .map {
                        StoreDataContentsModel(
                            childID: String($0),
                            store: "store",
                            place: "place",
                            genre: "genre")
                }
            
            // measureはパフォーマンスの計測のため
            self.measure {
                ResultStoreDataModel.showResultStoreData()
                
                /// - Note: ランダムのUT実装は困難のため、初期値を異なる値が返却されたらテスト成功とする
                XCTAssertNotEqual(ResultStoreDate.store, "???")
                XCTAssertNotEqual(ResultStoreDate.genre, "???")
                XCTAssertNotEqual(ResultStoreDate.place, "???")
            }
        }
}
