//
//  TabBarViewCoordinator.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 01-08-22.
//

import Foundation
import SwiftUI

public protocol TabBarCoordinatorEvent { }

open class TabBarViewCoordinator: ObservableObject {
    public var selectedTabIndex: Int {
        tabs.firstIndex(where: { $0.id == selectedTab }) ?? 0
    }

    @Published public var tabs: [BaseViewModel] = []
    @Published public var selectedTab: UUID

    public init(viewModels: [BaseViewModel] = [], selectedTab: UUID = UUID()) {
        self.tabs = viewModels
        self.selectedTab = selectedTab
    }

    open func handle(event: TabBarCoordinatorEvent) { }

    func goToTab(index: Int) {
        self.selectedTab = tabs[index].id
    }
}
