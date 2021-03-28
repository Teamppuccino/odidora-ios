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

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapKakaoLogin(_ sender: UIButton) {
        kakaoLogin { [weak self] (_) in
            self?.getKakaoUserInfo()
        } error: { (<#Error?#>) in
            <#code#>
        }

        
    }
    
//    private func registTokenToFCM() {
//      Messaging.messaging().delegate = self
//      kakaoLogin { (oauthToken) in
//        //
//      } error: { (error) in
//        if let error = error {
//          print(error)
//        }
//      }
//
//    }
    
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
          print(error)
        }
        else {
          print("me() success.")
          
          // 서버로 전송하게 될 유저 정보
          guard let user = user else { return }
          _ = user.id
          _ = user.kakaoAccount?.profile?.nickname
          _ = user.kakaoAccount?.email
          _ = user.kakaoAccount?.birthday
          
        }
      }
    }
    
}
