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

    deinit {
        debugPrint("\(self) has been deinitialized")
    }
}
struct View1: View {
    @ObservedObject var viewModel: View1ViewModel

    var body: some View {
        ZStack {
            Color.teal
            VStack {
                Circle()
                    .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.4))
                    .frame(width: 40 * CGFloat(self.viewModel.coordinator.path.count + 1))
                Text("This is \(viewModel.title)")
                if let tabBarCoordinator = viewModel.coordinator.tabBarCoordinator {
                    Text("In Tab \(tabBarCoordinator.selectedTabIndex)")
                }
                if let index = viewModel.coordinator.indexFor(viewModel: self.viewModel) {
                    Text("and this is the element  \(index) in the navigation stack")
                }
                DefaultButton(text: "Go To Second Page 2️⃣") {
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
                Circle()
                    .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.4))
                    .frame(width: 40 * CGFloat(self.viewModel.coordinator.path.count + 1))
                Text("This is \(viewModel.title)")
                if let tabBarCoordinator = viewModel.coordinator.tabBarCoordinator {
                    Text("In Tab \(tabBarCoordinator.selectedTabIndex)")
                }
                if let index = viewModel.coordinator.indexFor(viewModel: self.viewModel) {
                    Text("and this is the element  \(index) in the navigation stack")
                }
                VStack {
                    DefaultButton(text: "Go To Third Page 3️⃣") {
                        viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.goToThirdPage)
                    }
                    if viewModel.coordinator.tabBarCoordinator != nil {
                        DefaultButton(text: "Change to second Tab ➡️") {
                            viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.goToTab(index: 1))
                        }
                        DefaultButton(text: "Change to First Tab ⬅️") {
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

    deinit {
        debugPrint("\(self) has been deinitialized")
    }
}
struct View3: View {
    @ObservedObject var viewModel: View3ViewModel
    var body: some View {
        ZStack {
            Color.red
            VStack {
                Circle()
                    .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.4))
                    .frame(width: 40 * CGFloat(self.viewModel.coordinator.path.count + 1))
                Text("This is \(viewModel.title)")
                if let tabBarCoordinator = viewModel.coordinator.tabBarCoordinator {
                    Text("In Tab \(tabBarCoordinator.selectedTabIndex)")
                }
                if let index = viewModel.coordinator.indexFor(viewModel: self.viewModel) {
                    Text("and this is the element  \(index) in the navigation stack")
                }
                DefaultButton(text: "Go to Root 🏁") {
                    viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.goToRoot)
                }
                DefaultButton(text: "Go to another instance of View1 1️⃣") {
                    viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.goToFirstPage)
                }
                DefaultButton(text: "Remove previouse view from stack") {
                    viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.removePreviouseViewFromStack)
                }
                DefaultButton(text: "Logout 🚪") {
                    viewModel.coordinator.handle(event: MainNavigationCoordinatorEvent.logout)
                }
            }.padding()
        }
    }
}
