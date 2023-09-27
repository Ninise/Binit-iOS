//
//  HomeView.swift
//  Binit
//
//  Created by Nikita on 26.09.2023.
//

import SwiftUI

struct HomeView: View {
    
    let tempSearchBubbles = ["meat", "styroform", "cup", "papper", "plastic cup"]
    
    let searchIcon = "ic_search"
    
    var body: some View {
        ZStack {
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading) {
                    HStack {
                        Image(searchIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text(LocalizedStringKey("Search"))
                            .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                            .foregroundColor(.searchTextColor.opacity(0.5))
                        
                        Spacer()
                        
                    }
                    .padding()
                    .background(Color.searchBodyColor.opacity(0.1))
                    .cornerRadius(6)
                    .frame(width: .infinity)
                    .padding(.leading, PaddingConsts.pDefaultPadding20)
                    .padding(.trailing, 30)
                    .padding(.top, 15)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Spacer(minLength: PaddingConsts.pDefaultPadding20)
                            ForEach(tempSearchBubbles, id: \.self) { text in
                                QuickSearchBubbleView(title: text)
                            }
                        }
                    }
                    .padding(.top, 10)
                    
                    Text(LocalizedStringKey("How_to_sort"))
                        .font(.custom(FontUtils.FONT_BOLD, size: 18))
                        .foregroundColor(.mainColor)
                        .padding(.top, PaddingConsts.pDefaultPadding20)
                        .padding(.leading, PaddingConsts.pDefaultPadding20)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct QuickSearchBubbleView: View {
    
    let title: String
    
    var body: some View {
        ZStack {
            Text(title)
                .fixedSize(horizontal: true, vertical: false)
                .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                .foregroundColor(.searchBubbleTextColor)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.searchBodyColor.opacity(0.1))
        .cornerRadius(6)
    }
}
