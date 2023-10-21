//
//  SettingsView.swift
//  Binit
//
//  Created by Nikita on 30.09.2023.
//

import SwiftUI

struct SettingsView: View {
    
    let logoImage = "ic_landing_binit"
    
    
    var body: some View {
        VStack (alignment: .center) {
            Image(logoImage)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 130)
                .padding(.top, 10)
            
            NavigationLink(destination: InviteFriendView(), label: {
                SettingsButtonItemView(title: LocalizedStringKey("Invite_friends"))
            })
            
            NavigationLink(destination: FeedbackView(), label: {
                SettingsButtonItemView(title: LocalizedStringKey("Feedback"))
            })
            
            NavigationLink(destination: ContactUsView(), label: {
                SettingsButtonItemView(title: LocalizedStringKey("Contact_us"))
            })
            
            NavigationLink(destination: AboutUsView(), label: {
                SettingsButtonItemView(title: LocalizedStringKey("About_us"))
            })
            
            Button(action: {
                AppStoreReviewUtils.requestReviewIfAppropriate()
            }, label: {
                SettingsButtonItemView(title: LocalizedStringKey("Rate_the_app"))
            })
            
            NavigationLink(destination: ReportProblemView(), label: {
                SettingsButtonItemView(title: LocalizedStringKey("Report_a_problem"))
            })
            
     
                
            
            Spacer()
        }
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct SettingsButtonItemView: View {
    
    let title: LocalizedStringKey
    
    let arrowIcon = "ic_arrow_right"
    
    var body: some View {
        VStack {
            HStack (alignment: .center) {
                Text(title)
                    .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                    .foregroundColor(.mainColor)
                
                Spacer()
                
                Image(arrowIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .padding(.vertical, 15)
            
            Divider()
                .background(Color.searchTextColor.opacity(0.1))
        }
    }
}
