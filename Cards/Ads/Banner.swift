//
//  Banner.swift
//  Cards
//
//  Created by Felipe Camara on 17/04/22.
//

import SwiftUI
import GoogleMobileAds

struct Banner: UIViewRepresentable {

    var unitID: String
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> GADBannerView{
        
        let adView = GADBannerView()
        adView.adSize = GADAdSizeFromCGSize(CGSize(width: 300, height: 50))
        
        adView.adUnitID = unitID
        adView.rootViewController = UIApplication.shared.getViewController()
        adView.delegate = context.coordinator
        
        adView.load(GADRequest())
        
        return adView
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, GADBannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
          print("bannerViewDidReceiveAd")
        }

        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
          print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        }

        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
          print("bannerViewDidRecordImpression")
        }

        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
          print("bannerViewWillPresentScreen")
        }

        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
          print("bannerViewWillDIsmissScreen")
        }

        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
          print("bannerViewDidDismissScreen")
        }
    }
    
}
extension UIApplication {
    func getViewController() -> UIViewController {
        
        guard let screen = self.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
        
    }
}
