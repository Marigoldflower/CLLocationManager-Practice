//
//  ViewController.swift
//  CLLocationManager_Practice
//
//  Created by 황홍필 on 2023/05/16.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupLocation()
        
    }
    
    func setupLocation() {
        locationManager.delegate = self
        
        // 해당 앱이 사용자의 위치를 사용하도록 허용할지 물어보는 창을 띄운다.
        // (한 번 허용, 앱을 사용하는 동안 허용, 허용 안 함) 문구가 적혀있는 창을 띄움
        locationManager.requestWhenInUseAuthorization()
        
    }


}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            // "앱을 사용하는 동안 허용", "한 번 허용" 버튼을 클릭하면 이 부분이 실행된다.
            print("GPS 권한 설정됨")
            self.locationManager.startUpdatingLocation() // 중요!
        case .restricted, .notDetermined:
            // 아직 사용자의 위치가 설정되지 않았을 때 이 부분이 실행된다.
            print("GPS 권한 설정되지 않음")
            setupLocation()
        case .denied:
            // "허용 안 함" 버튼을 클릭하면 이 부분이 실행된다.
            print("GPS 권한 요청 거부됨")
            setupLocation()
        default:
            print("GPS: Default")
        }
    }
    
    // 위도, 경도 정보를 얻는 메소드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 가장 최근 업데이트 된 위치를 설정
        let currentLoaction = locations.first
        
        guard let currentLoaction = currentLoaction else { return }
        
        // 최근 업데이트 된 위치의 위도와 경도를 설정
        let latitude = currentLoaction.coordinate.latitude
        let longtitude = currentLoaction.coordinate.longitude
        print("위도: \(latitude) | 경도: \(longtitude)")
    }
}

