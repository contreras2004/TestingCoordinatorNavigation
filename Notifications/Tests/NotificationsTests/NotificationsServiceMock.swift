//
//  NotificationsServiceMock.swift
//  
//
//  Created by m.contreras.selman on 22-08-22.
//

import Combine
import Foundation
import SwiftUI
import TestUtils
import Networking

@testable import Notifications

class NotificationsServiceMock: NotificationsServiceProtocol {
    
    var api: Networking.ApiProtocol = API()
    
    enum ServiceState {
        case success, error, noReturn
    }
    
    var serviceState: ServiceState = .success
    
    func getNotifications(completion: @escaping (Result<[Notifications.NotificationsResponseModel.Notification], Networking.APIError>) -> Void) {
        switch serviceState {
        case .success:
            let response: NotificationsResponseModel = JSONHelper.loadJSON(withFile: "notificationsSuccess", inBundleWithName: "Notifications", subdirectory: "JSON")!
            completion(.success(response.notifications))
        case .error:
            completion(.failure(APIError.invalidResponse))
        case .noReturn:
            return
        }
    }
    
    func fetchNotification(id: Int, completion: @escaping (Result<Notifications.NotificationsResponseModel.Notification, Networking.APIError>) -> Void) {
        switch serviceState {
        case .success:
            let response: NotificationsResponseModel.Notification = JSONHelper.loadJSON(withFile: "notificationDetails", inBundleWithName: "Notifications", subdirectory: "JSON")!
            completion(.success(response))
        case .error:
            completion(.failure(APIError.invalidResponse))
        case .noReturn:
            return
        }
    }
    
    
}
