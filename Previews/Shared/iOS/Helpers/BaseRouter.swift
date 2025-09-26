import AppUI
import ArrayBuilder

@MainActor
open class BaseRouter: @unchecked Sendable {
	public typealias SectionsBuilder = ArrayBuilder<NavigationSection>

	public struct NavigationSection {
		var title: String
		var destinations: [NavigationDestination]
	}

	public struct NavigationDestination {
		var title: String
		var action: @MainActor @Sendable () -> Void

		init(
			_ title: String,
			action: @MainActor @Sendable @escaping () -> Void
		) {
			self.title = title
			self.action = action
		}
	}

	var navigation: UINavigationController!

	var present: @MainActor @Sendable (UIViewController) -> Void {{ [weak self] controller in
		self?.navigation.present(controller, animated: true)
	}}

	var push: @MainActor @Sendable (UIViewController) -> Void {{ [weak self] controller in
		self?.navigation.pushViewController(controller, animated: true)
	}}

	func makeSection(
		_ factory: @MainActor (
			@MainActor @Sendable @escaping (UIViewController) -> Void,
			@MainActor @Sendable @escaping (UIViewController) -> Void
		) -> NavigationSection
	) -> NavigationSection {
		factory(present, push)
	}

	func makeDestination(
		_ factory: @MainActor (
			@MainActor @Sendable @escaping (UIViewController) -> Void,
			@MainActor @Sendable @escaping (UIViewController) -> Void
		) -> NavigationDestination
	) -> NavigationDestination {
		factory(present, push)
	}

	public init() {
		self.sections = makeSections()
	}

	@SectionsBuilder
	open func makeSections() -> [NavigationSection] { [] }

	private(set) var sections: [NavigationSection] = []
}
