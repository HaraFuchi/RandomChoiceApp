//
//  CategoryListTypeTests.swift
//  RandomChoiceTests
//
//  Created by 渕一真 on 2021/01/25.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import XCTest
@testable import Debugさいころdeごはん

class CategoryListTypeTests: XCTestCase {
    func test_カテゴリータイトル_それぞれ対応した値を返す() {
        XCTAssertEqual(CategoryListType.store.title, "店名")
        XCTAssertEqual(CategoryListType.place.title, "場所")
        XCTAssertEqual(CategoryListType.genre.title, "ジャンル")
        XCTAssertNil(CategoryListType.signup.title)
    }

    func test_カテゴリープレースホルダー_それぞれ対応した値を返す() {
        XCTAssertEqual(CategoryListType.store.placeHolder, "例) サイゼリヤ")
        XCTAssertEqual(CategoryListType.place.placeHolder, "例) 新宿")
        XCTAssertEqual(CategoryListType.genre.placeHolder, "例) イタリアン")
        XCTAssertNil(CategoryListType.signup.placeHolder)
    }
}
