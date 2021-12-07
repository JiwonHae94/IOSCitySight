//
//  ContentModel.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/11/30.
//

import Foundation
import CoreLocation

class ContentModel : NSObject, CLLocationManagerDelegate, ObservableObject{
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    var locationManager = CLLocationManager()
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    @Published var placemark : CLPlacemark? = nil
    
    override init(){
        
        // Init method of NSObject
        super.init()
        
        // Set content model as the delegate of the location manager
        locationManager.delegate = self
    }
    
    func requestGeolocationPermission(){
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
    }
    

    //MARK: check whether use has granted authorization
    func locationManagerDidChangeAuthorization(_ manager : CLLocationManager){

        // Update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // Start geolocating the user, after we get permission
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
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
            locationManager.stopUpdatingLocation()
            
            // Get the placemark of the user
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(userLocation!){ (placemarks, error) in
                // Check that there aren't errros
                if error == nil && placemarks != nil {
                    // Take the first placemark
                    self.placemark = placemarks?.first
                }
            }
            
            
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
        }
        
    }
    
    //MARK: - Yelp API methods
    func getBusinesses(category : String, location : CLLocation){
        // create URL
        var urlComponents = URLComponents(string: Constants.apiURL)
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
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Create URLSession
            let session = URLSession.shared
            
            // Create Data Task
            session.dataTask(with: request) { (data, response, error) in
                //
                if error == nil {
                    do {
                        // parse json
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // Sort businesses
                        var businesses = result.businesses
                        businesses.sort { (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        // Call the get image function of the businesses
                        for b in businesses {
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            
                            // Assign results to the appropriate property
                            
                            switch category {
                            case Constants.sightsKey:
                                self.sights = businesses
                            case Constants.restaurantsKey:
                                self.restaurants = businesses
                            default:
                                break
                            }
                        }

                        
                    }
                    catch{
                        print(error)
                    }
                    
                }
                
                
            }.resume()
        }
        
        
        
                
                
    }
}
