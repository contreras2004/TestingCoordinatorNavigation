//
//  MainNavigationCoordinator+Extension.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 03-08-22.
//

import Foundation
import Register

extension MainNavigationCoordinator {
    func login() {
        sessionManager?.isLogged = true
    }

    func goToRegisterForm() {
        path.append(RegisterFormViewModel(coordinator: self))
    }

    func logout() {
        resetNavigation()
        sessionManager?.isLogged = false
    }

    private func resetNavigation() {
        if let tabs = tabBarCoordinator?.tabs {
            for tab in tabs {
                tab.coordinator.path = []
            }
        }
        if let selectedTab = tabBarCoordinator?.tabs.first {
            tabBarCoordinator?.selectedTab = selectedTab.id
        }
    }

    func goToFirstPage() {
        path.append(View1ViewModel(coordinator: self))
    }

    func goToSecondPage() {
        path.append(View2ViewModel(coordinator: self))
    }

    func goToThirdPage() {
        path.append(View3ViewModel(coordinator: self))
    }

    func goToTab(index: Int) {
        tabBarCoordinator?.handle(event: MainTabBarCoordinatorEvent.goToTab(index: index))
    }

    func removePreviouseView() {
        if path.count - 2 >= 0 {
            path.remove(at: path.count - 2)
        } else {
            debugPrint("No enough views in the stack")
        }
    }
}
