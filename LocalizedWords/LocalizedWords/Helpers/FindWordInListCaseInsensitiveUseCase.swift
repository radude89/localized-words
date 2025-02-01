//
//  FindWordInListCaseInsensitiveUseCase.swift
//  LocalizedWords
//
//  Created by Radu Dan on 01.02.2025.
//

import Foundation

enum FindWordInListCaseInsensitiveUseCase {
    static func invoke(
        input: String,
        wordsDictionary: [String: String]
    ) -> (localizedKey: String, word: String)? {
        if let (localizedKey, word) = wordsDictionary.first(where: { key, word in
            input.compare(
                word,
                options: [.caseInsensitive, .diacriticInsensitive, .widthInsensitive]
            ) == .orderedSame
        }) {
            return (localizedKey, word)
        }
        return nil
    }
}
