//
//  ContactUsView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI

struct ContactUsView: View {
    
    
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(LocalizedStringKey("Lets_connect"))
                .font(.custom(FontUtils.FONT_MEDIUM, size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(.mainColor)
            
            Text(LocalizedStringKey("Lets_connect_subtitle"))
                .multilineTextAlignment(.leading)
                .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                .foregroundColor(.mainColor)
                .padding(.top, -5)
            
            ContactUsItemView(
                title: LocalizedStringKey("Email").stringValue(),
                value: LocalizedStringKey("Binit_email").stringValue()
            )
            .padding(.top, 10)
            
            ContactUsItemView(
                title: LocalizedStringKey("Website").stringValue(),
                value: LocalizedStringKey("Binit_website").stringValue()
            )
            .padding(.top, 10)
            
            ContactUsItemView(
                title: LocalizedStringKey("Facebook").stringValue(),
                value: LocalizedStringKey("Binit_facebook").stringValue()
            )
            .padding(.top, 10)
            
            ContactUsItemView(
                title: LocalizedStringKey("LinkedIn").stringValue(),
                value: LocalizedStringKey("Binit_linkedin").stringValue()
            )
            .padding(.top, 10)
            
            ContactUsItemView(
                title: LocalizedStringKey("TikTok").stringValue(),
                value: LocalizedStringKey("Binit_tiktok").stringValue()
            )
            .padding(.top, 10)
            
            ContactUsItemView(
                title: LocalizedStringKey("Instagram").stringValue(),
                value: LocalizedStringKey("Binit_instagram").stringValue()
            )
            .padding(.top, 10)
            
            
            HStack {
                Spacer()
                Text("🇨🇦 Toronto, Canada")
                    .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                    .foregroundColor(.mainColor)
                    .padding(.top, PaddingConsts.pDefaultPadding20)
                Spacer()
            }
            
            

            Spacer()
            
        }
        .padding(.top, 10)
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(LocalizedStringKey("ContactUs"))
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}

struct ContactUsItemView: View {
    
    let title: String
    let value: String
    
    let copyIcon = "ic_copy"
    
    var body: some View {
        VStack (alignment: .center) {
            HStack (alignment: .center) {
                VStack (alignment: .leading) {
                    Text(title)
                        .font(.custom(FontUtils.FONT_MEDIUM, size: 15))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.mainColor)
                    
                    Text(value)
                        .multilineTextAlignment(.leading)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.orangeColor)
                        .padding(.top, -5)
                }
                
                Spacer()
                
                Image(copyIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            
            Divider()
                .background(Color.searchTextColor.opacity(0.1))
        }
    }
}
