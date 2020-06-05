//
//  RepositoryDetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 塩見陵介 on 2020/06/04.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositoryDetailViewModel: NSObject {
    
    var getImageTask: URLSessionTask?

    override init() {
        super.init()
    }
    
    // 画像取得処理
    func getImageFromRepo(_ repoData: Dictionary<String, Any>, completion: @escaping(UIImage?) -> Void){
        
        if let owner = repoData["owner"] as? [String: Any] {
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
                getImageTask = URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
            
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
                    // 画像を返却
                    completion(img)
                }
                getImageTask?.resume()
            }
        }
    }
    
    
}
