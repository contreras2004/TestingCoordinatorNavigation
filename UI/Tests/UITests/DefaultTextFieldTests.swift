//
//  DefaultTextField.swift
//  
//
//  Created by m.contreras.selman on 24-08-22.
//

import Foundation
import Nimble
import Nimble_Snapshots
import Quick
import SwiftUI
import TestUtils

@testable import UI

final class DefaultTextFieldTests: QuickSpec {
    var sut: DefaultTextField!

    override func spec() {
        describe("DefaultTextField") {
                        
            context("when init") {
                it("should have expected layout") {
                    self.sut = DefaultTextField(placeholder: "Placeholder")
                    expect(self.sut.view(width: 300, height: 100, colorScheme: .light)) == snapshot()
                }
                
                context("when filled") {
                    
                    it("should have expected layout") {
                        self.sut = DefaultTextField(placeholder: "Placeholder", value: .constant("This is the value"))
                        expect(self.sut.view(width: 300, height: 100, colorScheme: .light)) == snapshot()
                    }
                    
                    context("when error") {
                        
                        it("should have expected layout") {
                            self.sut = DefaultTextField(placeholder: "Placeholder", value: .constant("This is the value"), errorMessage: .constant("This is an error message"))
                            expect(self.sut.view(width: 300, height: 100, colorScheme: .light)) == snapshot()
                        }
                        
                    }
                    
                }
            }
            
            context("when init as secure textfield") {
                it("should have expected layout when filled") {
                    self.sut = DefaultTextField(
                        placeholder: "Placeholder",
                        isSecure: true,
                        value: .constant("This is the value"),
                        errorMessage: .constant("This is an error message"))
                    expect(self.sut.view(width: 300, height: 100, colorScheme: .light)) == snapshot()
                }
            }
        }
    }
}
