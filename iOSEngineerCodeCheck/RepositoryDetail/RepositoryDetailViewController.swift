//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositoryDetailViewController: UIViewController {
    
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
    
    // viewModel
    var viewModel: RepositoryDetailViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        GetLog.getLog(message: nil)
        
        viewModel = RepositoryDetailViewModel()
        
        // 対象のリポジトリ取得(nilにはならない)
        detailRepo = searchRepositoryVC.repos[searchRepositoryVC.index]
        GetLog.getLog(message: "\(detailRepo)")

        // ラベルに代入
        titleLbl.text    = detailRepo["full_name"]              as? String ?? "?"
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
        // 画像取得処理
        viewModel.getImageFromRepo(detailRepo){ img in
            
            if(img != nil){
                // 非同期で画像を反映
                DispatchQueue.main.async {
                    self.avatarImgView.image = img
                }
            }
        }
    }
}
