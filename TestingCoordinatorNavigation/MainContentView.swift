//
//  MainContentView.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 09-08-22.
//

import Login
import Navigation
import SwiftUI
import UI

struct MainContentView: View {
    @ObservedObject var tabBarCoordinator = MainTabBarCoordinator()
    @ObservedObject var sessionManager = SessionManager()
    @ObservedObject var loginCoordinator = MainNavigationCoordinator()
    @ObservedObject var loginViewModel = LoginViewModel()

    init(appDelegate: AppDelegate) {
        setUpNavigation()
        appDelegate.tabBarCoordinator = self.tabBarCoordinator
        appDelegate.loginCoordinator = self.loginCoordinator
    }

    var body: some View {
        // uncomment this to debug
        /*Toggle(isOn: $sessionManager.isLogged) {
            Text("Is logged: ")
        }
        .padding()
        .background(.yellow)*/
        VStack {
            if sessionManager.isLogged {
                TabBarView(coordinator: tabBarCoordinator) {
                    ForEach(tabBarCoordinator.tabs) { viewModel in
                        Navigation(viewModel: viewModel) {
                            ViewFactory(viewModel: viewModel)
                        }
                    }
                }
            } else {
                Navigation(viewModel: loginViewModel) {
                    ViewFactory(viewModel: loginViewModel)
                }
            }
        }
        .modifier(BannerModifier(model: $loginCoordinator.bannerData))
        .onOpenURL { url in handleDeeplink(url: url) }
    }

    func setUpNavigation() {
        // Sets up the navigation for the logged state
        let coordinator1 = MainNavigationCoordinator(tabBarCoordinator: self.tabBarCoordinator)
        coordinator1.sessionManager = sessionManager

        let coordinator2 = MainNavigationCoordinator(tabBarCoordinator: self.tabBarCoordinator)
        coordinator2.sessionManager = sessionManager
        tabBarCoordinator.tabs = [
            View1ViewModel(coordinator: coordinator1),
            View2ViewModel(coordinator: coordinator2)
        ]

        // Sets up the navigation for the logged out state
        tabBarCoordinator.sessionManager = sessionManager
        loginCoordinator.sessionManager = sessionManager
        loginViewModel.coordinator = loginCoordinator
    }

    func handleDeeplink(url: URL) {
        if !(loginCoordinator.sessionManager?.isLogged ?? true) {
            let bannerData = BannerData(title: "Debes iniciar sesión primero", type: .warning)
            loginCoordinator.showBanner(bannerData: bannerData)
        }

        guard let payload = DeeplinkManager.extractPushNotificationPayload(from: url) else { return }
        tabBarCoordinator.handleNotification(payload: payload)
    }
}
