//
//  NotificationsListViewModel.swift
//  
//
//  Created by m.contreras.selman on 17-08-22.
//

import Foundation
import Navigation
import SwiftUI

public class NotificationsListViewModel: BaseViewModel {
    enum ViewState: Equatable {
        case loading
        case withData(notifications: [NotificationsResponseModel.Notification])
        case withError

        static func == (lhs: NotificationsListViewModel.ViewState, rhs: NotificationsListViewModel.ViewState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .withError):
                return false
            case (.withError, withError):
                return true
            default:
                return false
            }
        }
    }

    @Published var state: ViewState = .loading

    var service: NotificationsServiceProtocol = NotificationsService()

    override public var title: String { L10n.notificationsTitle }

    init(
        service: NotificationsServiceProtocol = NotificationsService(),
        coordinator: NavigationCoordinator = NavigationCoordinator(tabBarCoordinator: nil)) {
        self.service = service
        super.init(coordinator: coordinator)

        getNotifications()
    }

    override public convenience init(coordinator: NavigationCoordinator) {
        self.init(service: NotificationsService(), coordinator: coordinator)
    }

    func getNotifications() {
        if state == .withError {
            state = .loading
        }

        service.getNotifications { [weak self] result in
            switch result {
            case .success(let notifications):
                withAnimation {
                    self?.state = .withData(notifications: notifications)
                }
            case .failure:
                self?.state = .withError
            }
        }
    }

    func removeNotification(at offsets: IndexSet) {
        switch state {
        case .withData(var notifications):
            offsets.forEach { index in
                notifications.remove(at: index)
            }
            state = .withData(notifications: notifications)
        default:
            debugPrint("nothing to remove")
        }
    }
}
