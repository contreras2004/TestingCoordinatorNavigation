//
//  NavigationView.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 01-08-22.
//

import Foundation
import SwiftUI

public struct Navigation<ViewFactory: ViewFactoryProtocol>: View {
    @ObservedObject var coordinator: NavigationCoordinator
    let viewFactory: ViewFactory
    let viewModel: BaseViewModel

    public init(viewModel: BaseViewModel,
                @ViewBuilder viewFactory: () -> ViewFactory) {
        self.coordinator = viewModel.coordinator
        self.viewFactory = viewFactory()
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            viewFactory
                .modified(viewModel: viewModel)
            .navigationDestination(for: BaseViewModel.self) { viewModel in
                viewFactory.viewFor(viewModel: viewModel)
                    .modified(viewModel: viewModel)
            }
            /*.sheet(isPresented: $viewModel.isShowingModal) {
                if let modalVM = viewModel.viewModelForModal {
                    viewFactory.viewFor(viewModel: modalVM)
                } else {
                    Text("No modal defined for this view")
                }
            }*/
        }.tabItem {
            Label(viewModel.title, systemImage: viewModel.iconForTab)
        }
        .tag(viewModel.id)
    }
}
