//
//  MainNavigationCoordinator.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 02-08-22.
//

import Login
import Navigation
import Notifications
import Register
import SwiftUI
import UI

enum MainNavigationCoordinatorEvent: NavigationCoordinatorEvent {
    case goToFirstPage
    case goToSecondPage
    case goToThirdPage
    case goToRoot
    case goToTab(index: Int)
    case logout
    case removePreviouseViewFromStack
    case goToNotifications
}

class MainNavigationCoordinator: NavigationCoordinator {
    weak var sessionManager: SessionManager?

    @Published var bannerData: BannerData?

    var mainTabBarCoordinator: MainTabBarCoordinator? {
        self.tabBarCoordinator as? MainTabBarCoordinator
    }

    func showBanner(bannerData: BannerData) {
        self.bannerData = bannerData
    }

    //swiftlint:disable cyclomatic_complexity
    override func handle(event: NavigationCoordinatorEvent) {
        switch event {
        case let event as MainNavigationCoordinatorEvent:
            handle(event: event)
        case let event as LoginEvents:
            handle(event: event)
        case let event as NotificationsEvents:
            handle(event: event)
        case let event as RegisterEvent:
            handle(event: event)
        default:
            debugPrint("The event could not be handled. Did you forget to add is to the switch statement?")
        }
    }
}

extension MainNavigationCoordinator {
    private func handle(event: MainNavigationCoordinatorEvent) {
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
        case .removePreviouseViewFromStack:
            removePreviouseView()
        case .goToNotifications:
            goToNotifications()
        }
    }

    private func handle(event: LoginEvents) {
        switch event {
        case .login:
            login()
        case .goToRegisterForm:
            goToRegisterForm()
        case .showModal:
            DispatchQueue.main.async { [weak self] in
                self?.isShowingModal = true
            }

        case .dismissModal:
            DispatchQueue.main.async { [weak self] in
                self?.isShowingModal = false
            }
        }
    }

    private func handle(event: NotificationsEvents) {
        switch event {
        case .goToNotification(let viewModel):
            goToNotificationDetails(viewModel: viewModel)
        }
    }

    private func handle(event: RegisterEvent) {
        switch event {
        case .goToRoot:
            path.removeAll()
        }
    }
}
