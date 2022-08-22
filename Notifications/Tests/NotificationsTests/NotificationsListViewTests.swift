//
//  NotificationsListViewTests.swift
//  
//
//  Created by m.contreras.selman on 22-08-22.
//

import Quick
import Nimble
import Nimble_Snapshots
import Navigation

@testable import Notifications


final class NotificationsListViewTests: QuickSpec {
    
    //var viewModel: NotificationsListViewModel!
    var sut: NotificationsListView!

    override func spec() {
        describe("NotificationsListView") {
            context("on init") {
                it("should have expected layout") {
                    let service = NotificationsServiceMock()
                    service.serviceState = .success
                    
                    let viewModel = NotificationsListViewModel(service: service, coordinator: NavigationCoordinator())
                    
                    self.sut = NotificationsListView(viewModel: viewModel)
                    expect(self.sut.view()) == snapshot()
                }
            }
        }
    }
}

