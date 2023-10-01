//
//  AboutUsView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI

struct AboutUsView: View {
    
    let aboutUsImage = "ic_about_us_image"
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading) {
                
                AboutUsItemView(
                    title: LocalizedStringKey("Who_we_are"),
                    subtitle: LocalizedStringKey("Who_we_are_content")
                )
                
                Image(aboutUsImage)
                    .resizable()
                    .scaledToFill()
                
                AboutUsItemView(
                    title: LocalizedStringKey("Our_story"),
                    subtitle: LocalizedStringKey("Our_story_content")
                )
                .padding(.top, 10)
                
                AboutUsItemView(
                    title: LocalizedStringKey("Why_we_did_it"),
                    subtitle: LocalizedStringKey("Why_we_did_it_content")
                )
                .padding(.top, 10)
                
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(LocalizedStringKey("Feedback"))
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}

struct AboutUsItemView: View {
    
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.custom(FontUtils.FONT_MEDIUM, size: 16))
                .multilineTextAlignment(.leading)
                .foregroundColor(.orangeColor)
            
            Text(subtitle)
                .multilineTextAlignment(.leading)
                .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                .foregroundColor(.mainColor)
                .padding(.top, -5)
        }
    }
}
