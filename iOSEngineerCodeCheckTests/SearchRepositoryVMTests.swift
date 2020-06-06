//
//  SearchRepositoryVMTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 塩見陵介 on 2020/06/05.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

class SearchRepositoryVMTests: XCTestCase {
    
    // 対象ViewModel
    var searchRepositoryVM: SearchRepositoryViewModel!
    
    override func setUp() {
        super.setUp()
        
        // 初期化
        searchRepositoryVM = SearchRepositoryViewModel()
    }
    
    // APIの動作
    func testAPI(word: String, completion: @escaping([[String: Any]]?) -> Void){
        
        let url = "https://api.github.com/search/repositories?q=\(word)"
        searchRepositoryVM.getRepositoriesData(url, completion: {
            data in
            XCTAssertNotNil(data, "data is not nil")
            completion(data)
        })
    }
    
    // 空文字で検索(実際にはこのviewModel上でおきない)
    func testSearchNoWord(){
        
        // メソッドが途中で終わるため、expectationを用いない
        self.testAPI(word: "", completion: { data in
            XCTAssertNil(data!, "\(#function) success")
        })
    }
    
    // 英字で検索
    func testSearchInEnglish(){
        let exp = expectation(description: "\(#function)")
        
        self.testAPI(word: "hoge", completion: { data in
            XCTAssertTrue(data!.count >= 0, "\(#function) success")
            exp.fulfill()
        })
         wait(for: [exp], timeout: 5)
    }
    
    // 数字で検索
    func testSearchInEnglishAndNumber(){
        let exp = expectation(description: "\(#function)")
        
        self.testAPI(word: "1", completion: { data in
            XCTAssertTrue(data!.count >= 0, "\(#function) success")
            exp.fulfill()
        })
         wait(for: [exp], timeout: 5)
    }
    
    // 日本語で検索
    func testSearchInJapanese(){
        let exp = expectation(description: "\(#function)")
        
        self.testAPI(word: "あいうえお", completion: { data in
            XCTAssertTrue(data!.count >= 0, "\(#function) success")
            exp.fulfill()
        })
         wait(for: [exp], timeout: 5)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
