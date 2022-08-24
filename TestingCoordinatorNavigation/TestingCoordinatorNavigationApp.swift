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
import Theme
import UI

@main
struct TestingCoordinatorNavigationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        setUpTabbarColor(color: ThemeColor.primaryAccent.swiftUIColor)
    }

    var body: some Scene {
        WindowGroup {
            MainContentView(appDelegate: appDelegate)
        }
    }
}

extension TestingCoordinatorNavigationApp {
    func setUpTabbarColor(color: Color) {
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.selected.iconColor = UIColor(color)
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(color)]

        let appeareance = UITabBarAppearance()
        appeareance.stackedLayoutAppearance = itemAppearance
        appeareance.inlineLayoutAppearance = itemAppearance
        appeareance.compactInlineLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = appeareance
    }
}
