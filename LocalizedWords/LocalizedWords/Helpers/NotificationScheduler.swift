//
//  NotifcationScheduler.swift
//  LocalizedWords
//
//  Created by Radu Dan on 01.02.2025.
//

import UserNotifications

/// A class responsible for scheduling and managing local notifications with localized content.
/// This scheduler handles the creation, authorization, and delivery of notifications
/// using the user's preferred locale for message content.
struct NotificationScheduler {

    /// The localized greeting message key used in notifications.
    private static let greeting = LocalizedStringResource("main.onboarding.title.label")

    /// Schedules a localized notification for the user.
    /// - Parameter locale: The locale to be used for the notification content.
    /// - Note: The notification will be scheduled to appear 5 seconds after being created.
    func scheduleNotification(forUserWithLocale locale: Locale) async {
        // Create a unique notification request with localized content and trigger
        // The UUID ensures each notification has a unique identifier
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: buildContent(locale: locale),
            trigger: buildTrigger()
        )

        // Get the shared notification center instance for managing notifications
        let notificationCenter = UNUserNotificationCenter.current()

        // Request user's permission to show notifications
        await requestAuthorization(notificationCenter: notificationCenter)

        // Schedule the notification with the notification center
        await scheduleNotification(
            request: request,
            notificationCenter: notificationCenter
        )
    }

    /// Builds the notification content with localized message.
    /// - Parameter locale: The locale to be used for the message content.
    /// - Returns: A configured notification content object.
    private func buildContent(locale: Locale) -> UNMutableNotificationContent {
        // Create a localized message resource and set its locale
        var messageResource = Self.greeting
        messageResource.locale = locale

        // Create and configure the notification content
        let content = UNMutableNotificationContent()
        content.title = "Localized Words App"  // Set the app name as the notification title

        // content.body = String(localized: messageResource)  // Set the localized message as the notification body
        content.body = String(localized: "main.onboarding.title.label")

        return content
    }

    /// Creates a time-based trigger for the notification.
    /// - Returns: A trigger that fires the notification after 'N' seconds.
    private func buildTrigger() -> UNTimeIntervalNotificationTrigger {
        UNTimeIntervalNotificationTrigger(
            timeInterval: 10, // in seconds
            repeats: false // fired once
        )
    }

    /// Requests authorization to show notifications to the user.
    /// - Parameter notificationCenter: The notification center to request authorization from.
    private func requestAuthorization(
        notificationCenter: UNUserNotificationCenter
    ) async {
        // Request notification authorization from the user
        // We only request permission to show alerts (not sounds or badges)
        do {
            try await notificationCenter
                .requestAuthorization(options: [.alert])
        } catch {
            // If authorization fails, print the error to console
            print(error)
        }
    }

    /// Schedules the notification request with the notification center.
    /// - Parameters:
    ///   - request: The notification request to be scheduled.
    ///   - notificationCenter: The notification center to schedule the notification with.
    private func scheduleNotification(
        request: UNNotificationRequest,
        notificationCenter: UNUserNotificationCenter
    ) async {
        do {
            // Attempt to schedule the notification with the notification center
            try await notificationCenter.add(request)
        } catch {
            // If scheduling fails, print the error to console for debugging
            print(error)
        }
    }
}
