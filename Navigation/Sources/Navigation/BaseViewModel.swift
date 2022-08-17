//
//  BaseViewModel.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 01-08-22.
//

import Foundation
import SwiftUI

public protocol ViewModelProtocol: ObservableObject, Identifiable, Hashable {
    var id: UUID { get }
    var title: String { get }
    var iconForTab: String { get }
    var coordinator: NavigationCoordinator { get set }
    //var viewModelForModal: (any ViewModelProtocol)? { get }
}

//@MainActor
open class BaseViewModel: ViewModelProtocol, ObservableObject {
    public var id = UUID()
    open var title: String { "Title not set" }
    open var iconForTab: String { "xmark" }

    open var navigationButtonIcon: String? { nil }
    open var actionForNavigationButton: () -> Void { {} }
    open var navigationButtonIconColor: Color { .blue }

    open var coordinator: NavigationCoordinator
    /// Init method for the BaseViewModel
    /// - Parameter coordinator: Will set the passed coordinator.
    /// WARNING: A default coordinator will be assigned if not passed
    public init(coordinator: NavigationCoordinator = NavigationCoordinator(tabBarCoordinator: nil)) {
        // _coordinator = Published(wrappedValue: coordinator)
        self.coordinator = coordinator
    }

    public static func == (lhs: BaseViewModel, rhs: BaseViewModel) -> Bool { lhs.id == rhs.id }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public func setNavigationBarColor(color: UIColor) {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: color]
        navBarAppearance.titleTextAttributes = [.foregroundColor: color]
    }
}
