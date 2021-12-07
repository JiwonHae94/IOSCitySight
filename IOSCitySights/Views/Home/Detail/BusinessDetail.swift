//
//  BusinessDetail.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/11/30.
//

import SwiftUI

struct BusinessDetail: View {
    var business : Business
    
    @State private var showDirections = false
    
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 0){
                GeometryReader(){ geometry in
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage : uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
                .ignoresSafeArea(.all, edges: .top)
                
                // Open / Closed indicator
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(!business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                }

            }
            
            
            Group {
                // Business Name
                BusinessTitle(business: business)
                    .padding()
                Divider()
                
            
                
                // Phone
                HStack{
                    Text("Phone: ")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }.padding()
                
                Divider()
                
                // Reviews
                HStack{
                    Text("Reviews: ")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                Divider()
                
                // Websites
                HStack{
                    Text("Webstie: ")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                // Get directoin button
                Button{
                    showDirections = true
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        
                        Text("Get Directions")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .padding()
                .sheet(isPresented: $showDirections){
                    DirectionsView(business: business)
                }

            }
        }
    }
}
