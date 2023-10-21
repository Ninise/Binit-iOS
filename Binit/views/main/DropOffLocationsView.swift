//
//  DropOffLocationsView.swift
//  Binit
//
//  Created by Nikita on 29.09.2023.
//

import SwiftUI

struct DropOffLocationsView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    @State private var message: String = ""
    
    @State private var showDialog: Bool = false
    
    let image = "ic_drop_off_locations_image"
    
    var body: some View {
        ZStack {
            VStack (alignment: .center) {
                
                
                Text(LocalizedStringKey("Drop_off_locations"))
                    .font(.custom(FontUtils.FONT_BOLD, size: 18))
                    .foregroundColor(.mainColor)
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity, height: 160)
                    .padding(.top, 10)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                VStack (alignment: .leading) {
                    Text(LocalizedStringKey("Drop_off_locations_subtitle"))
                        .font(.custom(FontUtils.FONT_MEDIUM, size: 16))
                        .foregroundColor(.mainColor)
                        .padding(.top, PaddingConsts.pDefaultPadding20)
                        .onTapGesture {
                            hideKeyboard()
                        }
                        
                    Text(LocalizedStringKey("Drop_off_locations_content"))
                        .multilineTextAlignment(.leading)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                        .foregroundColor(.mainColor)
                        .padding(.top, -6)
                        .onTapGesture {
                            hideKeyboard()
                        }
                        
                }
                
                AppDefaultTextFieldView(
                    text: $message,
                    hint: LocalizedStringKey("Message").stringValue(),
                    lineLimit: 5
                )
                
                
                AppDefaultButton(
                    title: LocalizedStringKey("Send"),
                    color: .orangeColor,
                    callback: {
                        if (!message.isEmpty) {
                            viewModel.makeSuggestion(
                                name: SuggestionConsts.S_LOCATION_NAME,
                                type: SuggestionConsts.S_SUGGESTION,
                                desc: message,
                                location: SuggestionConsts.S_IOS
                            )
                            
                            message = ""
                            
                            hideKeyboard()
                            
                            withAnimation(.easeIn(duration: 1)) {
                                showDialog = true
                            }                        }
                })
                .padding(.top, 5)
                .padding(.horizontal, 5)
                
                
                
                
                Spacer()
                
                
            }
            .frame(width: .infinity)
            .padding(.horizontal, PaddingConsts.pDefaultPadding20)
            .padding(.top, 10)

            if (showDialog) {
                ZStack {
                    
                    Color
                        .mainColor
                        .opacity(0.2)
                        .ignoresSafeArea()
                    
                    SharingSuccessDialogView()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                        withAnimation {
                            showDialog = false
                        }
                    })
                }
                .onTapGesture {
                    withAnimation {
                        showDialog = false
                    }
                }
            }
            
        }
    }
}

struct DropOffLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        DropOffLocationsView()
    }
}

