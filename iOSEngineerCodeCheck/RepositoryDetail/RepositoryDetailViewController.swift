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
    @IBOutlet weak var titleLbl:      UILabel!    // リポジトリ名
    @IBOutlet weak var languageLbl:   UILabel!    // 言語名
    @IBOutlet weak var starsLbl:      UILabel!    // スター数
    @IBOutlet weak var watchersLbl:   UILabel!    // 閲覧者数
    @IBOutlet weak var forksLbl:      UILabel!    // フォーク数
    @IBOutlet weak var issuesLbl:     UILabel!    // イシュー数
    
    // 取得リポジトリ
    var detailRepo = Dictionary<String, Any>()
    
    // 検索画面
    var searchRepositoryVC: SearchRepositoryViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        GetLog.getLog(message: nil)
        
        // 対象のリポジトリ取得(nilにはならない)
        detailRepo = searchRepositoryVC.repos[searchRepositoryVC.index]
        GetLog.getLog(message: "\(detailRepo)")

        // ラベルに代入
        languageLbl.text = "Written in \(detailRepo["language"] as? String ?? "?")"
        starsLbl.text    = "\(detailRepo["stargazers_count"]    as? Int ?? 0) stars"
        watchersLbl.text = "\(detailRepo["watchers_count"]      as? Int ?? 0) watchers"
        forksLbl.text    = "\(detailRepo["forks_count"]         as? Int ?? 0) forks"
        issuesLbl.text   = "\(detailRepo["open_issues_count"]   as? Int ?? 0) open issues"
        
        // アカウントの画像取得
        getImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        GetLog.getLog(message: nil)
    }
    
    // アカウントのイメージ画像取得
    func getImage(){
        
        GetLog.getLog(message: nil)
        // フルネーム取得
        titleLbl.text = detailRepo["full_name"] as? String
        
        if let owner = detailRepo["owner"] as? [String: Any] {
            GetLog.getLog(message: "\(owner)")
            
            // アバター画像URLがあるなら画像取得処理
            if let imgURL = owner["avatar_url"] as? String {
                GetLog.getLog(message: "\(imgURL)")
                
                // 画像取得URLを取得
                guard let imageUrl = URL(string: imgURL) else {
                    return
                }
                GetLog.getLog(message: "\(imageUrl)")
                
                // タスク内容設定
                URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
            
                    GetLog.getLog(message: nil)
                    // エラーなら終了
                    if(err != nil){
                        GetLog.getLog(message: "\(err!)")
                        return
                    }
                    // 画像取得
                    guard data != nil, let img = UIImage(data: data!) else{
                        return
                    }
                    // 非同期で画像を反映
                    DispatchQueue.main.async {
                        self.avatarImgView.image = img
                    }
                // タスク実行
                }.resume()
            }
        }
    }
}
