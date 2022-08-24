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
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)

                        VStack(alignment: .leading, content: {
                            Text(notification.title)
                                .font(.headline)
                            Text(notification.message)
                                .font(.footnote)
                                .lineLimit(1)
                        })
                    }
                    .padding(.all, 2)
                    .onTapGesture {
                        let viewModel = NotificationDetailsViewModel(notification: notification)
                        viewModel.coordinator = self.viewModel.coordinator
                        viewModel.coordinator.handle(event: NotificationsEvents.goToNotification(viewModel: viewModel))
                    }
                }
                .onDelete { notification in
                    viewModel.removeNotification(at: notification)
                }
            }
            .refreshable {
                viewModel.state = await viewModel.fetchNotifications()
            }.onAppear {
                UIRefreshControl.appearance().backgroundColor = .white
            }
            .listStyle(.plain)
            .toolbar {
                EditButton()
            }
        case .withError:
            Text(L10n.error)
            DefaultButton(text: L10n.reload, style: .onlyText) {
                viewModel.state = await viewModel.fetchNotifications()
            }
        case .loading:
            ActivityIndicator(isAnimating: .constant(true), style: .medium)
        }
    }
}
