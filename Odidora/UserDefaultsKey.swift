//
//  UserDefaultsKey.swift
//  Odidora
//
//  Created by 박지승 on 2021/03/28.
//

import Foundation

enum UserDefaultKeys: String {
  case fcmToken = "fcmToken"
}

class UserDefault {
    static func setUserData(userModel: UserModel) {
        UserDefaults.standard.set(userModel.userId, forKey: "userId")
        UserDefaults.standard.set(userModel.userPw, forKey: "userPw")
        UserDefaults.standard.set(userModel.userName, forKey: "userName")
        UserDefaults.standard.set(userModel.userBirth, forKey: "userBirth")
        UserDefaults.standard.set(userModel.socialType, forKey: "socialType")
        UserDefaults.standard.set(userModel.userImg, forKey: "userImg")
        UserDefaults.standard.set(userModel.userToken, forKey: "userToken")
    }
}
