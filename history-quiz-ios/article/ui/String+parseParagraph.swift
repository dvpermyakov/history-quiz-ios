//
// Created by Dmitrii Permiakov on 12/1/20.
// Copyright (c) 2020 Dmitrii Permiakov. All rights reserved.
//

import Foundation

extension String {
    func parse() -> [ParagraphText] {
        var result = [ParagraphText]()
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: "<a href=\"app\\.opened:\\/\\/mark\\?id=(\\d*)&cat=(\\d)\">(.*?)<\\/a>")
        var lastIndex = 0
        regex.matches(in: self, range: range).forEach { match in
            result.append(
                    ParagraphText.Text(
                            value: self.substring(
                                    lastIndex,
                                    match.range(at: 0).lowerBound
                            )
                    )
            )
            result.append(
                    ParagraphText.Link(
                            value: self.substring(
                                    match.range(at: 3).lowerBound,
                                    match.range(at: 3).upperBound
                            ),
                            articleId: self.substring(
                                    match.range(at: 1).lowerBound,
                                    match.range(at: 1).upperBound
                            ),
                            articleCategory: self.substring(
                                    match.range(at: 2).lowerBound,
                                    match.range(at: 2).upperBound
                            )
                    )
            )
            lastIndex = match.range(at: 0).upperBound
        }
        result.append(
                ParagraphText.Text(
                        value: self.substring(lastIndex, self.count)
                )
        )
        return result
    }
}