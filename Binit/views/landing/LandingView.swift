//
//  LandingView.swift
//  Binit
//
//  Created by Nikita on 25.09.2023.
//

import SwiftUI

struct LandingView: View {
    
    let binitLogo = "ic_landing_binit"
    let backImage = "ic_landing_dialog_back"
    
    var body: some View {
        ZStack (alignment: .center) {
            Image(backImage)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(binitLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90)
                
                Text(LocalizedStringKey("Landing_dialog_title"))
                    .font(.custom(FontUtils.FONT_MEDIUM, size: 18))
                    .foregroundColor(.mainColor)
                    .multilineTextAlignment(.center)
                    
                Text(LocalizedStringKey("Landing_dialog_content"))
                    .font(.custom(FontUtils.FONT_REGULAR, size: 15))
                    .foregroundColor(.mainColor)
                    .multilineTextAlignment(.center)
                    .padding(.top, -3)
                    .padding(.horizontal, 20)
                
                NavigationLink(destination: MainView(), label: {
                    AppDefaultNotButton(
                        title: LocalizedStringKey("Landing_dialog_button"),
                        color: Color.orangeColor)
                    .padding(.top, 5)
                })
                
                    
            }
            .padding(.top, 20)
            .padding(.bottom, 25)
            .padding(.horizontal, 20)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .frame(width: .infinity)
            .padding(.horizontal, 35)
            
        }
        .navigationBarBackButtonHidden()
    }
    
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
