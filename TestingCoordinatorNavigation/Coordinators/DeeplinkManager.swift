//
//  DeeplinkManager.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 22-08-22.
//

import Foundation

// swiftlint:disable convenience_type
class DeeplinkManager {
    enum DeepLinkConstants: String {
        case scheme = "tcn"
        case host = "matiascontreras.TestingCoordinatorNavigation"
    }

    static func extractPushNotificationPayload(from url: URL) -> PushNotificationPayload? {
        guard url.scheme == DeepLinkConstants.scheme.rawValue,
              url.host == DeepLinkConstants.host.rawValue,
              let flow = PushNotificationFlow(rawValue: url.lastPathComponent)
        else { return nil }
        return PushNotificationPayload(flow: flow, payload: url.queryDictionary)
    }
}
