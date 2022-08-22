//
//  NavigationView.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 01-08-22.
//

import Foundation
import SwiftUI

public struct Navigation<ViewFactory: ViewFactoryProtocol>: View {
    let viewFactory: ViewFactory
    @ObservedObject var coordinator: NavigationCoordinator
    @ObservedObject var viewModel: BaseViewModel

    public init(viewModel: BaseViewModel,
                @ViewBuilder viewFactory: () -> ViewFactory) {
        self.coordinator = viewModel.coordinator
        self.viewFactory = viewFactory()
        self.viewModel = viewModel
    }

    public var body: some View {
        Self._printChanges()
        return NavigationStack(path: $coordinator.path) {
            viewFactory.modified(viewModel: viewModel)
            .navigationDestination(for: BaseViewModel.self) { innerVM in
                viewFactory.viewFor(viewModel: innerVM).modified(viewModel: innerVM)
            }
        }
        .tabItem {
            Label(viewModel.title, systemImage: viewModel.iconForTab)
        }
        .tag(viewModel.id)
        .sheet(item: $coordinator.viewModelForModal, content: { innerVM in
            viewFactory.viewFor(viewModel: innerVM).modified(viewModel: innerVM)
        })
    }
}
