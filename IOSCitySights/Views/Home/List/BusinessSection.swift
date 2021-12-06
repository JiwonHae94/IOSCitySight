//
//  BusinessSection.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/12/07.
//

import SwiftUI

struct BusinessSection: View {
    var title : String
    var businesss : [Business]
    
    var body: some View {
        Section(header: BusinessSectionHeader(title: title)){
            
            ForEach(businesss){ business in
                BusinessRow(business: business)
                
            }
        }
    }
}
