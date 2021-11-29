//
//  BusinessSearch.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/11/30.
//

import Foundation

struct BusinessSearch : Decodable{
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region : Decodable{
    var center = Coordinate()
}
