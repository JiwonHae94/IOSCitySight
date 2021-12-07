//
//  YelpAttribution.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/12/08.
//

import SwiftUI

struct YelpAttribution: View {
    var link : String
    
    var body: some View {
        Link(destination: URL(string: link)!) {
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
        }
    }
}

struct YelpAttribution_Previews: PreviewProvider {
    static var previews: some View {
        YelpAttribution(link: "https://yelp.com")
    }
}
