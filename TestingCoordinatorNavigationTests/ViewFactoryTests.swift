//
//  TestingCoordinatorNavigationTests.swift
//  TestingCoordinatorNavigationTests
//
//  Created by m.contreras.selman on 05-08-22.
//

import SwiftUI
import Nimble
import Quick
import SnapshotTesting
import Navigation

@testable import TestingCoordinatorNavigation

final class ViewFactoryTests: QuickSpec {
    override func spec() {
        describe("ViewFactory") {
            
            context("view 1") {
                it("should have expected layout") {
                    let viewModel = View1ViewModel()
                    let view = ViewFactory(viewModel: viewModel)
                    assertSnapshot(matching: view, as: .image, record: false)
                }
            }
            
            context("view 2") {
                it("should have expected layout") {
                    let viewModel = View2ViewModel()
                    let view = ViewFactory(viewModel: viewModel)
                    assertSnapshot(matching: view, as: .image, record: false)
                }
            }
            
            context("view 3") {
                it("should have expected layout") {
                    let viewModel = View3ViewModel()
                    let view = ViewFactory(viewModel: viewModel)
                    assertSnapshot(matching: view, as: .image, record: false)
                }
            }
        }
    }
}
