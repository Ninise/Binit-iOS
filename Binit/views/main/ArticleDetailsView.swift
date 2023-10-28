//
//  ArticleDetailsView.swift
//  Binit
//
//  Created by Nikita on 08.10.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleDetailsView: View {
    
    let item: Article
    
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
                
                if let author = item.image_author {
                    Text("@\(author)")
                        .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                        .foregroundColor(.mainColor)
                        .underline()
                        .italic()
                        
                }
                    
                
                AttributedTextView(item.description)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10)
                
                Divider()
                    .background(Color.searchTextColor.opacity(0.1))
                
                ForEach(item.items) { sub in
                    DetailsSubviewItemView(sub: sub)
                }
                
                if let footer = item.footer {
                    Text(footer)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.mainColor)
                        .padding(.top, 10)
                }
                
            }
        }
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
        .toolbarRole(.editor)
        .accentColor(.orangeColor)
    }
}

struct ArticleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailsView(item: Article(id: 1, title: "", image: "", type: "", image_author: "", short_description: "", footer: "", description: "", items: []))
    }
}
