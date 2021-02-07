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
    
    override class func setUp() {
        super.setUp()
//        ResultStoreDate.store = "???"
//        ResultStoreDate.place = "???"
//        ResultStoreDate.genre = "???"
//        StoreDataCrudModel.storeDataArray = []
    }
    
    override class func tearDown() {
        super.tearDown()
        ResultStoreDate.store = "???"
        ResultStoreDate.place = "???"
        ResultStoreDate.genre = "???"
        StoreDataCrudModel.storeDataArray = []
    }
    
    func test_データの数が0の場合_値は初期値から変わらない() {
        if StoreDataCrudModel.storeDataArray.isEmpty == false {
            XCTFail("データの数が1つ以上あるためUT実施不可")
            return
        }
        
        ResultStoreDataModel.showResultStoreData()
        
        XCTAssertEqual(ResultStoreDate.store, "???")
        XCTAssertEqual(ResultStoreDate.place, "???")
        XCTAssertEqual(ResultStoreDate.genre, "???")
    }
    
    func test_データの数が1つ_同じ値が表示され続ける() {
        StoreDataCrudModel.storeDataArray = [.init(childID: "childID_1",
                                                   store: "store_1",
                                                   place: "place_1",
                                                   genre: "genre_1")]
        
        if StoreDataCrudModel.storeDataArray.count != 1 {
            XCTFail()
        }
        
        ResultStoreDataModel.showResultStoreData()
        
        XCTAssertEqual(ResultStoreDate.store, "store_1")
        XCTAssertEqual(ResultStoreDate.place, "place_1")
        XCTAssertEqual(ResultStoreDate.genre, "genre_1")
        
        if StoreDataCrudModel.storeDataArray.count != 1 {
            XCTFail()
        }
        
        ResultStoreDataModel.showResultStoreData()
        
        XCTAssertEqual(ResultStoreDate.store, "store_1")
        XCTAssertEqual(ResultStoreDate.place, "place_1")
        XCTAssertEqual(ResultStoreDate.genre, "genre_1")
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
    
    //TODO コンパイルエラーが発生
//    func test_データが大量_それぞれ対応する値が返却される() {
//        StoreDataCrudModel.storeDataArray = (0..<1000)
//            .map {StoreDataContentsModel(childID: $0,
//                                         store: "store",
//                                         place: "place",
//                                         genre: "genre")
//        }
//
//        self.measure {
//            ResultStoreDataModel.showResultStoreData()
//
//            XCTAssertNotEqual(ResultStoreDate.store, "???")
//            XCTAssertNotEqual(ResultStoreDate.place, "???")
//            XCTAssertNotEqual(ResultStoreDate.genre, "???")
//        }
//    }
}
