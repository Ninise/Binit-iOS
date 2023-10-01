//
//  GarbageDetailsView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI

struct GarbageDetailsView: View {
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading) {
                Text("Why recycle is important?")
                    .multilineTextAlignment(.leading)
                    .font(.custom(FontUtils.FONT_BOLD, size: 32))
                    .foregroundColor(.mainColor)
                
                Image("ic_about_us_image")
                    .resizable()
                    .scaledToFill()
                
                Text("@Photo Boards")
                    .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                    .foregroundColor(.mainColor)
                    .italic()
                
                Text("Content")
                    .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.mainColor)
                    .padding(.top, 10)
                
                Divider()
                    .background(Color.searchTextColor.opacity(0.1))
                
                DetailsSubviewItemView()
                
                Text("Sub Content")
                    .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.mainColor)
                    .padding(.top, 10)
                
            }
        }
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
        .toolbarRole(.editor)
    }
}

struct GarbageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GarbageDetailsView()
    }
}

struct DetailsSubviewItemView: View {
    
    @State private var open: Bool = false
    
    let arrowDownIcon = "ic_arrow_down"
    let arrowUpIcon = "ic_arrow_up"
    
    
    var body: some View {
        VStack {
           
            Button(action: {
                open.toggle()
            }, label: {
                HStack  {
                    Text("Title")
                        .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                        .foregroundColor(.orangeColor)
                    
                    Spacer()
                    
                    Image(open ? arrowDownIcon : arrowUpIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                }
                .padding(.vertical)
            })
            
            if (open) {
                Text("Text")
                    .multilineTextAlignment(.leading)
                    .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                    .foregroundColor(.mainColor)
            }
            
            Divider()
                .background(Color.searchTextColor.opacity(0.1))
        }
    }
}
