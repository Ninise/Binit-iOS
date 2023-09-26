//
//  SplashScreenView.swift
//  Binit
//
//  Created by Nikita on 25.09.2023.
//

import SwiftUI

struct SplashScreenView: View {
    
    let binitImage = "ic_landing_binit"
    let whalescaleImage = "ic_landing_whalescale"
    
    var body: some View {
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
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
