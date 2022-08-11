//
//  MainContentView.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 09-08-22.
//

import Login
import Navigation
import SwiftUI

struct MainContentView: View {
    @ObservedObject var tabBarCoordinator = MainTabBarCoordinator()
    @ObservedObject var sessionManager = SessionManager()
    @ObservedObject var loginCoordinator = MainNavigationCoordinator()
    @ObservedObject var loginViewModel = LoginViewModel()

    //dumy vars
    @State var stack: [String] = []

    init() {
        setUpNavigation()
    }

    var body: some View {
        Toggle(isOn: $sessionManager.isLogged) {
            Text("Is logged: ")
        }
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

        //sets up the navigation for the logged out state
        loginCoordinator.sessionManager = sessionManager
        loginViewModel.coordinator = loginCoordinator
    }
}
