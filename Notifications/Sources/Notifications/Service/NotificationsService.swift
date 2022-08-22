//
//  NotificationsService.swift
//  
//
//  Created by m.contreras.selman on 17-08-22.
//

import Foundation
import Networking

public protocol NotificationsServiceProtocol {
    var api: ApiProtocol { get }

    func getNotifications(completion: @escaping (Result<[NotificationsResponseModel.Notification], APIError>) -> Void)

    func fetchNotification(id: Int, completion: @escaping (Result<NotificationsResponseModel.Notification, APIError>) -> Void)
}

public class NotificationsService: NotificationsServiceProtocol {
    public var api: Networking.ApiProtocol = API()

    public init() { }

    public func getNotifications(completion: @escaping (Result<[NotificationsResponseModel.Notification], Networking.APIError>) -> Void) {
        Task {
            let response = await api.execute(
                endpoint: .notifications,
                decodingType: NotificationsResponseModel.self,
                httpMethod: .get,
                params: nil)
            DispatchQueue.main.async {
                switch response {
                case .success(let responseModel):
                    completion(.success(responseModel.notifications))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

    public func fetchNotification(id: Int, completion: @escaping (Result<NotificationsResponseModel.Notification, Networking.APIError>) -> Void ) {
        Task {
            let params = NotificationDetailRequestModel(id: id)
            let response = await api.execute(
                endpoint: .notification,
                decodingType: NotificationsResponseModel.Notification.self,
                httpMethod: .post,
                params: params)
            DispatchQueue.main.async {
                switch response {
                case .success(let responseModel):
                    completion(.success(responseModel))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
