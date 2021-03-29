//
//  APIManager.swift
//  Odidora
//
//  Created by 은영김 on 2021/03/28.
//

import Foundation
import Alamofire
import SwiftyJSON


// MARK: - Post

class APIManager {
    
    static func requestSocialLogin(user: UserModel, _ handler: @escaping (JSON) -> Void) {
        guard let url = URL(string: "http://13.125.69.195:3000" + "/user/social_login") else { return }
        guard let jsonData = try? JSONEncoder().encode(user),
              let param = try? JSONSerialization.jsonObject(with: jsonData) as? [String: String]
              else { return }
        
        AF.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody)
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                handler(JSON(value))
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
    }
}
