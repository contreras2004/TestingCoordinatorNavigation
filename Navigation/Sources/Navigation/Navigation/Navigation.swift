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
    @ObservedObject var viewModel: BaseViewModel //this is the root viewModel

    public init(viewModel: BaseViewModel,
                @ViewBuilder viewFactory: () -> ViewFactory) {
        self.coordinator = viewModel.coordinator
        self.viewFactory = viewFactory()
        self.viewModel = viewModel
        self.coordinator.rootViewModel = viewModel
    }

    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            viewFactory
                .modified(viewModel: viewModel)
            .navigationDestination(for: BaseViewModel.self) { viewModel in
                viewFactory.viewFor(viewModel: viewModel)
                    .modified(viewModel: viewModel)
            }
            /*.sheet(item: $coordinator.rootViewModel, content: { viewModel in
                if let modalVM = viewModel.viewModelForModal {
                    viewFactory.viewFor(viewModel: viewModel)
                        .modified(viewModel: viewModel)
                } else {
                    Text("❌ No modal defined for this view \n remember to override \"viewModelForModal\"")
                }
            })*/
        }.tabItem {
            Label(viewModel.title, systemImage: viewModel.iconForTab)
        }
        .tag(viewModel.id)
        .sheet(isPresented: $coordinator.isShowingModal) {
            if let modalVm = self.coordinator.viewModelForModal {
                viewFactory.viewFor(viewModel: modalVm)
            } else {
                Text("❌ No modal defined for this view \n remember to override \"viewModelForModal\"")
            }
        }
    }
}
