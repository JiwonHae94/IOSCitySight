//
//  BusinessSearch.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/11/30.
//

import Foundation

class Business : Decodable, Identifiable, ObservableObject {
    @Published var imageData: Data?
    
    var id : String?
    var alias, name, imageURL, url : String?
    var isClosed : Bool?
    var reviewCount : Int
    var categories : [Category]?
    var rating : Double?
    var coordinates : Coordinate?
    var transaction : [String]?
    var price : String?
    var location : Location?
    var phone : String?
    var displayPhone : String?
    var distance : Double?
    
    enum CodingKeys : String, CodingKey {
        case imageURL = "image_url"
        case reviewCount = "review_count"
        case isClosed = "is_closed"
        case displayPhone = "display_phone"
        
        case id
        case alias
        case name
        case url
        case coordinates
        case rating
        case categories
        case transaction
        case price
        case location
        case phone
        case distance
    }
    
    func getImageData(){
        // Check that image url isn't nil
        guard imageURL != nil else {
            return
        }
        
        // Download the data for the image
        if let url = URL(string: imageURL!){
            // Get a session
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil{
                    DispatchQueue.main.async {
                        // Set the image data
                        self.imageData = data!
                    }
                }
            }
            
            dataTask.resume()
        }
    }
}

struct Category : Decodable{
    var title, alias : String?
}

struct Coordinate : Decodable{
    var latitude, longitude : Double?
}

struct Location : Decodable {
    var address1, address2, address3 : String?
    var city : String?
    var zipCode : String?
    var country : String?
    var state  : String?
    var displayAddress : [String]?
    
    enum CodingKeys : String, CodingKey {
        case zipCode = "zip_code"
        case displayAddress = "display_address"
        
        case address1
        case address2
        case address3
        case city
        case country
        case state
    }
}
