//
//  ChallengeView.swift
//  LocalizedWords
//
//  Created by Radu Dan on 01.02.2025.
//

import SwiftUI

struct ChallengeView: View {
    @State private var alertMessage: LocalizedStringResource = ""
    @State private var showAlert = false
    @State private var enteredWord = ""

    private let acceptedLocalizedKeys = ["walrus", "cone", "banana"]

    private lazy var localizedKeyValuesWords = Dictionary(
        uniqueKeysWithValues: acceptedLocalizedKeys.map { key in
            let translatedCopy = String.LocalizationValue(key)
            return (key, String(localized: translatedCopy))
        }
    )

    private static let suffixForSpecialHint = "_value"

    var body: some View {
        contentView
            .onChange(of: enteredWord) { _, newValue in
                checkWord(newValue)
            }
            .alert(Text(alertMessage), isPresented: $showAlert) {
                Button("OK") {
                    showAlert = false
                }
            }
    }

    private func checkWord(_ enteredText: String) {
        let localizedKeyValueWords = Dictionary(
            uniqueKeysWithValues: acceptedLocalizedKeys.map { key in
                let translatedCopy = String.LocalizationValue(key)
                return (key, String(localized: translatedCopy))
            }
        )
        if let specialHint = FindWordInListCaseInsensitiveUseCase.invoke(
            input: enteredText,
            wordsDictionary: localizedKeyValueWords
        ) {
            alertMessage = LocalizedStringResource(
                stringLiteral: "\(specialHint.localizedKey)\(Self.suffixForSpecialHint)"
            )
            showAlert = true
        }
    }
}

// MARK: - Views

private extension ChallengeView {
    var contentView: some View {
        VStack(
            alignment: .leading,
            spacing: Constants.contentSpacing
        ) {
            textFieldLabel
            enterWordTextField
        }
        .padding(.horizontal)
        .padding()
    }

    var textFieldLabel: some View {
        Text("Enter your guess:")
            .font(.headline)
            .foregroundStyle(.secondary)
    }

    var enterWordTextField: some View {
        TextField("Keyword", text: $enteredWord)
            .textFieldStyle(.plain)
            .padding()
            .background(textFieldBackground)
            .overlay(textfieldOverlay)
            .autocapitalization(.none)
            .autocorrectionDisabled()
    }

    var textFieldBackground: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(Colors.fieldBackground)
            .shadow(
                color: Colors.fieldShadowColor,
                radius: Constants.shadowRadius,
                x: Constants.shadowXValue,
                y: Constants.shadowYValue
            )
    }

    var textfieldOverlay: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .stroke(
                Colors.fieldOverlayStroke,
                lineWidth: Constants.overlayStrokeWidth
            )
    }
}

// MARK: - Constants

private extension ChallengeView {
    enum Colors {
        static let fieldBackground = Color(.systemBackground)
        static let fieldOverlayStroke = Color.gray.opacity(0.2)
        static let fieldShadowColor = Color.black.opacity(0.1)
    }

    enum Constants {
        static let shadowRadius: CGFloat = 5
        static let shadowXValue: CGFloat = 0
        static let shadowYValue: CGFloat = 2
        static let cornerRadius: CGFloat = 12
        static let overlayStrokeWidth: CGFloat = 1
        static let contentSpacing: CGFloat = 8
    }
}

// MARK: - Preview

#Preview {
    ChallengeView()
}
