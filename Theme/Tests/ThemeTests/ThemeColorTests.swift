//
//  ThemeColorTests.swift
//  
//
//  Created by m.contreras.selman on 24-08-22.
//

import Foundation
import Nimble
import Quick
import SwiftUI

@testable import Theme

final class ThemeColorTests: QuickSpec {
    override func spec() {
        describe("ThemeColor") {
            context("primaryAccent") {
                it("should be") {
                    expect(ThemeColor.primaryAccent.swiftUIColor) == Color("PrimaryAccent", bundle: Bundle.module)

                    expect(ThemeColor.primaryAccent.name) == "PrimaryAccent"
                }
            }
        }
    }
}
