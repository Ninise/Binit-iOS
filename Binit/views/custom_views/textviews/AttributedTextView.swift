//
//  AttributedTextView.swift
//  Binit
//
//  Created by Nikita on 08.10.2023.
//

import SwiftUI

struct AttributedTextView: View {
    let input: String

    init(_ input: String) {
        self.input = input
    }

    var body: some View {
        parseString(input: input)
    }

    func parseString(input: String) -> Text {
        var parsedText = Text("")
        var startIndex = input.startIndex

        while startIndex < input.endIndex {
            if let nextRange = input[startIndex...].range(of: "\\\\(.*?)\\\\|\\*\\*(.*?)\\*\\*|=(.*?)=", options: .regularExpression) {
                let beforeMatchRange = startIndex..<nextRange.lowerBound
                parsedText = parsedText + Text(input[beforeMatchRange])

                let matchTextRange = nextRange
                let matchText = String(input[matchTextRange])

                let style: Text

                switch matchText.first {
                case "=":
                    style = Text(matchText.dropFirst().dropLast()).italic().bold()
                case "\\":
                    style = Text(matchText.dropFirst().dropLast()).italic()
                case "*":
                    style = Text(matchText.dropFirst(2).dropLast(2)).bold()
                default:
                    style = Text(matchText.dropFirst().dropLast()).italic().bold()
                }

                parsedText = parsedText + style
                startIndex = nextRange.upperBound
            } else {
                let remainingRange = startIndex..<input.endIndex
                parsedText = parsedText + Text(input[remainingRange]).font(.custom(FontUtils.FONT_REGULAR, size: 17))
                break
            }
        }

        return parsedText
    }
}
