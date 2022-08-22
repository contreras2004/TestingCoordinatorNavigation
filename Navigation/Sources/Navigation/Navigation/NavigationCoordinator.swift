//
//  NavigationCoordinator.swift
//  
//
//  Created by m.contreras.selman on 03-08-22.
//

import Foundation
import SwiftUI

public protocol NavigationCoordinatorEvent { }

public protocol NavigationCoordinatorProtocol {
    var tabBarCoordinator: TabBarViewCoordinator? { get set }
    var path: [BaseViewModel] { get set }
}

open class NavigationCoordinator: ObservableObject, NavigationCoordinatorProtocol {
    public weak var tabBarCoordinator: TabBarViewCoordinator?

    @Published public var viewModelForModal: BaseViewModel?

    @Published public var path: [BaseViewModel] = []

    public func indexFor(viewModel: BaseViewModel) -> Int? {
        path.firstIndex(where: { $0 == viewModel })
    }

    public init(tabBarCoordinator: TabBarViewCoordinator? = nil) {
        self.tabBarCoordinator = tabBarCoordinator
    }

    open func handle(event: NavigationCoordinatorEvent) { }
}
