//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {
    
    @IBOutlet weak var avatarImgView: UIImageView!
    
    @IBOutlet weak var titleLbl:    UILabel!    // リポジトリ名
    @IBOutlet weak var languageLbl: UILabel!    // 言語名
    @IBOutlet weak var starsLbl:    UILabel!    // スター数
    @IBOutlet weak var watchersLbl: UILabel!    // 閲覧者数
    @IBOutlet weak var forksLbl:    UILabel!    // フォーク数
    @IBOutlet weak var issuesLbl:   UILabel!    // イシュー数
    
    // 検索画面
    var searchRepositoryVC: SearchRepositoryViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 対象のリポジトリ取得
        let repo = searchRepositoryVC.repos[searchRepositoryVC.index]
        
        // ラベルに代入
        languageLbl.text = "Written in \(repo["language"] as? String ?? "")"
        starsLbl.text    = "\(repo["stargazers_count"]    as? Int ?? 0) stars"
        watchersLbl.text = "\(repo["watchers_count"]      as? Int ?? 0) watchers"
        forksLbl.text    = "\(repo["forks_count"]         as? Int ?? 0) forks"
        issuesLbl.text   = "\(repo["open_issues_count"]   as? Int ?? 0) open issues"
        
        // アカウントの画像取得
        getImage()
        
    }
    
    // アカウントのイメージ画像取得
    func getImage(){
        // リポジトリ取得
        let repo = searchRepositoryVC.repos[searchRepositoryVC.index]
        
        // フルネーム取得
        titleLbl.text = repo["full_name"] as? String
        
        if let owner = repo["owner"] as? [String: Any] {
            // アバター画像URLがあるなら画像取得処理
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    // 画面に反映
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.avatarImgView.image = img
                    }
                // タスク実行
                }.resume()
            }
        }
    }
}
