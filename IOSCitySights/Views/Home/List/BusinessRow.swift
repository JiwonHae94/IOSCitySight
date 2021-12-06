//
//  BusinessRow.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/12/07.
//

import SwiftUI

struct BusinessRow: View {
    @ObservedObject var business : Business
    
    var body: some View {
    
        VStack(alignment: .leading){
            HStack{
                //Image
                let uiImage = UIImage(data: business.imageData ?? Data())
                
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                
                // Name and distance
                VStack(alignment: .leading){
                    Text(business.name ?? "")
                    Text(String(format:"%.1f km away", (business.distance ?? 0)/1000)
                    ).font(.caption)
                }
                Spacer()
                
                // Star rating and number of views
                VStack(alignment: .leading){
                    Image("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
        }.foregroundColor(.black)
    }
}
