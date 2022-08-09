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
    @ObservedObject var tabBarCoordinator = MainTabBarCoordinator()
    @ObservedObject var sessionManager = SessionManager()

    var loginCoordinator = MainNavigationCoordinator()
    var loginViewModel = LoginViewModel()

    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.setUpNavigation(isLogged: sessionManager.isLogged)
        appDelegate.coordinator = self.tabBarCoordinator
    }

    var body: some Scene {
        WindowGroup {
            if sessionManager.isLogged {
                TabBarView(coordinator: tabBarCoordinator) {
                    ForEach(tabBarCoordinator.tabs) { viewModel in
                        Navigation(viewModel: viewModel) {
                            ViewFactory(viewModel: viewModel)
                        }
                    }
                }.onAppear {
                    setUpNavigation(isLogged: true)
                }
            } else {
                Navigation(viewModel: loginViewModel) {
                    ViewFactory(viewModel: loginViewModel)
                }.onAppear {
                    setUpNavigation(isLogged: false)
                }
            }
        }
    }

    func setUpNavigation(isLogged: Bool) {
        // prevent everything to be in memory when user is not logged
        if isLogged {
            let coordinator1 = MainNavigationCoordinator(tabBarCoordinator: self.tabBarCoordinator)
            coordinator1.sessionManager = sessionManager

            let coordinator2 = MainNavigationCoordinator(tabBarCoordinator: self.tabBarCoordinator)
            coordinator2.sessionManager = sessionManager
                tabBarCoordinator.tabs = [
                    View1ViewModel(coordinator: coordinator1),
                    View2ViewModel(coordinator: coordinator2)
                ]
        } else {
            loginCoordinator.sessionManager = sessionManager
            loginViewModel.coordinator = loginCoordinator
        }
    }
}
