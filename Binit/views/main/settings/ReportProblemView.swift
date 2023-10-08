//
//  ReportProblemView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI
import PhotosUI



struct ReportProblemView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    @State private var description: String = ""
    
    @State private var imageItem: PhotosPickerItem?
    @State private var imageImage: UIImage?
    
    let addImageIcon = "ic_add_image"
    let removeIcon = "ic_settings_remove"
    
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
            
            
            
            if let image = imageImage {
                ZStack (alignment: .topTrailing) {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                    
                    Image(removeIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(.all, 5)
                }
                .onTapGesture {
                    imageItem = nil
                    imageImage = nil
                }
                .padding(.leading, 5)
            } else {
                PhotosPicker(selection: $imageItem, matching: .images, label: {
                    HStack {
                        Image(addImageIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                        
                        Text(LocalizedStringKey("Add_screenshot"))
                            .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                            .foregroundColor(.orangeColor)
                    }
                    .padding(.horizontal, 5)
                    .padding(.top, 10)
                })
                
            }
            
            if (viewModel.isLoading) {
                HStack {
                    Spacer()
                    AppIndicatorView(color: .orangeColor, lineWidth: 2)
                        .frame(width: 50, height: 50)
                    Spacer()
                }
            } else {
                AppDefaultButton(
                    title: LocalizedStringKey("Send"),
                    color: .orangeColor,
                    callback: {
                        if (!description.isEmpty) {
                            
                            viewModel.makeSuggestion(
                                name: SuggestionConsts.S_PROBLEM_NAME,
                                type: SuggestionConsts.S_PROBLEM,
                                desc: description,
                                location: SuggestionConsts.S_IOS,
                                image: imageImage
                            )
                            
                            description = ""
                            imageItem = nil
                            imageImage = nil
                        }
                    })
                .padding(.horizontal, 5)
                .padding(.top, 10)
            }
            
           
            
            Spacer()
        }
        .onChange(of: imageItem) { _ in
            Task {
                if let data = try? await imageItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        imageImage = uiImage
                        return
                    }
                }
                
                print("Failed")
            }
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
