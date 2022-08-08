//
//  Coordinator.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 01-08-22.
//

import Foundation
import Navigation
import SwiftUI

enum MainTabBarCoordinatorEvent: TabBarCoordinatorEvent {
    case goToTab(index: Int)
}

class MainTabBarCoordinator: TabBarViewCoordinator {
    override func handle(event: TabBarCoordinatorEvent) {
        guard let event = event as? MainTabBarCoordinatorEvent else {
            fatalError("Event not recognized")
        }

        switch event {
        case .goToTab(index: let index):
            goToTab(index: index)
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
        case .thirdView:
            goToTab(index: 0)
        case .none:
            break
        }
    }
}
