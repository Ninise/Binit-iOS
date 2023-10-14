//
//  DragDropGameView.swift
//  Binit
//
//  Created by Nikita on 11.10.2023.
//

import SwiftUI

struct DragDropGameView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showRulesScreen: Bool = true
    @State private var starsCount: Int = 0

    @GestureState var locationState = CGPoint(x: 100, y: 100)
    @State var location = CGPoint(x: 100, y: 100)
    
    
    let backButtonIcon = "ic_back_circle_arrow"
    let boyImage = "ic_game_boy"
    let organicBinImage = "ic_game_organic_bin_def"
    let recycleBinImage = "ic_game_recycle_bin_def"
    let garbageBinImage = "ic_game_garbage_bin_def"
    let backImage = "ic_game_drag_drop_back"
    let startIcon = "ic_start"

    let gameIcon = "ic_game_banana"
    
    let binWidth = 80.0
    let binHeight = 120.0
    
    let elementSize = 50.0
    
    var body: some View {
        ZStack () {
         
//            if showRulesScreen {
//                RulesView
//            } else {
//                
//            }
//            
          
            Image(backImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: [.vertical])
            
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(backButtonIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    })
                    
                    Spacer()
                    
                    Image(startIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Text("\(starsCount)")
                        .font(.custom(FontUtils.FONT_BOLD, size: 24))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.horizontal, 200)
                
                Spacer()
                
                HStack (spacing: 50) {
                    Image(organicBinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: binWidth, height: binHeight)
                        .onAppear {
                            checkOverlap()
                        }
                    
                    Image(recycleBinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: binWidth, height: binHeight)
                        .gesture(
                            DragGesture().onChanged({ drag in
                                Utils.log("drag on recycle")
                            })
                        )
                    
                    Image(garbageBinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: binWidth, height: binHeight)
                }
            }
            
            
            Image(gameIcon)
                .resizable()
                .scaledToFit()
//                .position(locationState)
                .position(location)
                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            self.location = value.location
                                        }
                                        .updating(
                                            self.$locationState
                                        ) { currentState, pastLocation, transaction  in
                                            pastLocation = currentState.location
                                            transaction.animation = .easeInOut
                                        }

                                )
                .frame(width: elementSize, height: elementSize)
                
        }
        .navigationBarBackButtonHidden()
    }
    
    func checkOverlap() {
          let draggableFrame = CGRect(origin: location, size: CGSize(width: elementSize, height: elementSize))
          let targetFrame = CGRect(x: 0, y: 0, width: 200, height: 200)

          if draggableFrame.intersects(targetFrame) {
              print("Overlap detected!")
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
