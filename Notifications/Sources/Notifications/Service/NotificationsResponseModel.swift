//
//  File.swift
//  
//
//  Created by m.contreras.selman on 17-08-22.
//

import Foundation

public struct NotificationsResponseModel: Codable {
    public struct Notification: Codable {
        var id: String
        let title: String
        let message: String
        let image: URL
    }

    let notifications: [Notification]
}

struct NotificationDetailRequestModel: Codable {
    let id: Int
}
