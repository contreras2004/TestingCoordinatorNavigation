//
//  LoginEvents.swift
//  
//
//  Created by m.contreras.selman on 03-08-22.
//

import Foundation
import Navigation

public enum LoginEvents: NavigationCoordinatorEvent {
    case login
    case goToRegisterForm
    case showModal
    case dismissModal
}
