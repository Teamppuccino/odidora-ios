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
    
    static func requestSocialLogin(user: UserModel, _ handler: @escaping (UserModel) -> Void) {
        guard let url = URL(string: "http://13.125.69.195:3000" + "/user/social_login") else { return }
        guard let jsonData = try? JSONEncoder().encode(user),
              let param = try? JSONSerialization.jsonObject(with: jsonData) as? [String: String]
              else { return }
        
        AF.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody)
            .responseDecodable(of: SocialLoginResponse.self) { response in
            switch response.result {
            case .success(let value):
                if value.code == 200 {
                    handler(value.data)
                }
            case .failure(let e):
                print(e.localizedDescription)
            }
        }
    }
    
    static func requestLogin(id: String, token: String, _ handler: @escaping (UserModel) -> Void) {
        guard let url = URL(string: "http://13.125.69.195:3000" + "/user/id_check") else { return }
        let param: Parameters = [
            "user_id" : id,
            "user_token" : token
        ]
        AF.request(url, method: .post, parameters: param)
            .responseDecodable(of: SocialLoginResponse.self) { response in
                switch response.result {
                case .success(let value):
                    if value.code == 200 {
                        handler(value.data)
                    }
                case .failure(let e):
                    print(e.localizedDescription)
                }
            }
        
    }
}
