//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var reposSearchBar: UISearchBar!
    
    var repos:       [[String: Any]]=[]   // 取得したリポジトリ
    var getRepoTask: URLSessionTask?      // 取得処理のタスク
    var searchWord:  String!              // 検索ワード
    var searchUrl:   String!              // リポジトリ検索APIのURL
    var index:       Int!                 // リポジトリの行番号(画面遷移時)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetLog.getLog(message: nil)
        
        // 検索バーの初期化
        reposSearchBar.text     = "GitHubのリポジトリを検索できるよー"
        reposSearchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        GetLog.getLog(message: nil)
    }
    
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
        cell.repositoryTitle.text  = repo["full_name"] as? String ?? ""
        cell.usedLanguage.text     = repo["language"]  as? String ?? ""
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
