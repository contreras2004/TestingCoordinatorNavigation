//
//  NotificationsListView.swift
//  Tolls
//
//  Created by Matias Contreras on 12-07-22.
//

import Navigation
import SwiftUI
import Theme
import UI

public struct NotificationsListView: View {
    @ObservedObject var viewModel: NotificationsListViewModel

    public init(viewModel: NotificationsListViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        switch viewModel.state {
        case .withData(let notifications):
            List {
                ForEach(notifications, id: \.id) { notification in
                    HStack {
                        Image(systemName: "person.circle")
                        Text(notification.message)
                        Spacer()
                    }
                }
                .onDelete { notification in
                    viewModel.removeNotification(at: notification)
                }
            }.refreshable {
                viewModel.getNotifications()
            }.toolbar {
                EditButton()
            }
        case .withError:
            Text(L10n.error)
            DefaultButton(text: L10n.reload, style: .onlyText) {
                viewModel.getNotifications()
            }
        case .loading:
            ActivityIndicator(isAnimating: .constant(true), style: .medium)
        }
    }
}
