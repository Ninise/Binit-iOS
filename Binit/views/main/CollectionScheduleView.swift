//
//  CollectionScheduleView.swift
//  Binit
//
//  Created by Nikita on 29.09.2023.
//

import SwiftUI

struct CollectionScheduleView: View {
    
    @State private var message: String = ""
    
    let image = "ic_collection_schedule_image"
    
    var body: some View {
        ZStack {
            VStack (alignment: .center) {
                
                
                Text(LocalizedStringKey("Collection_schedule"))
                    .font(.custom(FontUtils.FONT_BOLD, size: 18))
                    .foregroundColor(.mainColor)
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity, height: 160)
                    .padding(.top, 10)
                    .padding(.trailing, 40)
                
                VStack (alignment: .leading) {
                    Text(LocalizedStringKey("Collection_schedule_subtitle"))
                        .font(.custom(FontUtils.FONT_MEDIUM, size: 16))
                        .foregroundColor(.mainColor)
                        .padding(.top, PaddingConsts.pDefaultPadding20)
                        
                    Text(LocalizedStringKey("Collection_schedule_content"))
                        .multilineTextAlignment(.leading)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                        .foregroundColor(.mainColor)
                        .padding(.top, -6)
                        
                    
                }
                
            
                AppDefaultTextFieldView(
                    text: $message,
                    hint: LocalizedStringKey("Message").stringValue(),
                    lineLimit: 4
                )
                
                AppDefaultButton(
                    title: LocalizedStringKey("Send"),
                    color: .orangeColor,
                    callback: {
                    
                })
                .padding(.top, 5)
                .padding(.horizontal, 5)
                
                
                
                Spacer()
                
                
            }
            .frame(width: .infinity)
            .padding(.horizontal, PaddingConsts.pDefaultPadding20)
            .padding(.top, 10)

        }
    }
}

struct CollectionScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionScheduleView()
    }
}

