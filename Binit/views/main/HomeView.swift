//
//  HomeView.swift
//  Binit
//
//  Created by Nikita on 26.09.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import ShimmeringView

struct HomeView: View {
    
    enum HomeEvents {
        case search
    }
    
    @StateObject var viewModel = MainViewModel()
    
    let gameImage = "ic_main_game"
    let searchIcon = "ic_search"
    
    let onEvent: (HomeEvents, Any) -> Void
    
    var body: some View {
        ZStack {
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading) {
                    
                    Text(LocalizedStringKey("Home_title"))
                        .padding(.leading, PaddingConsts.pDefaultPadding20)
                        .padding(.top, PaddingConsts.pDefaultPadding20)
                        .font(.custom(FontUtils.FONT_SEMIBOLD, size: 20))
                        .foregroundColor(.mainColor)
                    
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
                    .padding(.all, 12)
                    .background(Color.mainGarbageTypeBackColor)
                    .cornerRadius(8)
                    .frame(width: .infinity)
                    .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                    .padding(.top, PaddingConsts.pDefaultPadding5)
                    .onTapGesture {
                        onEvent(.search, "")
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Spacer(minLength: PaddingConsts.pDefaultPadding20)
                            ForEach(viewModel.quickSearches, id: \.id) { text in
                                QuickSearchBubbleView(title: text.name)
                                    .onTapGesture {
                                        NotificationCenter.default.post(name: .quickSearch, object: text.name)
                                        onEvent(.search, "")
                                    }
                            }
                        }
                    }
                    .padding(.top, 5)
                    
                    MainTextTitleView(title: LocalizedStringKey("How_to_sort"))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Spacer(minLength: PaddingConsts.pDefaultPadding20)
                            
                            if viewModel.isLoading {
                                ForEach(0..<4) { value in
                                    MainGarbageCardView(type: nil, isLoading: true)
                                        .padding(.trailing, 8)
                                }
                            } else {
                                ForEach(viewModel.categories, id: \.id) { type in
                                    NavigationLink(destination: GarbageDetailsView(item: type), label: {
                                        MainGarbageCardView(type: type, isLoading: false)
                                            .padding(.trailing, 8)
                                    })
                                }
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
                  
                    
                    if viewModel.isLoading {
                        ForEach(0..<4) { value in
                            MainArticleItemView(article: nil, isLoading: true)
                            
                            Divider()
                                .background(Color.mainColor.opacity(0.1))
                                .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                                .padding(.vertical, 5)
                        }
                    } else {
                        ForEach(viewModel.articles) { article in
                            NavigationLink(destination: ArticleDetailsView(item: article), label: {
                                MainArticleItemView(article: article, isLoading: false)
                            })
                            
                            Divider()
                                .background(Color.mainColor.opacity(0.1))
                                .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                                .padding(.vertical, 5)
                          
                        }
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
        HomeView( onEvent: {_, _ in})
    }
}

struct MainTextTitleView: View {
    
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .font(.custom(FontUtils.FONT_SEMIBOLD, size: 18))
            .foregroundColor(.mainColor)
            .padding(.top, PaddingConsts.pDefaultPadding20)
            .padding(.leading, PaddingConsts.pDefaultPadding20)
    }
}

struct QuickSearchBubbleView: View {
    
    let title: String
    
    let arrowIcon = "ic_main_bubble_arrow"
    
    var body: some View {
        HStack (alignment: .center) {
            
            Image(arrowIcon)
                .foregroundColor(.additionalTextColor)
            
            Text(title)
                .fixedSize(horizontal: true, vertical: false)
                .font(.custom(FontUtils.FONT_REGULAR, size: 15))
                .foregroundColor(.additionalTextColor)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color.mainGarbageTypeBackColor)
        .cornerRadius(6)
    }
}

struct MainGarbageCardView: View {
    
    let type: GarbageCategory?
    let isLoading: Bool
    
    var body: some View {
        VStack {
            ZStack {
                if let image = type?.type {
                    Image(GarbageUtils.getBinByType(type: image))
                } else {
                    // we use an image here to pre-set the real size of the image to download
                    if isLoading {
                        Image(GarbageUtils.getBinByType(type: GarbageUtils.GARBAGE_TYPE))
                    }
                }
            }
            .padding(.vertical, PaddingConsts.pDefaultPadding20)
            .padding(.horizontal, 24)
            .background(Color.mainGarbageTypeBackColor)
            .cornerRadius(10)
            
            if let type = type?.display_type {
                Text(type)
                    .font(.custom(FontUtils.FONT_MEDIUM, size: 14))
                    .foregroundColor(.mainColor)
            } else {
                Text("Loading")
                    .font(.custom(FontUtils.FONT_MEDIUM, size: 14))
                    .foregroundColor(.mainColor)
            }
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .shimmering(
            active: isLoading,
            animation: .easeInOut(duration: 1).repeatForever(autoreverses: false).delay(0.5)
        )
    }
}


struct MainArticleItemView: View {
    
    let article: Article?
    let isLoading: Bool
    
    var body: some View {
        HStack (alignment: .top) {
            if let image = article?.image {
                WebImage(url: URL(string: image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
            } else {
                if isLoading {
                    Image(GarbageUtils.getBinByType(type: GarbageUtils.DEPOT_TYPE))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                }
            }
            
            
            VStack (alignment: .leading, spacing: 5) {
                if let title = article?.title, let description = article?.short_description {
                    Text(title)
                        .font(.custom(FontUtils.FONT_SEMIBOLD, size: 15))
                        .foregroundColor(.mainColor)
                    
                    Text(description)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 15))
                        .foregroundColor(.mainArticleSubTitleColor)
                } else {
                    Text("Loading")
                        .font(.custom(FontUtils.FONT_SEMIBOLD, size: 15))
                        .foregroundColor(.mainColor)
                    
                    Text("Loading Loading Loading")
                        .font(.custom(FontUtils.FONT_REGULAR, size: 15))
                        .foregroundColor(.mainArticleSubTitleColor)
                }
                
            }
            .padding(.leading, 5)
            
            Spacer()
        }
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
        .redacted(reason: isLoading ? .placeholder : [])
        .shimmering(
            active: isLoading,
            animation: .easeInOut(duration: 1).repeatForever(autoreverses: false).delay(0.5)
        )
    }
}
