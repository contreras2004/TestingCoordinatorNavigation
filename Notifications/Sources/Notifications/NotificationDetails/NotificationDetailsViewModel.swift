//
//  NotificationDetailsViewModel.swift
//  
//
//  Created by m.contreras.selman on 18-08-22.
//

import Foundation
import Navigation

public final class NotificationDetailsViewModel: BaseViewModel {
    @Published var notification: NotificationsResponseModel.Notification?

    var service: NotificationsServiceProtocol

    override public var title: String { L10n.notification }

    public init(notification: NotificationsResponseModel.Notification) {
        self.notification = notification
        self.service = NotificationsService()
        super.init()
    }

    public init(
        notificationId: Int,
        service: NotificationsServiceProtocol = NotificationsService()) {
        self.service = service
        super.init()
        fetchNotificationDetail(id: notificationId)
    }

    private func fetchNotificationDetail(id: Int) {
        service.fetchNotification(id: id) { [weak self] result in
            switch result {
            case .success(let notification):
                self?.notification = notification
            case .failure(let error):
                debugPrint("error: \(error)")
            }
        }
    }
}
