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

    override public init(coordinator: NavigationCoordinator = NavigationCoordinator(tabBarCoordinator: nil)) {
        super.init(coordinator: coordinator)
        getNotifications()
    }

    func getNotifications() {
        if state == .withError {
            state = .loading
        }
        Task {
            let response = await service.getNotifications()
            DispatchQueue.main.async { [weak self] in
                switch response {
                case .success(let notifications):
                    self?.state = .withData(notifications: notifications)
                case .failure:
                    self?.state = .withError
                }
            }
        }
    }

    func removeNotification(at offsets: IndexSet) {
        debugPrint("we need to remove the item")
    }
}
