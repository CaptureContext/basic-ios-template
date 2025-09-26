import SwiftUI
import AppUI
import _CocoaNavigation

open class RoutingController: UIHostingController<RoutingView> {
	init(title: String? = nil, router: BaseRouter) {
		super.init(rootView: .init(router))
		title.map { self.navigationItem.title = $0 }
	}

	override open func viewDidLoad() {
		super.viewDidLoad()
	}

	public required init?(coder: NSCoder) {
		fatalError("Unimplemented")
	}

	override open func didMove(toParent parent: UIViewController?) {
		super.didMove(toParent: parent)
		guard let navigationController else { return }
		rootView.router.navigation = navigationController
		rootView.darkModeTracker.isDarkMode = navigationController.overrideUserInterfaceStyle == .dark
		navigationController.navigationBar.prefersLargeTitles = true
	}
}

public struct RoutingView: View {
	let router: BaseRouter

	@State
	fileprivate var darkModeTracker = SimpleDarkModeTracker()

	public init(_ router: BaseRouter) {
		self.router = router
	}

	public var body: some View {
		List {
			ForEach(router.sections, id: \.title) { section in
				Section(section.title) {
					ForEach(section.destinations, id: \.title) { destination in
						Button(destination.title) {
							destination.action()
						}
					}
				}
			}
		}
		.environment(\.colorScheme, darkModeTracker.isDarkMode ? .dark : .light)
	}
}

fileprivate class SimpleDarkModeTracker: Observable {
	var isDarkMode: Bool = true
}
