//
//  SharingSuccessDialogView.swift
//  Binit
//
//  Created by Nikita on 21.10.2023.
//

import SwiftUI

struct SharingSuccessDialogView: View {
    
    let checkmarkIcon = "ic_checkmark"
    
    var body: some View {
        VStack {
            Image(checkmarkIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 81, height: 81)
            
            Text(LocalizedStringKey("Thank_you_for_sharing"))
                .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                .foregroundColor(.mainColor)
            
            Text(LocalizedStringKey("We_got_your_message"))
                .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                .foregroundColor(.mainColor)
                .padding(.top, 1)
        }
        .padding(.all)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        
    }
}

#Preview {
    SharingSuccessDialogView()
}
