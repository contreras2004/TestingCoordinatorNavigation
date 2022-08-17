//
//  MainNavigationCoordinator.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 02-08-22.
//

import Login
import Navigation
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

    deinit {
        debugPrint("\(self) deinit")
    }

    func showBanner(bannerData: BannerData) {
        self.bannerData = bannerData
    }

    //swiftlint:disable cyclomatic_complexity
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
            case .removePreviouseViewFromStack:
                removePreviouseView()
            case .goToNotifications:
                goToNotifications()
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
