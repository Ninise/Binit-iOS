//
//  DragDropGameView.swift
//  Binit
//
//  Created by Nikita on 11.10.2023.
//

import SwiftUI

struct DragDropGameView: View {
    
    @State private var showRulesScreen: Bool = true
    
    let boyImage = "ic_game_boy"
    let organicBinImage = "ic_game_organic_bin_def"
    let recycleBinImage = "ic_game_recycle_bin_def"
    let garbageBinImage = "ic_game_garbage_bin_def"
    let backImage = "ic_game_drag_drop_back"

    
    var body: some View {
        ZStack {
            
            Image(backImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: [.horizontal])
            
            if showRulesScreen {
                RulesView
            } else {
                
            }
        }
        .onAppear {
            
            changeOrientation(isPortrait: false)
        }
        .onDisappear {
            changeOrientation(isPortrait: true)
        }
    }
    
    private var RulesView: some View {
        HStack (alignment: .bottom) {
            
            Spacer()
            
            Image(boyImage)
                .resizable()
                .scaledToFit()
                .frame(width: 280, height: 280)
            
            VStack {
        
                Spacer()
                
                RulesDialogView(doneCallback: {
                    showRulesScreen = false
                })
                .padding(.bottom, 40)
                .padding(.leading, -80)
                
                HStack (spacing: 80) {
                    Image(organicBinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 140)
                    
                    Image(recycleBinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 140)
                    
                    Image(garbageBinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 140)
                }
                .padding(.leading, -110)
            }
            
            Spacer()
        }
        .padding(.bottom, 40)
    }
    
    private func changeOrientation(isPortrait: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: isPortrait ? .portrait : .landscape))
        }
    }
}

#Preview {
    DragDropGameView()
}

struct RulesDialogView: View {
    
    let doneCallback: () -> Void
    
    @State private var questionIndex: Int = 1
    
    var body: some View {
        VStack {
            HStack (alignment: .center, spacing: 0) {
                Text("\(questionIndex)")
                    .font(.custom(FontUtils.FONT_REGULAR, size: 18))
                    .foregroundColor(.orangeColor)
                
                Text("/ 2")
                    .font(.custom(FontUtils.FONT_REGULAR, size: 18))
                    .foregroundColor(.mainColor)
            }
            
            Text(questionIndex == 1 ? LocalizedStringKey("Game_drag_drop_rules_1") : LocalizedStringKey("Game_drag_drop_rules_2"))
                .multilineTextAlignment(.center)
                .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                .foregroundColor(.mainColor)
                .padding(.vertical, 5)
            
            Button(action: {
                
                if (questionIndex == 2) {
                    doneCallback()
                    return
                }
                
                questionIndex += 1
            }, label: {
                Text(questionIndex == 1 ? LocalizedStringKey("Got_it") : LocalizedStringKey("Play"))
                    .font(.custom(FontUtils.FONT_SEMIBOLD, size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal, PaddingConsts.pDefaultPadding20)
                    .padding(.vertical, PaddingConsts.pDefaultPadding10)
            })
            .background(Color.orangeColor)
            .cornerRadius(6)
        }
        .padding()
        .background(.white)
        .cornerRadius(10)
    }
    
}
