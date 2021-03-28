//
//  LoginViewController.swift
//  Odidora
//
//  Created by duckman on 2021/03/25.
//

import UIKit
import Firebase
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController, MessagingDelegate {

      var userModel: UserModel = UserModel(userId: "", userPw: "", userName: "", userBirth: "", socialType: "", userImg: "", userToken: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapKakaoLogin(_ sender: UIButton) {
        kakaoLogin { [weak self] (_) in
            self?.getKakaoUserInfo()
        } error: { (error) in
            if let error = error {
              print(error)
            }
        }
    }
    
    private func kakaoLogin(success: @escaping (OAuthToken?) -> Void, error: @escaping (Error?) -> Void) {
      if (UserApi.isKakaoTalkLoginAvailable()) { // 유저 폰에 카카오톡 있을 경우
        UserApi.shared.loginWithKakaoTalk {(oauthToken, err) in
          // 카카오톡 로그인 시도
          success(oauthToken)
          error(err)
        }
      } else {
        // 유저 폰에 카카오톡 없을 경우
        UserApi.shared.loginWithKakaoAccount {(oauthToken, err) in
          success(oauthToken)
          error(err)
        }
      }
    }
    
    // 로그인 테스트를 위해 추가
    private func kakaoLogout() {
      UserApi.shared.logout {(error) in
        if let error = error {
          print(error)
        }
        else {
          print("logout() success.")
        }
      }
    }
    
    private func getKakaoUserInfo() {
      UserApi.shared.me() {(user, error) in
        if let error = error {
          print(error.localizedDescription)
        }
        else {
          // 서버로 전송하게 될 유저 정보
            guard let user = user else { return }
            guard let id = user.kakaoAccount?.email,
                  let name = user.kakaoAccount?.profile?.nickname,
                  let birth = user.kakaoAccount?.birthday,
                  let token = UserDefaults.standard.string(forKey: UserDefaultKeys.fcmToken.rawValue)
            else { return }
            
            var img: String?
            if let imgurl = user.kakaoAccount?.profile?.thumbnailImageUrl  {
                img = try? String(contentsOf: imgurl)
            }
            
            self.userModel = UserModel(userId: id, userPw: String(Int(user.id)), userName: name, userBirth: birth, socialType: "kakao", userImg: img ?? "", userToken: token)
          
        }
      }
    }
    
}
