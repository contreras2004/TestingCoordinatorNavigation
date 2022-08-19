import SwiftUI

public extension View {
    func view(width: CGFloat? = nil, height: CGFloat? = nil, colorScheme: ColorScheme? = nil) -> UIView {
        let viewController = UIHostingController(rootView: self.environment(\.colorScheme, colorScheme ?? .light))
        viewController._disableSafeArea = true

        let calculatedSize = width.map {
            viewController.view.sizeThatFits(
                CGSize(width: $0, height: height ?? CGFloat.greatestFiniteMagnitude))
        } ?? UIScreen.main.bounds.size

        let window = UIWindow(frame: CGRect(origin: .zero, size: calculatedSize))
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        window.backgroundColor = colorScheme == .light ? .white : .black

        return viewController.view
    }

    func window(sizeThatFitsWidth width: CGFloat? = nil, colorScheme: ColorScheme? = nil) -> UIWindow {
        let viewController = UIHostingController(rootView: self.environment(\.colorScheme, colorScheme ?? .light))
        viewController._disableSafeArea = true
        viewController.view.backgroundColor = colorScheme == .light ? .white : .black

        let calculatedSize = width.map {
            viewController.view.sizeThatFits(CGSize(width: $0, height: CGFloat.greatestFiniteMagnitude))
        } ?? UIScreen.main.bounds.size

        let window = UIWindow(frame: CGRect(origin: .zero, size: calculatedSize))
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        return window
    }
}
