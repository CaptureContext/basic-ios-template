import AppUI

final class ShakeGestureDismissableController: UIViewController {
	func withContent(_ controller: UIViewController) -> UIViewController {
		addChild(controller)
		_ = withContent(controller.view)
		controller.didMove(toParent: self)
		return self
	}

	func withContent(_ content: UIView) -> UIViewController {
		view.addSubview(content)
		content.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			content.topAnchor.constraint(equalTo: view.topAnchor),
			content.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			content.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			content.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
		return self
	}

	override func motionEnded(
    _ motion: UIEvent.EventSubtype, 
  	with event: UIEvent?
	) {
		super.motionEnded(motion, with: event)
		if motion == .motionShake { dismiss(animated: true) }
	}
}
