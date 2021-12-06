//
//  HomeView.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/12/07.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model : ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        if model.resturants.count != 0 || model.sights.count != 0{
            // Determine if we should show list of map
            if !isMapShowing{
                // Show list
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "location")
                        Text("San Francisco")
                        Spacer()
                        Text("Switch to map views")
                    }
                    
                    Divider()
                    
                    BusinessList()
                    
                }.padding([.horizontal, .top])
            }else{
                // Show map
            }
            
        }else{
            // Still  wating for data so show spinner
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
