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

    var service: NotificationsServiceProtocol = NotificationsService()

    override public var title: String { L10n.notification }

    public init(notification: NotificationsResponseModel.Notification) {
        self.notification = notification
    }

    public init(notificationId: Int) {
        super.init()
        fetchNotificationDetail(id: notificationId)
    }

    private func fetchNotificationDetail(id: Int) {
        Task {
            let response = await service.fetchNotification(id: id)
            DispatchQueue.main.async { [weak self] in
                switch response {
                case .success(let notification):
                    self?.notification = notification
                case .failure(let error):
                    debugPrint("error")
                }
            }
        }
    }
}
