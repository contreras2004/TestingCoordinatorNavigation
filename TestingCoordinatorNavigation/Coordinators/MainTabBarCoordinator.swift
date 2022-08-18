//
//  Coordinator.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 01-08-22.
//

import Foundation
import Navigation
import Notifications
import SwiftUI

enum MainTabBarCoordinatorEvent: TabBarCoordinatorEvent {
    case goToTab(index: Int)
    case handleNotification(payload: PushNotificationPayload)
}

class MainTabBarCoordinator: TabBarViewCoordinator {
    weak var sessionManager: SessionManager?

    override func handle(event: TabBarCoordinatorEvent) {
        guard let event = event as? MainTabBarCoordinatorEvent else {
            fatalError("Event not recognized")
        }

        switch event {
        case .goToTab(index: let index):
            goToTab(index: index)
        case .handleNotification(payload: let payload):
            handleNotification(payload: payload)
        }
    }

    func goToTab(index: Int) {
        if tabs.count >= index - 1 {
            self.selectedTab = tabs[index].id
        } else {
            debugPrint("There is no such tab index")
        }
    }

    func handleNotification(payload: PushNotificationPayload) {
        switch payload.flow {
        case .notification:
            if let notificationId = payload.data?["notificationId"] as? Int {
                goToTab(index: 0)
                tabs[0].coordinator.path = []
                tabs[0].coordinator.path.append(NotificationsListViewModel(coordinator: tabs[0].coordinator))
                tabs[0].coordinator.path.append(NotificationDetailsViewModel(notificationId: notificationId))
            }
        case .exampleModal:
            goToTab(index: 1)
            tabs[1].actionForNavigationButton()
        case .none:
            break
        }
    }

    deinit {
        debugPrint("\(self) deinit")
    }
}
