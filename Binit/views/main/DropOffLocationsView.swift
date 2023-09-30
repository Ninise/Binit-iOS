//
//  DropOffLocationsView.swift
//  Binit
//
//  Created by Nikita on 29.09.2023.
//

import SwiftUI

struct DropOffLocationsView: View {
    @State private var message: String = ""
    
    let image = "ic_drop_off_locations_image"
    
    var body: some View {
        ZStack {
            VStack (alignment: .center) {
                
                
                Text(LocalizedStringKey("Drop_off_locations"))
                    .font(.custom(FontUtils.FONT_BOLD, size: 18))
                    .foregroundColor(.mainColor)
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity, height: 160)
                    .padding(.top, 10)
                    .padding(.trailing, 20)
                
                VStack (alignment: .leading) {
                    Text(LocalizedStringKey("Drop_off_locations_subtitle"))
                        .font(.custom(FontUtils.FONT_MEDIUM, size: 16))
                        .foregroundColor(.mainColor)
                        .padding(.top, PaddingConsts.pDefaultPadding20)
                        
                    Text(LocalizedStringKey("Drop_off_locations_content"))
                        .multilineTextAlignment(.leading)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                        .foregroundColor(.mainColor)
                        .padding(.top, -6)
                        
                    
                }
                
            
                HStack {
                    TextField(LocalizedStringKey("Message"), text: $message, axis: .vertical)
                        .foregroundColor(.mainColor)
                        .tint(.orangeColor)
                        .lineLimit(5, reservesSpace: true)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                }
                .background(Color.searchBodyColor.opacity(0.1))
                .cornerRadius(6)
                .padding(.horizontal, 5)
                
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

struct DropOffLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        DropOffLocationsView()
    }
}

