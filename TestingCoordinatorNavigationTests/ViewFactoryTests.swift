//
//  TestingCoordinatorNavigationTests.swift
//  TestingCoordinatorNavigationTests
//
//  Created by m.contreras.selman on 05-08-22.
//

import SwiftUI
import Nimble
import Quick
import Navigation
import Nimble_Snapshots
import TestUtils

@testable import TestingCoordinatorNavigation

final class ViewFactoryTests: QuickSpec {
    override func spec() {
        describe("ViewFactory") {

            context("view 1") {
                it("should have expected layout") {
                    let viewModel = View1ViewModel()
                    let view = ViewFactory(viewModel: viewModel)
                    expect(view.view()) == snapshot()
                }
            }

            context("view 2") {
                it("should have expected layout") {
                    let viewModel = View2ViewModel()
                    let view = ViewFactory(viewModel: viewModel)
                    expect(view.view()) == snapshot()
                }
            }

            context("view 3") {
                it("should have expected layout") {
                    let viewModel = View3ViewModel()
                    let view = ViewFactory(viewModel: viewModel)
                    expect(view.view()) == snapshot()
                }
            }
        }
    }
}
