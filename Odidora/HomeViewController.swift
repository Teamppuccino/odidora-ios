//
//  HomeViewController.swift
//  Odidora
//
//  Created by 박지승 on 2021/03/27.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController {
  
  private let locationManager =  CLLocationManager()
  private lazy var mapView = GMSMapView(frame: self.view.frame)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  private func setGoogleMap() {
    mapView.delegate = self
    mapView.settings.myLocationButton = true
    mapView.isMyLocationEnabled = true
    self.view.addSubview(mapView)
  }
  
  private func setLocation() {
    locationManager.delegate = self
    locationManager.requestLocation()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도
    guard let coordinate = locationManager.location?.coordinate else { return }
    let zoom: Float = 14.0
    mapView.camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: zoom)
  }
}

extension HomeViewController: GMSMapViewDelegate, CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .denied: // 위치 거부
      break
    case .notDetermined: // 다음에 확인
      break
    case .authorizedAlways, .authorizedWhenInUse:
      locationManager.requestLocation()
    case .restricted:
      break
    @unknown default:
      break
    }
  }
}
