//
//  BannerModifier.swift
//  
//
//  Created by m.contreras.selman on 11-08-22.
//

import SwiftUI

public class BannerData {
    public enum BannerType {
        case warning, error, success

        var textColor: Color {
            switch self {
            case .warning:
                return .black
            case .error:
                return .white
            case .success:
                return .white
            }
        }

        var backgroundColor: Color {
            switch self {
            case .warning:
                return .yellow
            case .error:
                return .red
            case .success:
                return .green
            }
        }

        var icon: String {
            switch self {
            case .warning:
                return "exclamationmark.triangle.fill"
            case .error:
                return "exclamationmark.circle.fill"
            case .success:
                return "checkmark.circle.fill"
            }
        }
    }

    let type: BannerType
    let title: String
    let message: String?
    let autoDismiss: Bool
    let autoDismissSeconds: Int

    public init(
        title: String,
        message: String? = nil,
        type: BannerType = .success,
        autoDismiss: Bool = true,
        autoDismissSeconds: Int = 3
    ) {
        self.title = title
        self.message = message
        self.type = type
        self.autoDismiss = autoDismiss
        self.autoDismissSeconds = autoDismissSeconds
    }
}

public struct BannerModifier: ViewModifier {
    @Binding var model: BannerData?

    public init(model: Binding<BannerData?>) {
        _model = model
    }

    public func body(content: Content) -> some View {
        content.overlay(
            VStack {
                if model != nil {
                    VStack {
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: model?.type.icon ?? BannerData.BannerType.success.icon)
                                .foregroundColor(model?.type.textColor)
                            VStack(alignment: .leading) {
                                Text(model?.title ?? "")
                                    .font(.headline)
                                    .foregroundColor(model?.type.textColor)
                                if let message = model?.message {
                                    Text(message)
                                        .font(.footnote)
                                        .foregroundColor(model?.type.textColor)
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(model?.type.backgroundColor ?? .clear)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        Spacer()
                    }
                    .padding()
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    .onTapGesture {
                        withAnimation {
                            model = nil
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { _ in
                                withAnimation {
                                    model = nil
                                }
                            }
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            model = nil
                        }
                    }
                }
            }
            .animation(.spring())
        )
    }
}
