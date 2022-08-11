//
//  AppDelegate.swift
//  Tolls
//
//  Created by m.contreras.selman on 15-07-22.
//

import Foundation
import Navigation
import SwiftUI
import UIKit

// swiftlint:disable discouraged_optional_collection
class AppDelegate: NSObject, UIApplicationDelegate {
    weak var tabBarCoordinator: MainTabBarCoordinator?
    weak var loginCoordinator: MainNavigationCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
            // _ = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)

            debugPrint("didFinish with options: \(String(describing: launchOptions))")
            if let launchOptions = launchOptions,
               let userInfo = launchOptions[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable: Any],
               let notificationBody = PushNotificationBody(userInfo: userInfo),
               let payload = notificationBody.payload {
                handleNotification(payload: payload)
            }

            application.registerForRemoteNotifications()
            return true
        }

    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            guard let body = PushNotificationBody(userInfo: userInfo),
                  let payload = body.payload else { completionHandler(UIBackgroundFetchResult.newData); return }
            handleNotification(payload: payload)
            //coordinator?.handleNotification(payload: payload)
            completionHandler(UIBackgroundFetchResult.newData)
        }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
            guard let body = PushNotificationBody(userInfo: response.notification.request.content.userInfo),
                  let payload = body.payload else { completionHandler(); return }
            handleNotification(payload: payload)
            completionHandler()
        }
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            debugPrint("willPresent notification: \(notification)")
            completionHandler([[.banner, .badge, .sound]])
        }

    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
            debugPrint("didReceiveRemoteNotification: \(userInfo)")
        }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            debugPrint("didRegisterForRemoteNotificationsWithDeviceToken: \(deviceToken)")
        }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
            debugPrint("Error registering for notifications: \(error)")
        }

    private func handleNotification(payload: PushNotificationPayload) {
        self.loginCoordinator?.showBanner()
        self.tabBarCoordinator?.handleNotification(payload: payload)
    }
}
