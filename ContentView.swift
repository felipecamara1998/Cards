//
//  ContentView.swift
//  Cards
//
//  Created by Felipe Camara on 16/10/21.
//

import SwiftUI
import CoreData
import StoreKit
import GoogleMobileAds

struct ContentView: View {
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }

    var body: some View {
        
		Home()
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
