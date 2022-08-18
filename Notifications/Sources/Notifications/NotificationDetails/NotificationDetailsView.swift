//
//  NotificationDetailsView.swift
//  
//
//  Created by m.contreras.selman on 18-08-22.
//

import Foundation
import SwiftUI

public struct NotificationDetailsView: View {
    @ObservedObject var viewModel: NotificationDetailsViewModel

    public init(viewModel: NotificationDetailsViewModel) {
        self.viewModel = viewModel
    }

    let imageHeight: CGFloat = 180

    public var body: some View {
        ScrollView {
             VStack {
                 if let notification = viewModel.notification {
                     AsyncImage(url: notification.image) { image in
                         ZStack {
                             image
                                 .resizable()
                                 .aspectRatio(contentMode: .fill)
                                 .frame(maxWidth: .infinity, maxHeight: imageHeight)
                                 .blur(radius: 4)
                                 .clipped()
                             image
                                 .resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(maxWidth: .infinity, maxHeight: imageHeight)
                                 .padding()
                         }
                     } placeholder: {
                         ZStack {
                             Color.black
                             ProgressView()
                                 .frame(maxWidth: .infinity, minHeight: imageHeight)
                                 .padding()
                         }
                     }

                     Text(notification.title)
                         .frame(maxWidth: .infinity, alignment: .leading)
                         .padding()
                     Text(notification.message)
                         .frame(maxWidth: .infinity, alignment: .leading)
                         .padding([.leading, .trailing])

                    Spacer()
                 } else {
                     ZStack {
                         Color.black
                         ProgressView()
                             .frame(maxWidth: .infinity, minHeight: imageHeight)
                             .padding()
                     }
                 }
             }
        }
    }
}
