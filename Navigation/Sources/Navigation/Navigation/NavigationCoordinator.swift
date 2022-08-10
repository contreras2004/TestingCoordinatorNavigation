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
    public weak var rootViewModel: BaseViewModel?

    @Published public var isShowingModal = false

    public var viewModelForModal: BaseViewModel?

    public weak var tabBarCoordinator: TabBarViewCoordinator?

    @Published public var path: [BaseViewModel] = [] { didSet { debugPrint(path) } }

    public func indexFor(viewModel: BaseViewModel) -> Int? {
        path.firstIndex(where: { $0 == viewModel })
    }

    public init(tabBarCoordinator: TabBarViewCoordinator? = nil) {
        self.tabBarCoordinator = tabBarCoordinator
    }

    open func handle(event: NavigationCoordinatorEvent) { }
}
