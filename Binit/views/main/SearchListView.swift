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
    
    let searchIcon = "ic_search"
    
    var body: some View {
        VStack {
            
            HStack {
            
                HStack {
                    Image(searchIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    TextField("Search", text: $search)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                        .foregroundColor(.additionalTextColor)
                        .accentColor(.orangeColor)
                        .autocapitalization(.none)
                    
                    Spacer()
                    
                    if (!search.isEmpty) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.searchBubbleTextColor.opacity(0.4))
                            .onTapGesture {
                                search = ""
                            }
                    }
                }
                .padding(.all, 12)
                .background(Color.mainGarbageTypeBackColor)
                .cornerRadius(8)
                .frame(width: .infinity)
                .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                .padding(.top, PaddingConsts.pDefaultPadding20)
            }
            

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
                        hideKeyboard()
                    })
                    .padding(.top, 10)
                    
                    QuickSearchItem(type: GarbageUtils.RECYCLE_TYPE, title: LocalizedStringKey("Recycle").stringValue(), callback: { type in
                        search = GarbageUtils.RECYCLE_TYPE
                        hideKeyboard()
                    })
                    
                    QuickSearchItem(type: GarbageUtils.ORGANIC_TYPE, title: LocalizedStringKey("Organic").stringValue(), callback: { type in
                        search = GarbageUtils.ORGANIC_TYPE
                        hideKeyboard()
                    })
                    
                    QuickSearchItem(type: GarbageUtils.ELECTRONIC_WASTE_TYPE, title: LocalizedStringKey("E_waste").stringValue(), callback: { type in
                        search = GarbageUtils.ELECTRONIC_WASTE_TYPE
                        hideKeyboard()
                    })
                    
                    QuickSearchItem(type: GarbageUtils.HHW_TYPE, title: LocalizedStringKey("Household_hazardous").stringValue(), callback: { type in
                        search = GarbageUtils.HHW_TYPE
                        hideKeyboard()
                    })
                } else {
                    ForEach(viewModel.items) { item in
                        SearchItemView(item: item)
                            .padding(.top, 1)
                    }
                }
                
                if (!viewModel.items.isEmpty) {
                    Text(" ")
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
            .listStyle(.plain)
            

                    
        }
        .onNotification(.quickSearch, perform: { data in
            if data.object is String {
                search = data.object as! String
            }
        })
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
    
    let defIcon = "ic_def_search"
    
    var body: some View {
        VStack {
            HStack (alignment: .center) {
//                if item.image.isEmpty {
                    ZStack {
                        Image(defIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
//                            .cornerRadius(10)
                    }
                    .padding(.all, 27)
                    .background(Color.mainGarbageTypeBackColor)
                    .cornerRadius(10)
//                } else {
//                    WebImage(url: URL(string: item.image))
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 80, height: 80)
//                        .cornerRadius(10)
//                }
                
                VStack (alignment: .leading) {
                    
                    Text(item.name.capitalized)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                        .foregroundColor(.mainColor)
                    
                    Text(String(item.description.trimmingCharacters(in: .whitespaces)))
                        .lineLimit(expanded ? 20 : 2)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                        .foregroundColor(.mainArticleSubTitleColor)
                        .truncationMode(.tail)
                    
                    Spacer()
                }
                .padding(.top, PaddingConsts.pDefaultPadding10)
                .padding(.leading, PaddingConsts.pDefaultPadding5)
                .onTapGesture {
                    expanded.toggle()
                }
                
                Spacer()
                
                Image(GarbageUtils.getIconByTypee(type: item.type))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
            }
            .padding(.trailing, 10)
            .padding(.bottom, 2)
            
            Divider()
                .background(Color.searchBubbleTextColor.opacity(0.2))
                .opacity(0.7)
            
        }
        .listRowSeparator(.hidden)
    }
}

struct QuickSearchItem: View {
    
    let type: String
    let title: String
    let callback: (String) -> Void
    
    let quickIcon = "ic_search_quick"
    
    var body: some View {
        VStack {
            Button(action: {
                callback(type)
            }, label: {
                HStack (alignment: .center) {
                    Image(GarbageUtils.getIconByTypee(type: type))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text(title)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                        .foregroundColor(.searchBubbleTextColor.opacity(0.85))
                    
                    Spacer()
                    
                    Image(quickIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    
                }
            })
            .padding(.trailing, 10)
            .padding(.bottom, 10)
            
            Divider()
                .background(Color.searchBubbleTextColor.opacity(0.8))
        }
        .padding(.top, 1)
        .listRowSeparator(.hidden)

    }
    
}
