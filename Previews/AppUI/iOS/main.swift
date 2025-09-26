import AppUI

MainActor.assumeIsolated {
	UIApplication.shared.launchPreview(
		of: UINavigationController(
			rootViewController: RoutingController(
				title: "AppUI",
				router: AppRouter()
			)
		)
	)
}
