//
//  BusinessTitle.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/12/08.
//

import SwiftUI

struct BusinessTitle: View {
    var business : Business
    
    var body: some View {
        VStack(alignment: .leading){
            
            // Business Name
            Text(business.name!)
                .font(.title2)
                .bold()
            
            // Address
            if business.location?.displayAddress != nil{
                ForEach(business.location!.displayAddress!, id: \.self){ displayLine in
                    Text(displayLine)
                }
            }
            
            // Rating
            Image("regular_\(business.rating ?? 0)")
            
        }
    }
}
