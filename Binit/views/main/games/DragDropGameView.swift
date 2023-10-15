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
    
    @State private var showResultsDialog: Bool = false
    @State private var showRulesScreen: Bool = false
    @State private var starsCount: Int = 0
    
    @State private var isGameItemFalling: Bool = false
    @State private var currentItem: GameObject? = GameUtils.shared.getBatchOfItems()[0]
    @State private var workGameSet: [GameObject] = []
    @State private var itemLocationY: CGFloat = -200
    
    @State private var organicBinStatus: Int = 0
    @State private var recycleBinStatus: Int = 0
    @State private var garbageBinStatus: Int = 0
    
    @State private var isRulesItemFalling: Bool = false
    
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
    
    let rulesGameIcon = "ic_game_item_package_rec"
    
    let binWidth = 85.0
    let binHeight = 125.0
    
    let elementSize = 50.0
    
    var body: some View {
        ZStack {
         
            Image(backImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: [.vertical])
            
            if showResultsDialog {
                DragDropResultDialogView(
                    starsCount: starsCount,
                    onButtonClick: {
                        resetGame()
                    })
            } else if showRulesScreen {
                RulesView
            } else {
                GameLayView
                
                if let item = currentItem {
                    Image(item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: elementSize, height: elementSize)
                        .dragable(onDragged: onDragged(position:), onDropped: onDropped(position:))
                        .zIndex(1)
//                        .offset(y: isGameItemFalling ? 400 : itemLocationY)
                      
                        
                }
            }
                
        }
        .toolbarRole(.editor)
        .toolbar {
            if (!showRulesScreen) {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    HStack {
                        Image(startIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        Text("\(starsCount)")
                            .font(.custom(FontUtils.FONT_BOLD, size: 24))
                            .foregroundColor(.white)
                    }
                })
            }
        }
        .onAppear {
            workGameSet = gameSet
            randomElement()
        }
    }
    
    private var RulesView: some View {
        ZStack (alignment: .bottom) {
            
            Image(rulesGameIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.bottom, 170)
                .offset(y: isRulesItemFalling ? 100 : 0)
            
            Image(boyImage)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 300)
                .padding(.trailing, 200)
                .padding(.bottom, 20)
            
            
            VStack {
        
                Spacer()
                
                RulesDialogView(onClick: { index in
                    
                    if (index == 2) {
                        showRulesScreen = false
                    } else {
                        withAnimation(.easeIn(duration: 1)) {
                            isRulesItemFalling = true
                        }
                    }
                    
                    
                })
                
                Spacer()
                
                HStack (spacing: 50) {
                    Image(organicBinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: binWidth, height: binHeight)
                    
                    Image(recycleBinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: binWidth, height: binHeight)
                    
                    Image(garbageBinImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: binWidth, height: binHeight)
                }
            }
        }
    }
    
    private var GameLayView: some View {
        VStack {

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
    }
    
}

#Preview {
    DragDropGameView(gameSet: [])
}

struct RulesDialogView: View {
    
    let onClick: (Int) -> Void
    
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
                .frame(width: 300)
            
            
            Button(action: {
                
                onClick(questionIndex)
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

struct DragDropResultDialogView: View {
    
    let starsCount: Int
    let onButtonClick: () -> Void
    
    let starIcon = "ic_start"
    
    var body: some View {
        VStack {
            
            Text("\(starsCount)/10")
                .font(.custom(FontUtils.FONT_BOLD, size: 20))
                .foregroundColor(.orangeColor)
            
            HStack (alignment: .center) {
                ForEach(0..<starsCount / 2) { _ in
                    Image(starIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
            }
            
            Text(GameUtils.shared.getCongratsTextBasedOnScore(score: starsCount))
                .multilineTextAlignment(.center)
                .font(.custom(FontUtils.FONT_SEMIBOLD, size: 16))
                .foregroundColor(.mainColor)
                .padding(.vertical, 5)
            
            Text(GameUtils.shared.getCongratsSubsTextBasedOnScore(score: starsCount))
                .multilineTextAlignment(.center)
                .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                .foregroundColor(.mainColor)
                .padding(.bottom, 5)
            
            
            Button(action: {
                
                onButtonClick()
                
            }, label: {
                Text(LocalizedStringKey("Play_again"))
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

extension DragDropGameView {
    
    private func resetGame() {
        workGameSet = GameUtils.shared.getBatchOfItems()
        resetIconsState()
        showResultsDialog = false
        starsCount = 0
    }
    
    private func onDragged(position: CGPoint) -> DragState {
        
//        itemLocationY = position.y
//        isGameItemFalling = false
        
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
     
    private func onDropped(position: CGPoint) -> Bool {
        
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
        if let item = currentItem {
            workGameSet = workGameSet.filter { $0.image != item.image }
            currentItem = nil
            
            if (workGameSet.isEmpty) {
                showResultsDialog = true
                return
            }
                        
            randomElement()
        } else {
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
//            withAnimation(.easeIn(duration: 5)) {
//                isGameItemFalling = true
//                itemLocationY = -200
//            }
        }
    }
    
}
