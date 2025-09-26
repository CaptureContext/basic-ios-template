import AppUI

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

		window.rootViewController = AppViewController()

		window.makeKeyAndVisible()
	}

	public func sceneDidDisconnect(_ scene: UIScene) {}
	public func sceneDidBecomeActive(_ scene: UIScene) {}
	public func sceneWillResignActive(_ scene: UIScene) {}
	public func sceneWillEnterForeground(_ scene: UIScene) {}
	public func sceneDidEnterBackground(_ scene: UIScene) {}
}

