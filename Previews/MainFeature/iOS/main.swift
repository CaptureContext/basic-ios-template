import UIKit
import MainFeature

MainActor.assumeIsolated {
	UIApplication.shared.launchPreview(
		of: MainViewController(),
		setup: { controller in
			// controller.overrideUserInterfaceStyle = .dark
		}
	)
}
