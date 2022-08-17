//
//  File.swift
//  
//
//  Created by m.contreras.selman on 17-08-22.
//

struct NotificationsResponseModel: Codable {
    struct Notification: Codable {
        var id: String
        let message: String
    }

    let notifications: [Notification]
}
