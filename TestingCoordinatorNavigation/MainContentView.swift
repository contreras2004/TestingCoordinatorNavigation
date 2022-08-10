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
    var loginViewModel = LoginViewModel()

    var body: some View {
        VStack {
            if sessionManager.isLogged {
                Spacer()
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
