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
    @State var selectedBusiness : Business? = nil
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0{
            NavigationView {
                // Determine if we should show list of map
                if !isMapShowing{
                    // Show list
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "location")
                            Text("San Francisco")
                            Spacer()
                            Button("Switch to map view"){
                                self.isMapShowing = true
                            }
                        }
                        
                        Divider()
                        
                        BusinessList()
                        
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                
                } else{
                    // Show map
                    BusinessMap(selectedBusiness: $selectedBusiness)
                        .ignoresSafeArea()
                        .sheet(item: $selectedBusiness){ business in
                            
                            // Create a business detail view instance
                            // Pass in the selected business
                            BusinessDetail(business: business)
                        }
                }
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
