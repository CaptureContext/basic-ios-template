import AppUI
import SwiftUI

extension UIApplication {
	fileprivate static var initialViewController: () -> UIViewController = { UIViewController() }

	@MainActor
	public func launchPreview<Content: View>(
		of content: Content,
		setup: @escaping (UIViewController) -> Void = { _ in },
		appDelegate: UIApplicationDelegate = MainActor.assumeIsolated { AppDelegate() }
	) {
		UIApplication.initialViewController = {
			let controller = UIHostingController(rootView: content)
			setup(controller)
			return controller
		}

		UIApplication.shared.delegate = appDelegate

		_ = UIApplicationMain(
			CommandLine.argc,
			CommandLine.unsafeArgv,
			nil,
			nil
		)
	}

	@MainActor
	public func launchPreview(
		of initialViewController: @escaping @autoclosure () -> UIViewController,
		setup: @escaping (UIViewController) -> Void = { _ in },
		appDelegate: UIApplicationDelegate = MainActor.assumeIsolated { AppDelegate() }
	) {
		UIApplication.initialViewController = {
			let controller = initialViewController()
			setup(controller)
			return controller
		}

		UIApplication.shared.delegate = appDelegate

		_ = UIApplicationMain(
			CommandLine.argc,
			CommandLine.unsafeArgv,
			nil,
			nil
		)
	}
}

public class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	public var window: UIWindow?

	public func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = scene as? UIWindowScene
		else { return }

		let window = UIWindow(windowScene: windowScene)
		self.window = window

		window.rootViewController = UIApplication.initialViewController()
		window.makeKeyAndVisible()
	}

	public func sceneDidDisconnect(_ scene: UIScene) {}
	public func sceneDidBecomeActive(_ scene: UIScene) {}
	public func sceneWillResignActive(_ scene: UIScene) {}
	public func sceneWillEnterForeground(_ scene: UIScene) {}
	public func sceneDidEnterBackground(_ scene: UIScene) {}
}
