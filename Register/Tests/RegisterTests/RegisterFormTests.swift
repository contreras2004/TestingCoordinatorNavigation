//
//  RegisterFormTests.swift
//  
//
//  Created by m.contreras.selman on 11-08-22.
//

import Quick
import Nimble
import Nimble_Snapshots
import TestUtils

@testable import Register

final class RegisterFormTests: QuickSpec {
    var viewModel: RegisterFormViewModel!
    var sut: RegisterForm!

    override func spec() {
        
        beforeEach {
            self.viewModel = RegisterFormViewModel()
            self.sut = RegisterForm(viewModel: self.viewModel)
        }
        
        describe("RegisterForm") {
            context("on init") {
                it("should have expected layout") {
                    expect(self.sut.view()) == snapshot()
                }
            }
            
            context("after filling the data wrong") {
                it ("should have expected layout") {
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
                it ("should have expected layout") {
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
                it ("should have expected layout") {
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
