//
//  InviteFriendView.swift
//  Binit
//
//  Created by Nikita on 30.09.2023.
//

import SwiftUI

struct InviteFriendView: View {
    
    let image = "ic_invite_friend_image"
    let shareIcon = "ic_invite_share"
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 130)
                .padding(.top, 10)
            
            Text(LocalizedStringKey("Invite_friend_content"))
                .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.mainColor)
                .padding(.horizontal, 50)
                .padding(.top, 20)
            
            
            ShareLink(item: "https://binit.pro") {
                AppDefaultNotButton(
                    title: LocalizedStringKey("Share_with_friends"),
                    color: .orangeColor,
                    iconRight: shareIcon)
                .padding(.top, 10)
                .padding(.horizontal, 50)
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(LocalizedStringKey("Invite_friends"))
        
    }
}

struct InviteFriendView_Previews: PreviewProvider {
    static var previews: some View {
        InviteFriendView()
    }
}
