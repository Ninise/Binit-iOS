//
//  SplashScreenView.swift
//  Binit
//
//  Created by Nikita on 25.09.2023.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var goToLanding: Bool = false
    @State private var goToMain: Bool = false
    
    let binitImage = "ic_landing_binit"
    let whalescaleImage = "ic_landing_whalescale"
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack {
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
            }
            .navigationDestination(isPresented: $goToLanding) {
                LandingView()
            }
            .navigationDestination(isPresented: $goToMain) {
                MainView()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    goToLanding = true
                    Utils.log("go to landing")
                })
            }
        }
       
        .accentColor(.orangeColor)
        .preferredColorScheme(.light)
    
    }
    
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
