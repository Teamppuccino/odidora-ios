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
        setGoogleMap()
        setLocation()
    }
    
    private func setGoogleMap() {
        mapView.delegate = self
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        self.view.addSubview(mapView)
    }
    
    private func setLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도
        setCamera()
    }
    
    private func setCamera() {
        let coor = locationManager.location?.coordinate
        guard let lat = coor?.latitude,
              let long = coor?.longitude else { return }
        let camera = GMSCameraPosition
            .camera(withLatitude: lat, longitude: long, zoom: 14.0)
        mapView.camera = camera
    }
}

extension HomeViewController: GMSMapViewDelegate, CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied, .restricted: // 위치 거부
            break // 알림 : 위치 거부 시 이용할 수 없습니다 -> 강제 종료
        case .notDetermined: // 다음에 확인
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            self.setCamera()
        @unknown default:
            break
        }
    }
    
}
