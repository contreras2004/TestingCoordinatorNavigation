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

final class BannerModifierTests: QuickSpec {
        
    override func spec() {
        describe("BannerModifier") {
            context("when applied to view") {
                it("should have expected layout with only title") {
                    let view = Text("")
                        .frame(width: 300, height: 100)
                        .modifier(BannerModifier(
                            model: .constant(BannerData(title: "Hola"))))
                    expect(view.view(width: 300, height: 100)) == snapshot()
                }
                
                it("should have expected layout with title and subtitle") {
                    let view = Text("")
                        .frame(width: 300, height: 100)
                        .modifier(BannerModifier(
                            model: .constant(BannerData(
                                title: "Hola",
                                message: "Este es el mensaje"
                            ))))
                    expect(view.view(width: 300, height: 100)) == snapshot()
                }
                
                it("should have expected layout when type is Warning") {
                    let view = Text("")
                        .frame(width: 300, height: 100)
                        .modifier(BannerModifier(
                            model: .constant(BannerData(
                                title: "Hola",
                                message: "Este es el mensaje",
                                type: .warning
                            ))))
                    expect(view.view(width: 300, height: 100)) == snapshot()
                }
                
                it("should have expected layout when type is Error") {
                    let view = Text("")
                        .frame(width: 300, height: 100)
                        .modifier(BannerModifier(
                            model: .constant(BannerData(
                                title: "Hola",
                                message: "Este es el mensaje",
                                type: .error
                            ))))
                    expect(view.view(width: 300, height: 100)) == snapshot()
                }
            }
        }
    }
}
