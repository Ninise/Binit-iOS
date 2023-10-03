//
//  SearchListView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchListView: View {
    
    let searchWord: String
    
    @State private var search: String = ""
    
    var body: some View {
        VStack {
            List {
                HStack (alignment: .center) {
                    WebImage(url: URL(string: "https://www.colorado.edu/ecenter/sites/default/files/styles/large/public/callout/landfill_fire.png?itok=mJf5MN_C"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                    
                    VStack (alignment: .leading) {
                        Text("Plastic bottle")
                            .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                            .foregroundColor(.mainColor)
                        
                        Text("Empty and rinse (if necessary and possible), than put it in recycle bin")
                            .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                            .foregroundColor(.mainArticleSubTitleColor)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Image(GarbageUtils.getIconByTypee(type: GarbageUtils.RECYCLE_TYPE))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        
                }
            }
            .listStyle(.plain)
        }
        .searchable(text: $search)
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView(searchWord: "")
    }
}
