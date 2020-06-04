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
    
    var repos:      [[String: Any]]=[]
    var task:       URLSessionTask?
    var searchWord: String!
    var url:        String!
    var index:      Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 検索バーの初期化
        reposSearchBar.text     = "GitHubのリポジトリを検索できるよー"
        reposSearchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 検索バーのワードをリセット
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 検索ワード取得
        searchWord = searchBar.text!
        
        // 0文字なら処理しない
        if searchWord.count != 0 {
            // URLに代入
            url  = "https://api.github.com/search/repositories?q=\(searchWord!)"
            // データ取得処理
            task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
                if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any]{
                    // データをテーブルに反映
                    if let items = obj["items"] as? [[String: Any]] {
                        self.repos = items
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            // taskの実行
            task?.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RepositoryDetail"{
            let repositoryDetailVC = segue.destination as! RepositoryDetailViewController
            repositoryDetailVC.searchRepositoryVC = self
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let repo = repos[indexPath.row]
        cell.textLabel?.text       = repo["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repo["language"]  as? String ?? ""
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        index = indexPath.row
        performSegue(withIdentifier: "RepositoryDetail", sender: self)
        
    }
    
}
