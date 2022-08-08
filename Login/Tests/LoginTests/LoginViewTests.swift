//
//  LoginViewTests.swift
//  TestingCoordinatorNavigationTests
//
//  Created by m.contreras.selman on 05-08-22.
//

import Navigation
import Nimble
import Quick
import SnapshotTesting
import SnapshotTesting_Nimble
import SwiftUI

@testable import Login

final class LoginViewTests: QuickSpec {
    var window: UIWindow!
    var viewModel: LoginViewModel!
    //var view: any View?
    var sut = LoginView(viewModel: LoginViewModel())

    override func spec() {
        describe("LoginView") {
            context("on init") {
                it("should have expected layout") {
                    self.viewModel = LoginViewModel()
                    let view = LoginView(viewModel: self.viewModel).withSize(SnapshotSize.iPhone13Pro)
                    expect(view).to(haveValidSnapshot(as: .image, record: false))
                }

                context("when taped login") {
                    it("should show loading") {
                        let service = LoginServiceMock()
                        service.serviceState = .noReturn

                        self.viewModel.user = "11111111-1"
                        self.viewModel.pass = "111"
                        self.viewModel.service = service

                        let view = LoginView(viewModel: self.viewModel).withSize(SnapshotSize.iPhone13Pro)
                        self.viewModel.login()
                        expect(view).to(haveValidSnapshot(as: .image, record: false))
                    }
                }

                context("when taped login") {
                    it("should show error alert") {
                        let service = LoginServiceMock()
                        service.serviceState = .error

                        self.viewModel.user = "11111111-1"
                        self.viewModel.pass = "111"
                        self.viewModel.service = service

                        self.viewModel.login()
                        expect(self.viewModel.isPresentingError).to(beTrue())
                    }
                }
            }
        }
    }
}

public enum SnapshotSize {
    static var iPhone13Pro = CGSize(width: 390, height: 844)
}

public extension View {
    func withSize(_ size: CGSize) -> some View {
        frame(width: size.width, height: size.height)
    }
}

public extension UIWindow {
    static func deviceFrame() -> UIWindow {
        UIWindow(frame: UIScreen.main.bounds)
    }

    func showTestWindow(controller: UIViewController) {
        self.rootViewController = controller
        self.makeKeyAndVisible()
    }

    func cleanTestWindow() {
        self.rootViewController = nil
        self.isHidden = true
    }
}
