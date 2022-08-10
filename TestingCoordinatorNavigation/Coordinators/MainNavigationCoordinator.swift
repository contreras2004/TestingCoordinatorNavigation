//
//  MainNavigationCoordinator.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 02-08-22.
//

import Login
import Navigation
import Register

enum MainNavigationCoordinatorEvent: NavigationCoordinatorEvent {
    case goToFirstPage
    case goToSecondPage
    case goToThirdPage
    case goToRoot
    case goToTab(index: Int)
    case logout
}

class MainNavigationCoordinator: NavigationCoordinator {
    weak var sessionManager: SessionManager?

    var mainTabBarCoordinator: MainTabBarCoordinator? {
        self.tabBarCoordinator as? MainTabBarCoordinator
    }

    override func handle(event: NavigationCoordinatorEvent) {
        if let event = event as? MainNavigationCoordinatorEvent {
            switch event {
            case .logout:
                logout()
            case .goToFirstPage:
                goToFirstPage()
            case .goToSecondPage:
                goToSecondPage()
            case .goToThirdPage:
                goToThirdPage()
            case .goToRoot:
                path.removeAll()
            case .goToTab(let index):
                goToTab(index: index)
            }
        }

        if let event = event as? LoginEvents {
            switch event {
            case .login:
                login()
            case .goToRegisterForm:
                goToRegisterForm()
            case .showModal:
                self.isShowingModal = true

            case .dismissModal:
                self.isShowingModal = false
            }
        }

        if let event = event as? RegisterEvent {
            switch event {
            case .goToRoot:
                path.removeAll()
            }
        }
    }
}
