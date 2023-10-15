//
//  DragDropGameView.swift
//  Binit
//
//  Created by Nikita on 11.10.2023.
//

import SwiftUI

struct DragDropGameView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let gameSet: [GameObject]
    
    @State var organicDADVM = DragAndDropViewModel()
    @State var recycleDADVM = DragAndDropViewModel()
    @State var garbageDADVM = DragAndDropViewModel()
    
    @State private var showRulesScreen: Bool = true
    @State private var starsCount: Int = 0
    
    @State private var currentItem: GameObject? = nil
    @State private var workGameSet: [GameObject] = []
    
    @State private var organicBinStatus: Int = 0
    @State private var recycleBinStatus: Int = 0
    @State private var garbageBinStatus: Int = 0
    
    let backButtonIcon = "ic_back_circle_arrow"
    let boyImage = "ic_game_boy"

    let organicBinImage = "ic_game_organic_bin_def"
    let organicBinImageHover = "ic_game_organic_bin_hover"
    let organicBinImageMistake = "ic_game_organic_bin_mistake"
    let organicBinImageCorrect = "ic_game_organic_bin_correct"

    let recycleBinImage = "ic_game_recycle_bin_def"
    let recycleBinImageHover = "ic_game_recycle_bin_hover"
    let recycleBinImageMistake = "ic_game_recycle_bin_mistake"
    let recycleBinImageCorrect = "ic_game_recycle_bin_correct"
    
    let garbageBinImage = "ic_game_garbage_bin_def"
    let garbageBinImageHover = "ic_game_garbage_bin_hover"
    let garbageBinImageMistake = "ic_game_garbage_bin_mistake"
    let garbageBinImageCorrect = "ic_game_garbage_bin_correct"
    
    let backImage = "ic_game_drag_drop_back"
    let startIcon = "ic_start"

    let gameIcon = "ic_game_banana"
    
    let binWidth = 85.0
    let binHeight = 125.0
    
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
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        dismiss()
//                    }, label: {
//                        Image(backButtonIcon)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 40, height: 40)
//                    })
//                    
//                    Spacer()
//                    
//                   
//                    
//                    Spacer()
//                }
//                .padding(.horizontal, 200)
                
                Spacer()
                
                HStack (spacing: 50) {
                    Image(getOrganicStatusIcon())
                        .resizable()
                        .scaledToFit()
                        .frame(width: binWidth, height: binHeight)
                        .dropReceiver(for: organicDADVM.dropReceiver, model: organicDADVM)

                    
                    Image(getRecycleStatusIcon())
                        .resizable()
                        .scaledToFit()
                        .frame(width: binWidth, height: binHeight)
                        .dropReceiver(for: recycleDADVM.dropReceiver, model: recycleDADVM)

                    
                    Image(getGarbageStatusIcon())
                        .resizable()
                        .scaledToFit()
                        .frame(width: binWidth, height: binHeight)
                        .dropReceiver(for: garbageDADVM.dropReceiver, model: garbageDADVM)
                        

                }
            }
            
            
            if let item = currentItem {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: elementSize, height: elementSize)
                    .dragable(onDragged: onDragged(position:), onDropped: onDropped(position:))
            }
                
        }
        .toolbarRole(.editor)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Image(startIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                Text("\(starsCount)")
                    .font(.custom(FontUtils.FONT_BOLD, size: 24))
                    .foregroundColor(.white)
            })
        }
        .onAppear {
            workGameSet = gameSet
            randomElement()
        }
    }
    
    func onDragged(position: CGPoint) -> DragState {
        
        if organicDADVM.dropReceiver.getDropArea()!.contains(position) {
            organicBinStatus = 1
            return .unknown
        }
        
        if garbageDADVM.dropReceiver.getDropArea()!.contains(position) {
            garbageBinStatus = 1
            return .unknown
        }
        
        if recycleDADVM.dropReceiver.getDropArea()!.contains(position) {
            recycleBinStatus = 1
            return .unknown
        }
        
        organicBinStatus = 0
        garbageBinStatus = 0
        recycleBinStatus = 0
        
        return .unknown

     }
     
     func onDropped(position: CGPoint) -> Bool {
         
         if let item = currentItem {

             resetIconsState()
             
             if organicDADVM.dropReceiver.getDropArea()!.contains(position) {
                 
                 if (item.type == GarbageUtils.ORGANIC_TYPE) {
                     organicBinStatus = 3
                     starsCount += 1
                     return true
                 } else {
                     organicBinStatus = 2
                     return false
                 }
                 
             }
             
             if garbageDADVM.dropReceiver.getDropArea()!.contains(position) {
                 
                 if (item.type == GarbageUtils.GARBAGE_TYPE) {
                     garbageBinStatus = 3
                     starsCount += 1
                     return true
                 } else {
                     garbageBinStatus = 2
                     return false
                 }
                 
             }
             
             if recycleDADVM.dropReceiver.getDropArea()!.contains(position) {
                 
                 if (item.type == GarbageUtils.RECYCLE_TYPE) {
                     recycleBinStatus = 3
                     starsCount += 1
                     return true
                 } else {
                     recycleBinStatus = 2
                     return false
                 }
                 
             }
             
         }
         
         return false
         
     }
    
    private func resetIconsState() {
        Utils.log("RESET ICON STATE")
        if let item = currentItem {
            Utils.log("WORK GAME SET BEFORE \(item.image); \(workGameSet.count)")
            workGameSet = workGameSet.filter { $0.image != item.image }
            Utils.log("WORK GAME SET AFTER \(item.image); \(workGameSet.count)")
            currentItem = nil
            
            Utils.log("WORK GAME SET MADE NIL")
            
            randomElement()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            organicBinStatus = 0
            recycleBinStatus = 0
            garbageBinStatus = 0
        })
        
    }
    
    private func getOrganicStatusIcon() -> String {
        switch organicBinStatus {
        case 0: return organicBinImage
        case 1: return organicBinImageHover
        case 2: return organicBinImageMistake
        case 3: return organicBinImageCorrect
        default:
            return organicBinImage
            
        }
    }
    
    private func getRecycleStatusIcon() -> String {
        switch recycleBinStatus {
        case 0: return recycleBinImage
        case 1: return recycleBinImageHover
        case 2: return recycleBinImageMistake
        case 3: return recycleBinImageCorrect
        default:
            return recycleBinImage
            
        }
    } 
    
    private func getGarbageStatusIcon() -> String {
        switch garbageBinStatus {
        case 0: return garbageBinImage
        case 1: return garbageBinImageHover
        case 2: return garbageBinImageMistake
        case 3: return garbageBinImageCorrect
        default:
            return garbageBinImage
            
        }
    }
    
    private func randomElement() {
        
        if let elem = workGameSet.randomElement() {
            Utils.log(elem.image)
            currentItem = elem
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
    
}

#Preview {
    DragDropGameView(gameSet: [])
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

struct MyDropReceiver: DropReceiver {
    var dropArea: CGRect? = nil
}

class DragAndDropViewModel: DropReceivableObservableObject {
    typealias DropReceivable = MyDropReceiver
    
    var dropReceiver = MyDropReceiver()
        
    func setDropArea(_ dropArea: CGRect, on dropReceiver: DropReceivable) {
        self.dropReceiver.updateDropArea(with: dropArea)
    }
}
