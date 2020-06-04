//
//  GetLog.swift
//  iOSEngineerCodeCheck
//
//  Created by 塩見陵介 on 2020/06/04.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class GetLog: NSObject {
    
    static func getLog(
        function: String = #function,
        file:     String = #file,
        line:     Int    = #line,
        message:  String!){
        
        if(message != nil){
            Swift.print("\(file):\(line)行目 \(function) \n\(String(describing: message))")
        }else{
            Swift.print("\(file):\(line)行目 \(function)")
        }
        
    }

}
