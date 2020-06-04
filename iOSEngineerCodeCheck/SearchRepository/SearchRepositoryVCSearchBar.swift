//
//  SearchRepositoryVCSearchBar.swift
//  iOSEngineerCodeCheck
//
//  Created by 塩見陵介 on 2020/06/04.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

// MARK: - UISearchBarDelegate

extension SearchRepositoryViewController: UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        GetLog.getLog(message: nil)
        // 検索バーのワードをリセット
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        GetLog.getLog(message: nil)
        getRepoTask?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 検索ワード取得
        searchWord = searchBar.text!
        GetLog.getLog(message: "\(String(describing: searchWord))")
        
        // 0文字なら処理しない
        if searchWord.count != 0 {
            // URLに代入
            searchUrl = "https://api.github.com/search/repositories?q=\(searchWord!)"
            GetLog.getLog(message: "\(String(describing: searchUrl))")
            // 取得ミス時
            if(searchUrl == nil){
                return
            }
            // URLのエンコード(パースミスを防ぐ)
            let encodedUrl = searchUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            GetLog.getLog(message: "\(String(describing: encodedUrl))")
            
            // URL形式にする
            guard encodedUrl != nil, let url = URL(string: encodedUrl!) else{
                return
            }
            // データ取得処理
            getRepoTask = URLSession.shared.dataTask(with: url) { (data, res, err) in
                // エラーがあるなら終了
                if err != nil {
                    GetLog.getLog(message: "\(String(describing: err))")
                    return
                }
                // データがないなら終了
                if data == nil {
                    
                    return
                }
                // パース処理
                if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any]{
                    GetLog.getLog(message: "\(String(describing: obj))")
                    
                    // データをテーブルに反映
                    if let items = obj["items"] as? [[String: Any]] {
                        GetLog.getLog(message: "\(items)")
                        self.repos = items
                        
                        // 非同期で更新
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            // タスクが設定できてない時
            if(getRepoTask == nil){
                return
            }
            // taskの実行
            getRepoTask?.resume()
        }
    }
}

