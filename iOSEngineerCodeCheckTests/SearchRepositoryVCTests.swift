//
//  SearchRepositoryVCTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 塩見陵介 on 2020/06/05.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class SearchRepositoryVCTests: XCTestCase {
    
    // テスト対象のVC
    var searchRepositoryVC: SearchRepositoryViewController!
    
    override func setUp() {
        super.setUp()
        
        // VCの初期化
        searchRepositoryVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchRepositoryViewController") as? SearchRepositoryViewController
    }
    
    // 初期化の確認
    func testAppearedTableView(){
        
        // ナビゲーションアイテムの存在
        XCTAssertNotNil(searchRepositoryVC.navigationItem, "navigationItem is not nil")
        XCTAssertEqual(searchRepositoryVC.navigationItem.title, "リポジトリ検索")
        
        // テーブルビューの存在
        XCTAssertNotNil(searchRepositoryVC.tableView, "TableView is not nil")
        XCTAssertTrue(searchRepositoryVC.view.contains(searchRepositoryVC.tableView), "tableView contains the VC.")
        
        // 検索バーの存在
        XCTAssertNotNil(searchRepositoryVC.reposSearchBar, "repoSearchBar is not nil")
        XCTAssertTrue(searchRepositoryVC.view.contains(searchRepositoryVC.reposSearchBar), "searchBar contains the VC.")
        XCTAssertEqual(searchRepositoryVC.reposSearchBar.placeholder, "リポジトリ名を入力")
        
        // viewModelの存在
        XCTAssertNotNil(searchRepositoryVC.viewModel, "viewModel is not nil")
        
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
