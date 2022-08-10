//
//  InfoViewTests.swift
//  TestingCoordinatorNavigationTests
//
//  Created by m.contreras.selman on 05-08-22.
//

import Navigation
import Nimble
import Nimble_Snapshots
import Quick
import SwiftUI
import TestUtils

@testable import Login

final class InfoViewTests: QuickSpec {
    var window: UIWindow!
    var viewModel: InfoViewModel!
    var sut: InfoView!

    override func spec() {
        describe("InfoView") {
            context("on init") {
                it("should have expected layout") {
                    self.viewModel = InfoViewModel()
                    self.sut = InfoView(viewModel: self.viewModel)
                    expect(self.sut.view()) == recordSnapshot()
                }
            }
        }
    }
}
