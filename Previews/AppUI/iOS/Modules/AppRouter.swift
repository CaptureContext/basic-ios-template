import AppUI
import SwiftUI

class AppRouter: BaseRouter, @unchecked Sendable {
	@SectionsBuilder
	override func makeSections() -> [BaseRouter.NavigationSection] {
		.init(
			title: "Common",
			destinations: [
				.init("Hello, World!") { [push] in
					push(UIHostingController(rootView: ExampleView()))
				}
			]
		)
	}
}

struct ExampleView: View {
  var body: some View {
    Text("Hello, World!")
      .font(.largeTitle)
      .padding()
  }
}
