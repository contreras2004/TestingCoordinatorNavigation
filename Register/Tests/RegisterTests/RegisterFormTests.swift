//
//  RegisterFormTests.swift
//  
//
//  Created by m.contreras.selman on 11-08-22.
//

import Nimble
import Nimble_Snapshots
import Quick
import TestUtils

@testable import Register

final class RegisterFormViewTests: QuickSpec {
    var viewModel: RegisterFormViewModel!
    var sut: RegisterFormView!

    override func spec() {
        beforeEach {
            self.viewModel = RegisterFormViewModel()
            self.sut = RegisterFormView(viewModel: self.viewModel)
        }

        describe("RegisterFormView") {
            context("on init") {
                it("should have expected layout") {
                    expect(self.sut.view()) == snapshot()
                }
            }

            context("after filling the data wrong") {
                it("should have expected layout") {
                    self.viewModel.userName = "Matias Contreras"
                    self.viewModel.email = "wrong email"
                    self.viewModel.password = "123"
                    self.viewModel.repeatPassword = "456"
                    self.viewModel.acceptedTC = true
                    self.viewModel.register()
                    expect(self.sut.view()) == snapshot()
                }
            }

            context("after correcting the email") {
                it("should have expected layout") {
                    self.viewModel.userName = "Matias Contreras"
                    self.viewModel.email = "asd@asd.com"
                    self.viewModel.password = "123"
                    self.viewModel.repeatPassword = "456"
                    self.viewModel.acceptedTC = true
                    self.viewModel.register()
                    expect(self.sut.view()) == snapshot()
                }
            }

            context("after correcting the passwords") {
                it("should have expected layout") {
                    self.viewModel.userName = "Matias Contreras"
                    self.viewModel.email = "asd@asd.com"
                    self.viewModel.password = "123"
                    self.viewModel.repeatPassword = "123"
                    self.viewModel.acceptedTC = true
                    self.viewModel.register()
                    expect(self.sut.view()) == snapshot()
                }
            }
        }
    }
}
