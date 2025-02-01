//
//  MainView.swift
//  LocalizedWords
//
//  Created by Radu Dan on 31.01.2025.
//

import SwiftUI

struct MainView: View {
    private let scheduler = NotificationScheduler()

    var body: some View {
        NavigationStack {
            contentView
                .background(cardView)
                .onAppear(perform: onAppear)
        }
    }
}

// MARK: - Methods

private extension MainView {
    func onAppear() {
        print(StringsHolder())
    }
}

// MARK: - Views

private extension MainView {
    var contentView: some View {
        VStack(spacing: Padding.small) {
            mainImageView
            messageTextView
            scheduleNotificationView
            challengeNavigationLink
        }
        .padding(Padding.large)
    }

    var mainImageView: some View {
        Image(systemName: ImageConstants.symbolName)
            .font(.system(size: ImageConstants.size))
            .foregroundStyle(.yellow)
    }

    var messageTextView: some View {
        Text(StringsHolder.localizedResourceWithStringLiteral)
            .font(.largeTitle)
            .bold()
            .multilineTextAlignment(.center)
            .foregroundStyle(.primary)
            .padding([.leading, .trailing], Padding.standard)
    }

    var cardView: some View {
        RoundedRectangle(cornerRadius: Card.cornerRadius)
            .fill(cardBackgroundGradient)
            .padding()
    }

    var cardBackgroundGradient: some ShapeStyle {
        LinearGradient(
            colors: Card.gradientColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var scheduleNotificationView: some View {
        makeTextView(title: "Schedule Notification")
            .onTapGesture(perform: scheduleNotification)
    }

    func scheduleNotification() {
        Task {
            await scheduler.scheduleNotification(
                forUserWithLocale: Locale.current
            )
        }
    }

    var challengeNavigationLink: some View {
        NavigationLink {
            ChallengeView()
        } label: {
            makeTextView(title: "Go to Challenge")
        }
    }

    func makeTextView(title: LocalizedStringResource) -> some View {
        Text(title)
            .font(.title2)
            .bold()
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Card.cornerRadius)
                    .fill(Card.color)
            )
    }
}

// MARK: - Constants

private extension MainView {
    enum Padding {
        static let standard: CGFloat = 32
        static let large: CGFloat = 64
        static let small: CGFloat = 12
    }

    enum ImageConstants {
        static let size: CGFloat = 100
        static let symbolName = "sun.max.fill"
    }

    enum Card {
        static let color = Color(red: 0.3, green: 0.2, blue: 0.7)
        static let cornerRadius: CGFloat = 15
        static let gradientColors: [Color] = [
            .blue.opacity(0.2),
            .purple.opacity(0.2)
        ]
    }
}

// MARK: - Previews

#Preview {
    MainView()
}

#Preview {
    MainView()
        .environment(\.locale, Locale(identifier: "FR"))
}
