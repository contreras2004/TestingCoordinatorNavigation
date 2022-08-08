//
//  NotificationModel.swift
//  Tolls
//
//  Created by m.contreras.selman on 22-07-22.
//

import Foundation

struct NotificationModel: Codable {
    struct Alert: Codable {
        let title: String
        let body: String
        let subtitle: String
    }

    let alert: Alert
    let badge: Int
    let sound: String
    let destination: String
}

struct PushNotificationBody {
    let aps: PushNotificationAps
    let payload: PushNotificationPayload?

    private enum Keys: String {
        case aps
        case payload
    }

    init?(userInfo: [AnyHashable: Any]) {
        guard let apsDict = userInfo[Keys.aps.rawValue] as? [String: AnyHashable],
              let payloadDict = userInfo[Keys.payload.rawValue] as? [String: AnyHashable],
              let data = try? JSONSerialization.data(withJSONObject: apsDict, options: .fragmentsAllowed),
              let aps = try? JSONDecoder().decode(PushNotificationAps.self, from: data),
              let payload = PushNotificationPayload(payload: payloadDict)
        else {
            return nil
        }

        self.aps = aps
        self.payload = payload
    }
}

struct PushNotificationAps: Codable {
    struct PushNotificationAlert: Codable {
        let title: String?
        let body: String?
    }

    let alert: PushNotificationAlert?
    let badge: Int?
    let sound: String?
    let contentAvailable: Bool
    let mutableContent: Bool
    let category: String?

    private enum CodingKeys: String, CodingKey {
        case alert
        case badge
        case sound
        case contentAvailable = "content-available"
        case mutableContent = "mutable-content"
        case category
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.alert = try values.decodeIfPresent(PushNotificationAlert.self, forKey: .alert)
        self.badge = try values.decodeIfPresent(Int.self, forKey: .badge)
        self.sound = try values.decodeIfPresent(String.self, forKey: .sound)
        self.category = try values.decodeIfPresent(String.self, forKey: .category)

        let contentAvailable = try values.decodeIfPresent(Int.self, forKey: .contentAvailable) ?? 0
        self.contentAvailable = contentAvailable == 1

        let mutableContent = try values.decodeIfPresent(Int.self, forKey: .mutableContent) ?? 0
        self.mutableContent = mutableContent == 1
    }
}

// swiftlnt:disable:this discouraged_optional_collection
struct PushNotificationPayload {
    let flow: PushNotificationFlow
    let data: [String: AnyHashable]?

    private enum Keys: String {
        case flow
        case data
    }

    init?(payload: [AnyHashable: Any]) {
        guard let flow = payload[Keys.flow.rawValue] as? String else { return nil }
        self.flow = PushNotificationFlow(rawValue: flow) ?? .none
        self.data = payload[Keys.data.rawValue] as? [String: AnyHashable]
    }
}

enum PushNotificationFlow: String, Codable {
    case thirdView
    case none
}
