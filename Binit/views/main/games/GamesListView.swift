//
//  GamesListView.swift
//  Binit
//
//  Created by Nikita on 01.10.2023.
//

import SwiftUI

struct GamesListView: View {
    
    let firstGameImage = "ic_first_game"
    let secondGameImage = "ic_second_game"
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(LocalizedStringKey("Sort_learn"))
                .font(.custom(FontUtils.FONT_BOLD, size: 18))
                .foregroundColor(.mainColor)
            
            Image(firstGameImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(6)
            
            Text(LocalizedStringKey("Waste_wise_quiz"))
                .font(.custom(FontUtils.FONT_BOLD, size: 18))
                .foregroundColor(.mainColor)
                .padding(.top, 10)
            
            NavigationLink(destination: QuizGameView(questions: GameUtils.shared.getBatchOfQuestions()), label: {
                Image(secondGameImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(6)
            })
            
            Spacer()
        }
        .padding(.horizontal, PaddingConsts.pDefaultPadding20)
        .padding(.top, 10)
    }
}

struct GamesListView_Previews: PreviewProvider {
    static var previews: some View {
        GamesListView()
    }
}
