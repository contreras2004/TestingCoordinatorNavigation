//
//  Views.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 02-08-22.
//

import Foundation
import Login
import Navigation
import SwiftUI
import Theme
import UI

public class View1ViewModel: BaseViewModel {
    override public var title: String { "View 1" }
    override public var iconForTab: String { "square.and.arrow.up.circle" }
    /*override public var viewModelForModal: BaseViewModel? {
        View3ViewModel(coordinator: self.coordinator)
    }*/
}
struct View1: View {
    @ObservedObject var viewModel: View1ViewModel
    var namespace: Namespace.ID

    var body: some View {
        ZStack {
            Color.teal
            VStack {
                Text("Hola").matchedGeometryEffect(id: "texto", in: namespace)
                Text("This is \(viewModel.title)")
                if let tabBarCoordinator = viewModel.coordinator.tabBarCoordinator {
                    Text("In Tab \(tabBarCoordinator.selectedTabIndex)")
                }
                if let index = viewModel.coordinator.indexFor(viewModel: self.viewModel) {
                    Text("and this is the element  \(index) in the navigation stack")
                }
                LargeButton(text: "Go To Second Page 2️⃣") {
                    viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.goToSecondPage)
                }
            }.multilineTextAlignment(.center)
                .padding()
        }
    }
}

class View2ViewModel: BaseViewModel {
    override var title: String { "View 2" }
    override var iconForTab: String { "info" }
    override var navigationButtonIcon: String? { "info.circle.fill" }
    /*override var viewModelForModal: BaseViewModel? {
        View3ViewModel(coordinator: self.coordinator)
    }*/
    override var actionForNavigationButton: (() -> Void) {
        {
            self.coordinator.viewModelForModal = InfoViewModel(coordinator: self.coordinator)
            self.coordinator.handle(event: LoginEvents.showModal)
        }
    }
}
struct View2: View {
    @ObservedObject var viewModel: View2ViewModel
    var body: some View {
        ZStack {
            Color.gray
            VStack {
                Spacer()
                Text("This is \(viewModel.title)")
                if let tabBarCoordinator = viewModel.coordinator.tabBarCoordinator {
                    Text("In Tab \(tabBarCoordinator.selectedTabIndex)")
                }
                if let index = viewModel.coordinator.indexFor(viewModel: self.viewModel) {
                    Text("and this is the element  \(index) in the navigation stack")
                }
                VStack {
                    LargeButton(text: "Go To Third Page 3️⃣") {
                        viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.goToThirdPage)
                    }
                    if viewModel.coordinator.tabBarCoordinator != nil {
                        LargeButton(text: "Change to second Tab ➡️") {
                            viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.goToTab(index: 1))
                        }
                        LargeButton(text: "Change to First Tab ⬅️") {
                            viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.goToTab(index: 0))
                        }
                    }
                }.padding()
                Spacer()
            }
        }
    }
}

class View3ViewModel: BaseViewModel {
    override var title: String { "View 3" }
}
struct View3: View {
    @ObservedObject var viewModel: View3ViewModel
    var body: some View {
        ZStack {
            Color.red
            VStack {
                Text("This is \(viewModel.title)")
                if let tabBarCoordinator = viewModel.coordinator.tabBarCoordinator {
                    Text("In Tab \(tabBarCoordinator.selectedTabIndex)")
                }
                if let index = viewModel.coordinator.indexFor(viewModel: self.viewModel) {
                    Text("and this is the element  \(index) in the navigation stack")
                }
                LargeButton(text: "Go to Root 🏁") {
                    viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.goToRoot)
                }
                LargeButton(text: "Go to another instance of View1 1️⃣") {
                    viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.goToFirstPage)
                }
                LargeButton(text: "Logout 🚪") {
                    viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.logout)
                }
            }.padding()
        }
    }
}
