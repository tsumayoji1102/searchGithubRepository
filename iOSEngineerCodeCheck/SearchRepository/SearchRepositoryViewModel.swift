//
//  SearchRepositoryViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 塩見陵介 on 2020/06/04.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchRepositoryViewModel: NSObject {
    
    var getReposTask: URLSessionTask?
    
    override init() {
        super.init()
    }
    
    // データ取得処理
    func getRepositoriesData(_ url: String, completion: @escaping([Dictionary<String, Any>]) -> Void){
        
        // URLのエンコード(パースミスを防ぐ)
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        GetLog.getLog(message: "\(String(describing: encodedUrl))")
            
        // URL形式にする
        guard encodedUrl != nil, let url = URL(string: encodedUrl!) else{
            return
        }
        // データ取得処理
        getReposTask = URLSession.shared.dataTask(with: url) { (data, res, err) in
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
                    
                // データを返す
                if let items = obj["items"] as? [[String: Any]] {
                    GetLog.getLog(message: "\(items)")
                    completion(items)
                }
            }
        }
        // タスクが設定できてない時
        if(getReposTask == nil){
            return
        }
        // taskの実行
        getReposTask?.resume()
    }
}
