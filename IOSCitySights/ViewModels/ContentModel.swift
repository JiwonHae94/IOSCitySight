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
    
    @Published var resturants = [Business]()
    @Published var sights = [Business]()
    
    override init(){
        super.init()
        
        // Request permission from the user
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    

    //MARK: check whether use has granted authorization
    func locationManagerDidChangeAuthorization(_ manager : CLLocationManager){

        // Update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
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
            locationManager.stopUpdatingLocation()
            
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.resturantsKey, location: userLocation!)
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
                        let result = try decoder.decode(BusinessSearch.self, from : data!)
                        
                        // Sort businesses
                        var businesses = result.businesses
                        businesses.sort { b1, b2 in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        // Call the get image function of the business
                        for b in businesses{
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            
                            // Assing results to the appropriate category
                            switch category{
                            case Constants.sightsKey:
                                self.sights = businesses
                            case Constants.resturantsKey:
                                self.resturants = businesses
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
