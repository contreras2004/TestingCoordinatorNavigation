//
//  SessionManager.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 03-08-22.
//

import Foundation
import SwiftUI

class SessionManager: ObservableObject {
    static let key: String = "isLogged"

    public var isLogged = false {
        willSet {
            withAnimation {
                objectWillChange.send()
            }
        }
        didSet {
            UserDefaults.standard.set(self.isLogged, forKey: SessionManager.key)
        }
    }

    init() {
        self.isLogged = UserDefaults.standard.bool(forKey: SessionManager.key)
    }
}
