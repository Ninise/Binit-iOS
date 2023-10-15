//
//  ContentView.swift
//  Binit
//
//  Created by Nikita on 25.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Color.white
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .ignoresSafeArea()

            SplashScreenView()
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
