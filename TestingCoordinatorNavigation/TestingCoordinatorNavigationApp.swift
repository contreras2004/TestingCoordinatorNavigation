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

@main
struct TestingCoordinatorNavigationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
