//
//  MainNavigationCoordinator+Extension.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 03-08-22.
//

import Foundation

extension MainNavigationCoordinator {
    func login() {
        sessionManager?.isLogged = true
    }

    func logout() {
        sessionManager?.isLogged = false
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
}
