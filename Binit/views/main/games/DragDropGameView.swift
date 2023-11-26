//
//  DragDropGameView.swift
//  Binit
//
//  Created by Nikita on 11.10.2023.
//

import SwiftUI

// make objects animated or place them in different locations

struct DragDropGameView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let gameSet: [GameObject]
    
    // Bins viewModels
    @State var organicDADVM = DragAndDropViewModel()
    @State var recycleDADVM = DragAndDropViewModel()
    @State var garbageDADVM = DragAndDropViewModel()
    
    @State private var showResultsDialog: Bool = false
    @State private var showRulesScreen: Bool = false
    @State private var starsCount: Int = 0
    
    @State private var currentItem: GameObject? = GameUtils.shared.getBatchOfItems()[0]
    @State private var workGameSet: [GameObject] = []
    
    
    @State private var organicBinStatus: Int = 0
    @State private var recycleBinStatus: Int = 0
    @State private var garbageBinStatus: Int = 0
    
    @State private var isRulesItemFalling: Bool = false
    
    @State private var isGameItemChange: Bool = false
    
    @State private var isWrongOrganicState: Bool = false
    @State private var isWrongGarbageState: Bool = false
    @State private var isWrongRecycleState: Bool = false

    
    let STATE_GAME_ITEM_DEFAULT = 0
    let STATE_GAME_ITEM_HOVER = 1
    let STATE_GAME_ITEM_WRONG = 2
    let STATE_GAME_ITEM_CORRECT = 3
    
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
    
    let binWidth = 95.0
    let binHeight = 135.0
    
    let elementSize = 60.0
    
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
                        .scaleEffect(isGameItemChange ? 3 : 1)
                        .dragable(onDragged: onDragged(position:), onDropped: onDropped(position:))
                        .zIndex(1)
                        
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
            
            showRulesScreen = !AppSettings.shared.isUserSawDndRules()
            
            AppSettings.shared.setUserSawDndRules(flag: true)
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
                    .shake($isWrongOrganicState)
                    .dropReceiver(for: organicDADVM.dropReceiver, model: organicDADVM)

                
                Image(getRecycleStatusIcon())
                    .resizable()
                    .scaledToFit()
                    .frame(width: binWidth, height: binHeight)
                    .shake($isWrongRecycleState)
                    .dropReceiver(for: recycleDADVM.dropReceiver, model: recycleDADVM)
                
                Image(getGarbageStatusIcon())
                    .resizable()
                    .scaledToFit()
                    .frame(width: binWidth, height: binHeight)
                    .shake($isWrongGarbageState)
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
        
        if organicDADVM.dropReceiver.getDropArea()!.contains(position) {
            organicBinStatus = STATE_GAME_ITEM_HOVER
            
            return .unknown
        }
        
        if garbageDADVM.dropReceiver.getDropArea()!.contains(position) {
            garbageBinStatus = STATE_GAME_ITEM_HOVER
            return .unknown
        }
        
        if recycleDADVM.dropReceiver.getDropArea()!.contains(position) {
            recycleBinStatus = STATE_GAME_ITEM_HOVER
            return .unknown
        }
        
        organicBinStatus = STATE_GAME_ITEM_DEFAULT
        garbageBinStatus = STATE_GAME_ITEM_DEFAULT
        recycleBinStatus = STATE_GAME_ITEM_DEFAULT
        
        return .unknown

     }
     
    private func onDropped(position: CGPoint) -> Bool {
    
        if let item = currentItem {

            if organicDADVM.dropReceiver.getDropArea()!.contains(position) {

                resetIconsState()
                
                if (item.type == GarbageUtils.ORGANIC_TYPE) {
                    organicBinStatus = STATE_GAME_ITEM_CORRECT
                    starsCount += 1
                    return true
                } else {
                    organicBinStatus = STATE_GAME_ITEM_WRONG
                    isWrongOrganicState = true
                    return false
                }
                
            }
            
            if garbageDADVM.dropReceiver.getDropArea()!.contains(position) {
                
                resetIconsState()
                
                if (item.type == GarbageUtils.GARBAGE_TYPE) {
                    garbageBinStatus = STATE_GAME_ITEM_CORRECT
                    starsCount += 1
                    return true
                } else {
                    garbageBinStatus = STATE_GAME_ITEM_WRONG
                    isWrongGarbageState = true
                    return false
                }
                
            }
            
            if recycleDADVM.dropReceiver.getDropArea()!.contains(position) {
                
                resetIconsState()
                
                if (item.type == GarbageUtils.RECYCLE_TYPE) {
                    recycleBinStatus = STATE_GAME_ITEM_CORRECT
                    starsCount += 1
                    return true
                } else {
                    recycleBinStatus = STATE_GAME_ITEM_WRONG
                    isWrongRecycleState = true
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
            organicBinStatus = STATE_GAME_ITEM_DEFAULT
            recycleBinStatus = STATE_GAME_ITEM_DEFAULT
            garbageBinStatus = STATE_GAME_ITEM_DEFAULT
        })
        
    }
    
    private func getOrganicStatusIcon() -> String {
        switch organicBinStatus {
        case STATE_GAME_ITEM_DEFAULT: return organicBinImage
        case STATE_GAME_ITEM_HOVER: return organicBinImageHover
        case STATE_GAME_ITEM_WRONG: return organicBinImageMistake
        case STATE_GAME_ITEM_CORRECT: return organicBinImageCorrect
        default:
            return organicBinImage
            
        }
    }
    
    private func getRecycleStatusIcon() -> String {
        switch recycleBinStatus {
        case STATE_GAME_ITEM_DEFAULT: return recycleBinImage
        case STATE_GAME_ITEM_HOVER: return recycleBinImageHover
        case STATE_GAME_ITEM_WRONG: return recycleBinImageMistake
        case STATE_GAME_ITEM_CORRECT: return recycleBinImageCorrect
        default:
            return recycleBinImage
            
        }
    }
    
    private func getGarbageStatusIcon() -> String {
        switch garbageBinStatus {
        case STATE_GAME_ITEM_DEFAULT: return garbageBinImage
        case STATE_GAME_ITEM_HOVER: return garbageBinImageHover
        case STATE_GAME_ITEM_WRONG: return garbageBinImageMistake
        case STATE_GAME_ITEM_CORRECT: return garbageBinImageCorrect
        default:
            return garbageBinImage
            
        }
    }
    
    private func randomElement() {
        
        if let elem = workGameSet.randomElement() {
          
            Utils.log(elem.image)
            currentItem = elem
            
            withAnimation(.easeIn(duration: 1)) {
                isGameItemChange = true
                
                isWrongOrganicState = false
                isWrongRecycleState = false
                isWrongGarbageState = false
            }
            
            withAnimation(.easeOut(duration: 1)) {
                isGameItemChange = false
            }
        }
    }
    
}
