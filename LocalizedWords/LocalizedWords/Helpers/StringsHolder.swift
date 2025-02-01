//
//  StringsHolder.swift
//  LocalizedWords
//
//  Created by Radu Dan on 01.02.2025.
//

import SwiftUI

struct StringsHolder {
    private static let localizationValue = String.LocalizationValue("main.onboarding.title.label")
    private static let staticString: StaticString = "main.onboarding.title.label"

    static let localizedResourceWithStringLiteral = LocalizedStringResource(
        stringLiteral: "main.onboarding.title.label"
    )
    static let localizedResourceWithLocalizationValue = LocalizedStringResource(localizationValue)

    static let localizedResourceWithStaticString = LocalizedStringResource(
        staticString,
        defaultValue: localizationValue
    )

    static let localizedString = String(localized: localizationValue)

    static let localizedStringKey = LocalizedStringKey("main.onboarding.title.label")

    static let localizedStringOldWay = NSLocalizedString(
        "main.onboarding.title.label",
        comment: "Used to show the onboarding title."
    )
}

extension StringsHolder: CustomStringConvertible {
    var description: String {
        """
        📚 Localized copy output 📚
        
        String.LocalizationValue 👉 \(Self.localizationValue)
        
        StaticString 👉 \(Self.staticString)
        
        LocalizedStringResource with stringLiteral 👉 \(Self.localizedResourceWithStringLiteral)
        
        LocalizedStringResource with String.LocalizationValue 👉 \(Self.localizedResourceWithLocalizationValue)
        
        LocalizedStringResource with StaticString 👉 \(Self.localizedResourceWithStaticString)
        
        String with localized 👉 \(Self.localizedString)
        
        LocalizedStringKey 👉 \(Self.localizedStringKey)
        
        NSLocalizedString 👉 \(Self.localizedStringOldWay)

        """
    }
}
