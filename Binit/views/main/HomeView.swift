//
//  HomeView.swift
//  Binit
//
//  Created by Nikita on 26.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    let tempTypes = [GarbageUtils.GARBAGE_TYPE, GarbageUtils.ORGANIC_TYPE, GarbageUtils.RECYCLE_TYPE, GarbageUtils.ELECTRONIC_WASTE_TYPE, GarbageUtils.HHW_TYPE, GarbageUtils.YARD_WASTE_TYPE]
    
    
    let gameImage = "ic_main_game"
    let searchIcon = "ic_search"
    
    var body: some View {
        ZStack {
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading) {
                    NavigationLink(destination: SearchListView(searchWord: ""), label: {
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
                    })
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Spacer(minLength: PaddingConsts.pDefaultPadding20)
                            ForEach(viewModel.quickSearches, id: \.id) { text in
                                NavigationLink(destination: SearchListView(searchWord: text.name), label: {
                                    QuickSearchBubbleView(title: text.name)
                                })
                            }
                        }
                    }
                    .padding(.top, 10)
                    
                    MainTextTitleView(title: LocalizedStringKey("How_to_sort"))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Spacer(minLength: PaddingConsts.pDefaultPadding20)
                            ForEach(viewModel.categories, id: \.self) { type in
                                MainGarbageCardView(type: type)
                                    .padding(.trailing, 8)
                                
                            }
                        }
                    }
                    .padding(.top, 1)
                    
                    MainTextTitleView(title: LocalizedStringKey("Games"))
                    
                    NavigationLink(destination: GamesListView(), label: {
                        Image(gameImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: .infinity)
                            .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                    })
                    
                    MainTextTitleView(title: LocalizedStringKey("Good_to_know"))
                    
                    HStack (alignment: .top) {
                        WebImage(url: URL(string: "https://www.colorado.edu/ecenter/sites/default/files/styles/large/public/callout/landfill_fire.png?itok=mJf5MN_C"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                        
                        
                        VStack (alignment: .leading, spacing: 5) {
                            Text("Reuse.Reduce.Recycle")
                                .font(.custom(FontUtils.FONT_SEMIBOLD, size: 14))
                                .foregroundColor(.mainColor)
                            
                            Text("How to make lifestyle eco-friendly?")
                                .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                                .foregroundColor(.mainArticleSubTitleColor)
                        }
                        .padding(.leading, 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                    
                    Divider()
                        .background(Color.mainColor.opacity(0.1))
                        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                        .padding(.vertical, 5)
                    
                    HStack (alignment: .top) {
                        WebImage(url: URL(string: "https://www.colorado.edu/ecenter/sites/default/files/styles/large/public/callout/landfill_fire.png?itok=mJf5MN_C"))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                        
                        
                        VStack (alignment: .leading, spacing: 5) {
                            Text("Reuse.Reduce.Recycle")
                                .font(.custom(FontUtils.FONT_SEMIBOLD, size: 14))
                                .foregroundColor(.mainColor)
                            
                            Text("How to make lifestyle eco-friendly?")
                                .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                                .foregroundColor(.mainArticleSubTitleColor)
                        }
                        .padding(.leading, 5)
                        
                        Spacer()
                    }
                    .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                    
                    

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

struct MainTextTitleView: View {
    
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .font(.custom(FontUtils.FONT_BOLD, size: 18))
            .foregroundColor(.mainColor)
            .padding(.top, PaddingConsts.pDefaultPadding20)
            .padding(.leading, PaddingConsts.pDefaultPadding20)
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

struct MainGarbageCardView: View {
    
    let type: String
    
    var body: some View {
        VStack {
            ZStack {
                Image(GarbageUtils.getBinByType(type: type))
            }
            .padding(.vertical, PaddingConsts.pDefaultPadding20)
            .padding(.horizontal, 24)
            .background(Color.mainGarbageTypeBackColor)
            .cornerRadius(10)
            
            Text(type)
                .font(.custom(FontUtils.FONT_SEMIBOLD, size: 12))
                .foregroundColor(.mainColor)
        }
    }
}
