//
//  SplashScreenView.swift
//  Binit
//
//  Created by Nikita on 25.09.2023.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var goToLanding: Bool = false
    
    let binitImage = "ic_landing_binit"
    let whalescaleImage = "ic_landing_whalescale"
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationViews
                Spacer()
                Image(binitImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140)
                Spacer()
                Image(whalescaleImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    goToLanding = true
                })
        }
        }
    }
    
    private var NavigationViews: some View {
        ZStack {
            NavigationLink(destination: LandingView(), isActive: $goToLanding, label: {})
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
