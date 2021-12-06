//
//  BusinessList.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/12/07.
//

import SwiftUI

struct BusinessList: View {
    @EnvironmentObject var model : ContentModel
    
    
    var body: some View {
        ScrollView{
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                
                BusinessSection(title: "Restuarants", businesss: model.resturants)
                
                
                BusinessSection(title: "Sights", businesss: model.sights)
            }
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
        
    }
}