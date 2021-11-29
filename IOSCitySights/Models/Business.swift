//
//  BusinessSearch.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/11/30.
//

import Foundation

struct Business : Decodable{
    var id : String?
    var alias, name, image_url, url : String?
    var is_closed : Bool?
    var review_count : Int
    var cateogires : [Category]?
    var rating : Double?
    var coodinates : Coordinate?
    var transaction : [String]?
    var price : String?
    var location : Location?
    var phone : String?
    var display_phone : String?
    var distance : Double?
}

struct Category : Decodable{
    var title, alias : String?
}

struct Coordinate : Decodable{
    var latitude, longitude : Double?
}

struct Location : Decodable{
    var address1, address2, address3 : String?
    var city : String?
    var zip_code : String?
    var country : String?
    var state  : String?
    var display_address : [String]?
}
