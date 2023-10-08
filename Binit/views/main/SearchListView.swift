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
    
    @StateObject var viewModel = SearchViewModel()
    
    @State private var search: String = ""
    
    var body: some View {
        VStack {
            
            if (search.isEmpty) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Spacer(minLength: PaddingConsts.pDefaultPadding20)
                        ForEach(viewModel.quickSearches, id: \.id) { text in
                            QuickSearchBubbleView(title: text.name)
                                .onTapGesture {
                                    search = text.name
                                }
                        }
                    }
                }
            }
            
            List {
                
                if (!search.isEmpty && viewModel.items.isEmpty && !viewModel.isLoading) {
                    VStack (alignment: .center) {
                        HStack {
                            Spacer()
                            Image(GarbageUtils.getBinByType(type: GarbageUtils.ORGANIC_TYPE))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            Image(GarbageUtils.getBinByType(type: GarbageUtils.RECYCLE_TYPE))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            Image(GarbageUtils.getBinByType(type: GarbageUtils.GARBAGE_TYPE))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            
                            Spacer()
                        }
                        
                        Text(LocalizedStringKey("No_search_result"))
                            .multilineTextAlignment(.center)
                            .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                            .foregroundColor(.mainColor)
                        
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    .padding(.top, 100)
                }
                
                if (search.isEmpty) {
                    QuickSearchItem(type: GarbageUtils.GARBAGE_TYPE, title: LocalizedStringKey("Garbage").stringValue(), callback: { type in
                        search = GarbageUtils.GARBAGE_TYPE
                    })
                    
                    QuickSearchItem(type: GarbageUtils.RECYCLE_TYPE, title: LocalizedStringKey("Recycle").stringValue(), callback: { type in
                        search = GarbageUtils.RECYCLE_TYPE
                    })
                    
                    QuickSearchItem(type: GarbageUtils.ORGANIC_TYPE, title: LocalizedStringKey("Organic").stringValue(), callback: { type in
                        search = GarbageUtils.ORGANIC_TYPE
                    })
                    
                    QuickSearchItem(type: GarbageUtils.ELECTRONIC_WASTE_TYPE, title: LocalizedStringKey("E_waste").stringValue(), callback: { type in
                        search = GarbageUtils.ELECTRONIC_WASTE_TYPE
                    })
                    
                    QuickSearchItem(type: GarbageUtils.HHW_TYPE, title: LocalizedStringKey("Household_hazardous").stringValue(), callback: { type in
                        search = GarbageUtils.HHW_TYPE
                    })
                } else {
                    ForEach(viewModel.items) { item in
                        SearchItemView(item: item)
                            .padding(.vertical, 5)
                    }
                }
                
                if (!viewModel.items.isEmpty) {
                    Text("End of search...")
                        .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                        .foregroundColor(.mainColor)
                        .onAppear {
                            if !viewModel.isLoading {
                                viewModel.search(query: search)
                            }
                        }
                        .listRowSeparator(.hidden)
                }
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
           
            
        }
        .searchable(text: $search)
        .onChange(of: search, perform: { newValue in
            viewModel.search(query: newValue)
        })
        .onAppear {
            search = searchWord
            viewModel.getQuickSearchSuggestions()
        }
    }
   
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView(searchWord: "")
    }
}

struct SearchItemView: View {
    
    let item: Product
    
    @State private var expanded: Bool = false
    
    
    var body: some View {
        HStack (alignment: .center) {
            if item.image.isEmpty {
                ZStack {
                    Image(GarbageUtils.getBinByType(type: item.type))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                }
                .frame(width: 80, height: 80)
            } else {
                WebImage(url: URL(string: item.image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
            }
            
            VStack (alignment: .leading) {
                Text(item.name.capitalized)
                    .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                    .foregroundColor(.mainColor)
                
                Text(item.description)
                    .lineLimit(expanded ? 20 : 2)
                    .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                    .foregroundColor(.mainArticleSubTitleColor)
                    .truncationMode(.tail)
                
                Spacer()
            }
            .padding(.leading, 5)
            .onTapGesture {
                expanded.toggle()
            }
            
            Spacer()
            
            Image(GarbageUtils.getIconByTypee(type: item.type))
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
        }
    }
}

struct QuickSearchItem: View {
    
    let type: String
    let title: String
    let callback: (String) -> Void
    
    let quickIcon = "ic_search_quick"
    
    var body: some View {
        Button(action: {
            callback(type)
        }, label: {
            HStack (alignment: .center) {
                Image(GarbageUtils.getIconByTypee(type: type))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(title)
                    .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                    .foregroundColor(.mainColor)
                
                Spacer()
                
                Image(quickIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                
            }
        })
        .padding(.vertical, 10)
    }
    
}
