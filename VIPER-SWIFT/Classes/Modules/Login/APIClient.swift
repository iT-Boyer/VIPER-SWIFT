//
//  APIClient.swift
//  hsg.lib.Utils
//
//  Created by admin on 2018/11/20.
//  Copyright © 2018年 clcw. All rights reserved.
//

import Foundation

let userInfo = ["1": "123"]

public struct APIClient {
    
    public enum APIError {
        case EmptyUserName, EmptyPassword, UserNotFound, WrongPassword
    }
    
    static public func login(userName: String, pwd: String, completionHandler: ((Bool, APIError?) -> ())?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            print("Are we there yet?")
            DispatchQueue.main.async {
//                self.imageView.image = image
                if userName.count == 0 {
                    completionHandler?(false, .EmptyUserName)
                    return
                }
                
                if pwd.count == 0 {
                    completionHandler?(false, .EmptyPassword)
                    return
                }
                
                if !userInfo.keys.contains(userName) {
                    completionHandler?(false, .UserNotFound)
                    return
                }
                
                if userInfo[userName] != pwd {
                    completionHandler?(false, .WrongPassword)
                    return
                }
                completionHandler?(true, nil)
            }
        }
    }
}
