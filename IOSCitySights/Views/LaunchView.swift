//
//  LaunchView.swift
//  IOSCitySights
//
//  Created by Jiwon_Hae on 2021/12/07.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var model : ContentModel
    
    var body: some View {
        // Detect the authorization status of geolocating the user
        if model.authorizationState == .notDetermined{
            // If undetermined, show onboarding
            
        } else if model.authorizationState == .authorizedAlways ||
                    model.authorizationState == .authorizedWhenInUse{
            
            // If approved, show home view
            HomeView()
            
        } else{
            
           // If deinies show denied view
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
