//
//  ViewFactoryProtocol.swift
//  TestingCoordinatorNavigation
//
//  Created by m.contreras.selman on 02-08-22.
//

import Foundation
import SwiftUI

public protocol ViewFactoryProtocol: View {
    associatedtype Content: View

    var viewModel: BaseViewModel { get set }

    func viewFor(viewModel: BaseViewModel) -> Content
}

struct ViewFactoryModifier: ViewModifier {
    let viewModel: BaseViewModel

    init(viewModel: BaseViewModel) {
        self.viewModel = viewModel
    }

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    HStack {
                            Text(viewModel.title)
                                .fixedSize()
                                .font(.headline)
                                .foregroundColor(viewModel.navigationTitleColor)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(1)
                                .accessibilityAddTraits(.isHeader)
                    }
                }
                if let iconName = viewModel.navigationButtonIcon {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.actionForNavigationButton()
                        } label: {
                            Image(systemName: iconName).foregroundColor(viewModel.navigationButtonIconColor)
                        }
                    }
                }
            })
    }
}

extension View {
    func modified(viewModel: BaseViewModel) -> some View {
        modifier(ViewFactoryModifier(viewModel: viewModel))
    }
}
