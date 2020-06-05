//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchRepositoryViewController: UITableViewController{

    @IBOutlet weak var reposSearchBar: UISearchBar!
    
    var repos:       [[String: Any]]=[]   // 取得したリポジトリ
    var searchWord:  String!              // 検索ワード
    var searchUrl:   String!              // リポジトリ検索APIのURL
    var index:       Int!                 // リポジトリの行番号(画面遷移時)
    
    var viewModel: SearchRepositoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetLog.getLog(message: nil)
        
        // 空のデータを表示させない
        self.tableView.tableFooterView = UIView()
        
        // viewModel初期化
        viewModel = SearchRepositoryViewModel()
        
        // 検索バーの初期化
        reposSearchBar.placeholder = "リポジトリ名を入力"
        reposSearchBar.delegate    = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        GetLog.getLog(message: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        GetLog.getLog(message: nil)
        
        if segue.identifier == "RepositoryDetail"{
            let repositoryDetailVC = segue.destination as! RepositoryDetailViewController
            repositoryDetailVC.searchRepositoryVC = self
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        GetLog.getLog(message: "repos.count: \(repos.count)")
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        GetLog.getLog(message: nil)
        
        // セル生成
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! SearchRepositoryCell
        
        // リポジトリ取得
        let repo = repos[indexPath.row]
        // テーブルに反映
        cell.repositoryTitle.text = repo["full_name"] as? String ?? ""
        cell.usedLanguage.text    = repo["language"]  as? String ?? ""
        // セルの行番号を設定
        cell.tag = indexPath.row
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        GetLog.getLog(message: "index: \(String(describing: index))")
        
        // 画面遷移時に呼ばれる
        index = indexPath.row
        performSegue(withIdentifier: "RepositoryDetail", sender: self)
        
    }
}
