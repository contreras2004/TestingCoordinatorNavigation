import SwiftUI

public extension View {
    func view(sizeThatFitsWidth width: CGFloat? = nil, colorScheme: ColorScheme? = nil) -> UIView {
        let vc = UIHostingController(rootView: self.environment(\.colorScheme, colorScheme ?? .light))
        vc._disableSafeArea = true

        let calculatedSize = width.map { vc.view.sizeThatFits(CGSize(width: $0, height: CGFloat.greatestFiniteMagnitude)) } ?? UIScreen.main.bounds.size

        let window = UIWindow(frame: CGRect(origin: .zero, size: calculatedSize))
        window.rootViewController = vc
        window.makeKeyAndVisible()
        window.backgroundColor = colorScheme == .light ? .white : .black

        return vc.view
    }

    func window(sizeThatFitsWidth width: CGFloat? = nil, colorScheme: ColorScheme? = nil) -> UIWindow {
        let vc = UIHostingController(rootView: self.environment(\.colorScheme, colorScheme ?? .light))
        vc._disableSafeArea = true
        vc.view.backgroundColor = colorScheme == .light ? .white : .black

        let calculatedSize = width.map { vc.view.sizeThatFits(CGSize(width: $0, height: CGFloat.greatestFiniteMagnitude)) } ?? UIScreen.main.bounds.size

        let window = UIWindow(frame: CGRect(origin: .zero, size: calculatedSize))
        window.rootViewController = vc
        window.makeKeyAndVisible()

        return window
    }
}
