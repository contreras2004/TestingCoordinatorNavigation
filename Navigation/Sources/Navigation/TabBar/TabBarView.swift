//
//  TabBarView.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 01-08-22.
//

import Foundation
import SwiftUI

public struct TabBarView<Content: View>: View {
    @StateObject var coordinator: TabBarViewCoordinator
    let content: Content

    public init(coordinator: TabBarViewCoordinator,
                content: () -> Content) {
        _coordinator = StateObject(wrappedValue: coordinator)
        self.content = content()
    }

    public var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            content
        }
    }
}
