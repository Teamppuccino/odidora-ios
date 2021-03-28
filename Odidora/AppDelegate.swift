//
//  AppDelegate.swift
//  Odidora
//
//  Created by duckman on 2021/03/17.
//

import UIKit
import Firebase
import KakaoSDKCommon
import KakaoSDKAuth
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Firebase
    FirebaseApp.configure()
    Messaging.messaging().delegate = self
    // 카카오 로그인
    KakaoSDKCommon.initSDK(appKey: "NATIVE_APP_KEY")
    // GoogleMap
    GMSServices.provideAPIKey("AIzaSyBbvDbBb9JCs-ybIpETo86Q6BqNjaEeTLY")
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if AuthApi.isKakaoTalkLoginUrl(url) {
      return AuthController.handleOpenUrl(url: url)
    }
    
    return false
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
  
}

