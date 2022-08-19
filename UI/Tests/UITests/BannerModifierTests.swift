//
//  BannerModifierTests.swift
//  
//
//  Created by m.contreras.selman on 19-08-22.
//

import Foundation
import Nimble
import Nimble_Snapshots
import Quick
import SwiftUI
import TestUtils

@testable import UI

/*final class BannerModifierTests: QuickSpec {
    var sut: View = Text("Hola").frame(height: 400)
    @ObservedObject var dummyClass:DummyClass = DummyClass()
    
    override func spec() {
        /*beforeEach {
            sut = Text("Testing Banner")
        }*/
        
        describe("BannerModifier") {
            context("when applied to view") {
                it("should have expected layout") {
                    /*@Published var bannerData = BannerData(
                        title: "Testing",
                        message: "Error banner",
                        type: .error,
                        autoDismiss: false,
                        autoDismissSeconds: 0)*/
                    //var dummyClass = DummyClass()
                    
                    self.sut.modifier(BannerModifier(model: self.$dummyClass.bannerData))
                    expect(self.sut.view(sizeThatFitsWidth: 300, colorScheme: .light)) == recordSnapshot()
                }
            }
        }
    }
}*/

class DummyClass: ObservableObject {
    @Published var bannerData: BannerData? = BannerData(
        title: "Testing",
        message: "Error banner",
        type: .error,
        autoDismiss: false,
        autoDismissSeconds: 0)
}
