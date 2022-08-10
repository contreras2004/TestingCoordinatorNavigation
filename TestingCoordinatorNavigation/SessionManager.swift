//
//  SessionManager.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 03-08-22.
//

import Foundation
import SwiftUI

class SessionManager: ObservableObject {
    @AppStorage("isLogged") public var isLogged = true {
        didSet {
            withAnimation {
                self.objectWillChange.send()
            }
        }
    }
}
