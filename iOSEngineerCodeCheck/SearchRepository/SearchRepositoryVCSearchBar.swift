//
//  SearchRepositoryVCSearchBar.swift
//  iOSEngineerCodeCheck
//
//  Created by 塩見陵介 on 2020/06/04.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import PKHUD

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
        viewModel.getReposTask?.cancel()
    }
    
    // クリック
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 同じ検索ワードなら処理しない
        if(searchBar.text! == searchWord){
            return
        }
        // 検索ワード取得
        searchWord = searchBar.text!
        GetLog.getLog(message: "\(String(describing: searchWord))")
        
        // 0文字なら処理しない
        if searchWord.count != 0 {
            HUD.flash(.progress, delay: 0.0)
            // URLに代入
            searchUrl = "https://api.github.com/search/repositories?q=\(searchWord!)"
            GetLog.getLog(message: "\(String(describing: searchUrl))")
            // 取得ミス時
            if(searchUrl == nil){
                HUD.hide()
                return
            }
            // データ取得
            viewModel.getRepositoriesData(searchUrl){ items in
                // 取得データ反映
                self.repos = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    HUD.hide()
                }
            }
        // 0文字の時
        }else{
            // 初期化、セルを空で表示
            self.repos = [[String: Any]]()
            self.tableView.reloadData()
        }
    }
}

