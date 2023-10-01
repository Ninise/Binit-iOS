//
//  FeedbackView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI

struct FeedbackView: View {
    
    @State private var email: String = ""
    
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(LocalizedStringKey("Feedback_subtitle"))
                .font(.custom(FontUtils.FONT_MEDIUM, size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(.mainColor)
            
            Text(LocalizedStringKey("Feedback_subtitle_content"))
                .multilineTextAlignment(.leading)
                .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(.mainColor)
                .padding(.top, -5)
            
            HStack {
                Text(LocalizedStringKey("Email"))
                    .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                    .foregroundColor(.mainColor)
                
                Text("(\(LocalizedStringKey("Optional").stringValue()))")
                    .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                    .foregroundColor(.mainColor)
                    .padding(.leading, -4)
            }
            .padding(.top, 2)
            
            AppDefaultTextFieldView(
                text: $email,
                hint: LocalizedStringKey("Hint_email").stringValue(),
                lineLimit: 1
            )
            .padding(.horizontal, -4)
            
            Text(LocalizedStringKey("Feedback"))
                .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                .foregroundColor(.mainColor)
                .padding(.top, 2)
            
            AppDefaultTextFieldView(
                text: $email,
                hint: LocalizedStringKey("Message").stringValue(),
                lineLimit: 5
            )
            .padding(.horizontal, -4)
            
            
            AppDefaultButton(
                title: LocalizedStringKey("Send"),
                color: .orangeColor,
                callback: {
                
            }, iconRight: nil)
            .padding(.top, 10)
            

            Spacer()
            
        }
        .padding(.top, 10)
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(LocalizedStringKey("Feedback"))
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}

//
//"Email"
//"Optional"
