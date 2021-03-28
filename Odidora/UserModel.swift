//
//  UserModel.swift
//  Odidora
//
//  Created by 은영김 on 2021/03/28.
//

import Foundation

struct UserModel: Codable  {
    let userId: String
    let userPw: String
    let userName: String
    let userBirth: String
    let socialType: String
    let userImg: String
    let userToken: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case userPw = "user_pw"
        case userName = "user_name"
        case userBirth = "user_birth"
        case socialType = "social_type"
        case userImg = "user_img"
        case userToken = "user_token"
    }
}
