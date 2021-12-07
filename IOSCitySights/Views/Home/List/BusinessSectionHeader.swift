//
//  BusinessSectionHeader.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/12/07.
//

import SwiftUI

struct BusinessSectionHeader: View {
    var title : String
    
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 45)
            
            Text(title)
                .font(.headline)
        }
    }
}

struct BusinessSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSectionHeader(title : "Resturants")
    }
}
