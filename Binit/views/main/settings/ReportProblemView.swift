//
//  ReportProblemView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI

// todo add firebase image upload

struct ReportProblemView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    @State private var description: String = ""
    
    let addImageIcon = "ic_add_image"
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(LocalizedStringKey("Report_problem_content"))
                .multilineTextAlignment(.leading)
                .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                .foregroundColor(.mainColor)
                .padding(.horizontal, 5)
            
            AppDefaultTextFieldView(
                text: $description,
                hint: LocalizedStringKey("Description").stringValue(),
                lineLimit: 5
            )
            
            Button(action: {
                
            }, label: {
                HStack {
                    Image(addImageIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                    
                    Text(LocalizedStringKey("Add_screenshot"))
                        .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                        .foregroundColor(.orangeColor)
                }
            })
            .padding(.horizontal, 5)
            .padding(.top, 10)
            
            
            AppDefaultButton(
                title: LocalizedStringKey("Send"),
                color: .orangeColor,
                callback: {
                    if (!description.isEmpty) {
                        
                        viewModel.makeSuggestion(
                            name: SuggestionConsts.S_PROBLEM_NAME,
                            type: SuggestionConsts.S_PROBLEM,
                            desc: description,
                            location: SuggestionConsts.S_IOS
                        )
                        
                        description = ""
                    }
                })
            .padding(.horizontal, 5)
            .padding(.top, 10)
            
            Spacer()
        }
        .padding(.top, 10)
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(LocalizedStringKey("Report_a_problem"))
    }
}

struct ReportProblemView_Previews: PreviewProvider {
    static var previews: some View {
        ReportProblemView()
    }
}
