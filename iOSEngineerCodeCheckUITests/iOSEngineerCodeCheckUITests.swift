//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

class iOSEngineerCodeCheckUITests: XCTestCase {
    
    var app:       XCUIApplication! // アプリ
    var screen:    XCUIScreen!      // スクショ用
    var searchBar: XCUIElement!     // 検索バー
    
    override func setUp() {
        super.setUp()
        
        // アプリの起動
        app = XCUIApplication()
        app.launch()
        
        // 各種設定
        screen    = XCUIScreen.main
        searchBar = app.searchFields.firstMatch
    }
    
    // テーブルビューのタップ(何も起こらない)
    func testTapTableView(){
        // 初期のテーブルビュー
        let tableView = app.tables.element(boundBy: 0)
        tableView.tap()
    }
    
    //　空文字検索
    func testSearchNoWord(){
        
        // 空文字入力,検索
        searchBar.tap()
        app.buttons["Search"].tap()
        // 検索結果0
        XCTAssert(app.tables.cells.count == 0, "\(#function) success")
    }
    
    
    //　通常検索
    func testSearch(){
        // 検索
        searchBar.tap()
        searchBar.typeText("test")
        app.buttons["Search"].tap()
        // 検索結果0以上
        XCTAssert(app.tables.cells.count >= 0, "\(#function) success")
    }
    
    //　通常検索後、同じ文字で検索
    func testSearchTwice(){
        // 検索
        self.testSearch()
        // もう一度、同じ語で検索
        searchBar.tap()
        app.buttons["Search"].tap()
        // 検索結果0以上
        XCTAssert(app.tables.cells.count >= 0, "\(#function) success")
    }
    
    //　通常検索後、空文字で検索
    func testSearchTwiceWithNoWord(){
        // 検索
        self.testSearch()
        // 入力した文字を消し、再検索
        searchBar.tap()
        app.buttons["Clear text"].tap()
        app.buttons["Search"].tap()
        // 検索結果0
        XCTAssert(app.tables.cells.count == 0, "\(#function) success")
    }
    
    // 通常検索後、別の語で検索
    func testSearchTwiceWithOtherWord(){
        // 検索
        self.testSearch()
        // 別の語を入力
        searchBar.tap()
        app.buttons["Clear text"].tap()
        searchBar.typeText("hoge")
        app.buttons["Search"].tap()
        // 検索結果0以上
        XCTAssert(app.tables.cells.count >= 0, "\(#function) success")
    }
    
    // 検索後、セルをタップ
    func testCellTap(){
        self.testSearch()
        // 1番目のセルをタップ
        app.tables.cells.element(boundBy: 0).tap()
    }
    
    
    // セルタップ後、検索画面に戻る
    func testRepositoryDetailVCDismiss(){
        self.testCellTap()
        // バックボタンをタップ
        app.buttons.firstMatch.tap()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
