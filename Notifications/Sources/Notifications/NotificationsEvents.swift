//
//  File.swift
//  
//
//  Created by m.contreras.selman on 18-08-22.
//

import Foundation
import Navigation

public enum NotificationsEvents: NavigationCoordinatorEvent {
    case goToNotification(viewModel: NotificationDetailsViewModel)
}
