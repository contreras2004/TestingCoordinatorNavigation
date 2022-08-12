//
//  TestingCoordinatorNavigationApp.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 01-08-22.
//

import Foundation
import Login
import Navigation
import SwiftUI
import UI

@main
struct TestingCoordinatorNavigationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainContentView(appDelegate: appDelegate)
        }
    }
}
