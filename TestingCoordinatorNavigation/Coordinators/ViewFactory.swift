//
//  ChildView.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 01-08-22.
//

import Foundation
import Login
import Navigation
import Notifications
import Register
import SwiftUI

public struct ViewFactory: ViewFactoryProtocol {
    public var viewModel: BaseViewModel

    public var body: some View {
        viewFor(viewModel: viewModel)
    }

    @ViewBuilder
    public func viewFor(viewModel: BaseViewModel) -> some View {
        switch viewModel {
        // MARK: Login Module
        case let viewModel as LoginViewModel:
            LoginView(viewModel: viewModel)
        case let viewModel as InfoViewModel:
            InfoView(viewModel: viewModel)

        // MARK: Register Module
        case let viewModel as RegisterFormViewModel:
            RegisterFormView(viewModel: viewModel)

        // MARK: Notifications Module
        case let viewModel as NotificationsListViewModel:
            NotificationsListView(viewModel: viewModel)
        case let viewModel as NotificationDetailsViewModel:
            NotificationDetailsView(viewModel: viewModel)

        // MARK: Other Screens
        case let viewModel as View1ViewModel:
            View1(viewModel: viewModel)
        case let viewModel as View2ViewModel:
            View2(viewModel: viewModel)
        case let viewModel as View3ViewModel:
            View3(viewModel: viewModel)

        default:
            Text("ViewModel not recognized")
        }
    }
}
