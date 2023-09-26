//
//  LandingView.swift
//  Binit
//
//  Created by Nikita on 25.09.2023.
//

import SwiftUI

struct LandingView: View {
    
    let backImage = "ic_landing_dialog_back"
    
    var body: some View {
        ZStack (alignment: .center) {
            Image(backImage)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
