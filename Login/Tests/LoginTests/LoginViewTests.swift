//
//  LoginViewTests.swift
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

final class LoginViewTests: QuickSpec {
    var window: UIWindow!
    var viewModel: LoginViewModel!
    var sut: LoginView!

    override func spec() {
        describe("LoginView") {
            context("on init") {
                it("should have expected layout") {
                    self.viewModel = LoginViewModel()
                    self.sut = LoginView(viewModel: self.viewModel)
                    expect(self.sut.view(colorScheme: .light)) == snapshot()
                }

                context("when taped login") {
                    fit("should show error") {
                        let service = LoginServiceMock()
                        service.serviceState = .error
                        
                        self.viewModel = LoginViewModel()
                        self.viewModel.user = "11111111-1"
                        self.viewModel.pass = "111"
                        self.viewModel.service = service

                        self.viewModel.login()
                        expect(self.viewModel.isPresentingError).to(beTrue())
                    }
                }
                
                context("when taped login") {
                    it("should show loading") {
                        let service = LoginServiceMock()
                        service.serviceState = .noReturn

                        self.viewModel.user = "11111111-1"
                        self.viewModel.pass = "111"
                        self.viewModel.service = service

                        self.sut = LoginView(viewModel: self.viewModel)
                        self.viewModel.login()

                        expect(self.sut.view(colorScheme: .light)) == snapshot()
                    }
                }
            }
        }
    }
}
