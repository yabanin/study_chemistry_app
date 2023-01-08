//
//  BannerAdView.swift
//  ChemQuiz2-alpha2
//
//  Created by Ryo Hanma on 2021/10/04.
//

import SwiftUI
import GoogleMobileAds
 
struct BannerAdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-8626899555940937/5659801112"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }
 
    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
}
