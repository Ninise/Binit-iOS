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
                            ForEach(viewModel.categories, id: \.id) { type in
                                NavigationLink(destination: GarbageDetailsView(item: type), label: {
                                    MainGarbageCardView(type: type)
                                        .padding(.trailing, 8)
                                })
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
                  
                    
                    ForEach(viewModel.articles) { article in
                        NavigationLink(destination: ArticleDetailsView(item: article), label: {
                            MainArticleItemView(article: article)
                        })
                        
                        Divider()
                            .background(Color.mainColor.opacity(0.1))
                            .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                            .padding(.vertical, 5)
                      
                    }
                    
                }
            }
        }
        .onAppear {
            viewModel.getQuizQuestions()
            viewModel.getAllArticles()
            viewModel.getGarbageCategories()
            viewModel.getQuickSearchSuggestions()
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
    
    let type: GarbageCategory
    
    var body: some View {
        VStack {
            ZStack {
                Image(GarbageUtils.getBinByType(type: type.type))
            }
            .padding(.vertical, PaddingConsts.pDefaultPadding20)
            .padding(.horizontal, 24)
            .background(Color.mainGarbageTypeBackColor)
            .cornerRadius(10)
            
            Text(type.display_type)
                .font(.custom(FontUtils.FONT_SEMIBOLD, size: 12))
                .foregroundColor(.mainColor)
        }
    }
}

struct MainArticleItemView: View {
    
    let article: Article
    
    var body: some View {
        HStack (alignment: .top) {
            WebImage(url: URL(string: article.image))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            
            VStack (alignment: .leading, spacing: 5) {
                Text(article.title)
                    .font(.custom(FontUtils.FONT_SEMIBOLD, size: 14))
                    .foregroundColor(.mainColor)
                
                Text(article.short_description)
                    .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                    .foregroundColor(.mainArticleSubTitleColor)
            }
            .padding(.leading, 5)
            
            Spacer()
        }
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
    }
}
