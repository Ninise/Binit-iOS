//
//  GarbageDetailsView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct GarbageDetailsView: View {
    
    let item: GarbageCategory
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading) {
                Text(item.title)
                    .multilineTextAlignment(.leading)
                    .font(.custom(FontUtils.FONT_BOLD, size: 32))
                    .foregroundColor(.mainColor)
                
                WebImage(url: URL(string: item.image))
                    .resizable()
                    .scaledToFill()
                
                Text("@\(item.image_author)")
                    .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                    .foregroundColor(.mainColor)
                    .italic()
                    .onTapGesture {
                        viewModel.openUrl(urlStr: item.image_author_url)
                    }
                
                AttributedTextView(item.description)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10)
                
                Divider()
                    .background(Color.searchTextColor.opacity(0.1))
                
                ForEach(item.items) { sub in
                    DetailsSubviewItemView(sub: sub)
                }
                
//                Text(item.)
//                    .font(.custom(FontUtils.FONT_REGULAR, size: 16))
//                    .multilineTextAlignment(.leading)
//                    .foregroundColor(.mainColor)
//                    .padding(.top, 10)
                
            }
        }
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
        .toolbarRole(.editor)
        .accentColor(.orangeColor)
    }
}

struct GarbageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GarbageDetailsView(item: GarbageCategory(id: 1, title: "", image: "", type: "", image_author: "", image_author_url: "", display_type: "", description: "", items: []))
    }
}

struct DetailsSubviewItemView: View {
    
    let sub: SubCategoryItem
    
    @State private var open: Bool = false
    
    let arrowDownIcon = "ic_arrow_down"
    let arrowUpIcon = "ic_arrow_up"
    
    
    var body: some View {
        VStack {
           
            Button(action: {
                withAnimation {
                    open.toggle()
                }
            }, label: {
                HStack  {
                    Text(sub.title)
                        .font(.custom(FontUtils.FONT_MEDIUM, size: 17))
                        .foregroundColor(.orangeColor)
                    
                    Spacer()
                    
                    Image(open ? arrowDownIcon : arrowUpIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                }
                .padding(.vertical)
            })
            
            if (open) {
                ForEach(sub.data, id: \.self) { text in
                    HStack (alignment: .top) {
                        Text("• ")
                            .font(.custom(FontUtils.FONT_REGULAR, size: 17))
                            .foregroundColor(.mainColor)
                        
                        AttributedTextView(text)
                            .multilineTextAlignment(.leading)
                            
                        
                        Spacer()
                    }
                    .padding(.top, 1)
                    
                }
                
            }
            
            Divider()
                .background(Color.searchTextColor.opacity(0.1))
        }
    }
}
