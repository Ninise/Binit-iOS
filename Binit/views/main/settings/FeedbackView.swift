//
//  FeedbackView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI

struct FeedbackView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    @State private var email: String = ""
    @State private var message: String = ""
    
    @State private var showDialog: Bool = false
    
    var body: some View {
        ZStack {
            
            Color
                .white
                .ignoresSafeArea()
                .onTapGesture {
                    hideKeyboard()
                }
            
            VStack (alignment: .leading) {
                Text(LocalizedStringKey("Feedback_subtitle"))
                    .font(.custom(FontUtils.FONT_MEDIUM, size: 15))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.mainColor)
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                Text(LocalizedStringKey("Feedback_subtitle_content"))
                    .multilineTextAlignment(.leading)
                    .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.mainColor)
                    .padding(.top, -5)
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                HStack {
                    Text(LocalizedStringKey("Email"))
                        .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                        .foregroundColor(.mainColor)
                    
                    Text("(\(LocalizedStringKey("Optional").stringValue()))")
                        .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                        .foregroundColor(.mainColor)
                        .padding(.leading, -4)
                }
                .padding(.top, 2)
                .onTapGesture {
                    hideKeyboard()
                }
                
                AppDefaultTextFieldView(
                    text: $email,
                    hint: LocalizedStringKey("Hint_email").stringValue(),
                    lineLimit: 1
                )
                .padding(.horizontal, -4)
                
                Text(LocalizedStringKey("Feedback"))
                    .font(.custom(FontUtils.FONT_REGULAR, size: 16))
                    .foregroundColor(.mainColor)
                    .padding(.top, 2)
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                AppDefaultTextFieldView(
                    text: $message,
                    hint: LocalizedStringKey("Message").stringValue(),
                    lineLimit: 5
                )
                .padding(.horizontal, -4)
                
                
                AppDefaultButton(
                    title: LocalizedStringKey("Send"),
                    color: .orangeColor,
                    callback: {
                        if (!email.isEmpty && !message.isEmpty) {
                            viewModel.makeSuggestion(
                                name: SuggestionConsts.S_FEEDBACK_NAME,
                                type: SuggestionConsts.S_FEEDBACK,
                                desc: "EMAIL: \(email); MESSAGE: \(message);",
                                location: SuggestionConsts.S_IOS
                            )
                            
                            email = ""
                            message = ""
                            
                            hideKeyboard()
                            
                            withAnimation(.easeIn(duration: 1)) {
                                showDialog = true
                            }
                        }
                        
                        
                    }, iconRight: nil)
                .padding(.top, 10)
                
                
                Spacer()
                
            }
            .padding(.top, 10)
            .padding(.horizontal, PaddingConsts.pDefaultPadding20)
            
            
            
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(LocalizedStringKey("Feedback"))
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}

//
//"Email"
//"Optional"
