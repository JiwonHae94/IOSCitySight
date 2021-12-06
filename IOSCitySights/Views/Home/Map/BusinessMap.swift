//
//  BusinessMap.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/12/07.
//

import Foundation
import MapKit
import SwiftUI

struct BusinessMap : UIViewRepresentable{
    @EnvironmentObject var model : ContentModel
    
    var locations : [MKPointAnnotation]{
        var annotations = [MKPointAnnotation]()
        
        // Create a set of annotation forom our list businesses
        for business in model.restaurants + model.sights{
            // If the businesss has a lat/long, create an MKPointAnnotation for it
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude{
                
                // Create a new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
            
        }
        
        return annotations
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        // Make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        // TODO:Set the region
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Remove all annotation
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the ones based on the business
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
}
