//
//  NotificationDetailsViewTests.swift
//  
//
//  Created by m.contreras.selman on 22-08-22.
//

import Quick
import Nimble
import Nimble_Snapshots
import Navigation

@testable import Notifications


final class NotificationDetailsViewTests: QuickSpec {
    
    //var viewModel: NotificationsListViewModel!
    var sut: NotificationDetailsView!

    override func spec() {
        describe("NotificationDetailsView") {
            context("on init") {
                it("should have expected layout") {
                    let service = NotificationsServiceMock()
                    
                    let viewModel = NotificationDetailsViewModel(notificationId: 1, service: service)
                    
                    self.sut = NotificationDetailsView(viewModel: viewModel)
                    expect(self.sut.view()) == snapshot()
                }
            }
        }
    }
}

