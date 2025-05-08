//
//  LocationService.swift
//  Xplore
//
//  Created by Dilshad P on 08/05/25.
//

import Foundation
import CoreLocation
import Combine

class LocationService: NSObject {
    
    var locationPublisher = PassthroughSubject<CLLocationCoordinate2D, Never>()
    var deniedLocationAccessPublisher = PassthroughSubject<Void, Never>()
    
    lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    func requestLocationAccess() {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            manager.requestWhenInUseAuthorization()
        case .denied:
            deniedLocationAccessPublisher.send()
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
}

extension LocationService : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last?.coordinate {
            manager.stopUpdatingLocation()
            locationPublisher.send(currentLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}

extension LocationService {
    
    func getDistance(longitude: String, lattitude: String, placeID: String,apiKey: String,completion:@escaping(Result<String,FetchLocationError>) -> Void){
        
        let baseURL = "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=place_id:\(placeID)&origins=\(lattitude)%2C\(longitude)&units=imperial&key=\(apiKey)"
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(.URLError))
            return
        }
        let urlRequest = URLRequest(url: url)
        
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200, error == nil else {
                completion(.failure(.NetworkError))
                return
            }
            guard let data = data else {
                completion(.failure(.DataError))
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode(Response.self, from: data)
                let text = decodedData.rows.first?.elements.first?.duration.text ?? ""
                print(text)
            }catch{
                
            }
        }
        .resume()
    }
}

enum FetchLocationError: Error {
    case DataError
    case NetworkError
    case URLError
}


struct Response: Decodable {
    
    let rows: [Row]
    
}
struct Row: Decodable {
  
    let elements: [Element]
                   
}

struct Element: Decodable {
    
    let duration: Duration
    
}

struct Duration: Decodable {
    
    let text: String
    
}
