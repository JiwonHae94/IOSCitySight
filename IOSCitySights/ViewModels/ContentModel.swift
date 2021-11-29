//
//  ContentModel.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/11/30.
//

import Foundation
import CoreLocation

class ContentModel : NSObject, CLLocationManagerDelegate, ObservableObject{
    
    var locationManager = CLLocationManager()
    
    override init(){
        super.init()
        
        // Request permission from the user
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    

    //MARK: check whether use has granted authorization
    func locationManagerDidChangeAuthorization(_ manager : CLLocationManager){

        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse{
            // We have permission
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied{
            // We don't have permission
        }
    }
    
    //MARK: update location info
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Give us the locatin of the user
        let userLocation = locations.first
        if userLocation != nil{
            // WE have location
            // Stop requesting the location after we get it once
            //locationManager.stopUpdatingLocation()
            
            getBusinesses(category: "arts", location: userLocation!)
            getBusinesses(category: "resturants", location: userLocation!)
        }
        
    }
    
    //MARK: - Yelp API methods
    func getBusinesses(category : String, location : CLLocation){
        // create URL
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name:"latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name:"longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name:"categories", value: category),
            URLQueryItem(name:"limit", value: "6")
        ]
        
        var url = urlComponents?.url
        if let url = url {
            
            // Create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer 69IqlkS3Z1ytSBbE6G3noFy16kp8bxXGTAHhza8eMvyA-HkmYqxXJBakxcepUuy2c_gxu9NlVz4WfoFTzP4vTG8tqmmZxrXUlZm_wQxC0GXOwUxbdeI7JGg2Aq90YHYx", forHTTPHeaderField: "Authorization")
            
            // Create URLSession
            let session = URLSession.shared
            
            // Create Data Task
            session.dataTask(with: request) { (data, response, error) in
                //
                if error == nil {
                    print(error)
                }
                print(data)
            }.resume()
        }
        
        
        
                
                
    }
}
