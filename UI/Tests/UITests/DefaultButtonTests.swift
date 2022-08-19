//
//  File.swift
//  
//
//  Created by m.contreras.selman on 19-08-22.
//

import SwiftUI
import Foundation
import Quick
import Nimble
import Nimble_Snapshots
import TestUtils

@testable import UI

final class DefaultButtonTests: QuickSpec {
    var sut: DefaultButton!
    
    override func spec() {
       
        describe("DefaultButton") {
            context("when init without specified params") {
                it("should have expected layout") {
                    self.sut = DefaultButton(text: "Testing")
                    expect(self.sut.view(width: 300,height: 100, colorScheme: .light)) == snapshot()
                }
            }
            
            context("when disabled") {
                it("should have expected layout") {
                    self.sut = DefaultButton(text: "Testing", isDisabled: .constant(true))
                    expect(self.sut.view(width: 300,height: 100, colorScheme: .light)) == snapshot()
                }
            }
            
            context("when loading") {
                it("should have expected layout") {
                    self.sut = DefaultButton(text: "Testing", isLoading: .constant(true))
                    expect(self.sut.view(width: 300,height: 100, colorScheme: .light)) == snapshot()
                }
            }
            
            context("when loading") {
                it("should have expected layout") {
                    self.sut = DefaultButton(text: "Testing", isLoading: .constant(true))
                    expect(self.sut.view(width: 300,height: 100, colorScheme: .light)) == snapshot()
                }
            }
            
            context("when loading") {
                it("should have expected layout") {
                    self.sut = DefaultButton(text: "Testing", style: .onlyText)
                    expect(self.sut.view(width: 300,height: 100, colorScheme: .light)) == snapshot()
                }
            }
        }
    }
}
