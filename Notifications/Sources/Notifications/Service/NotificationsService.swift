//
//  NotificationsService.swift
//  
//
//  Created by m.contreras.selman on 17-08-22.
//

import Networking

protocol NotificationsServiceProtocol {
    var api: ApiProtocol { get }

    func getNotifications() async -> Result<[NotificationsResponseModel.Notification], APIError>
    func fetchNotification(id: Int) async -> Result<NotificationsResponseModel.Notification, APIError>
}

class NotificationsService: NotificationsServiceProtocol {
    var api: Networking.ApiProtocol = API()

    func getNotifications() async -> Result<[NotificationsResponseModel.Notification], Networking.APIError> {
        let response = await api.execute(
            endpoint: .notifications,
            decodingType: NotificationsResponseModel.self,
            httpMethod: .get,
            params: nil)
        switch response {
        case .success(let responseModel):
            return .success(responseModel.notifications)
        case .failure(let error):
            return .failure(error)
        }
    }

    func fetchNotification(id: Int) async -> Result<NotificationsResponseModel.Notification, Networking.APIError> {
        let params = NotificationDetailRequestModel(id: id)
        let response = await api.execute(
            endpoint: .notification,
            decodingType: NotificationsResponseModel.Notification.self,
            httpMethod: .post,
            params: params)
        switch response {
        case .success(let responseModel):
            return .success(responseModel)
        case .failure(let error):
            return .failure(error)
        }
    }
}
