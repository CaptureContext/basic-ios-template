import AppUI
import SwiftUI

public final class MainViewController: UITabBarController {
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBar.backgroundColor = .systemBackground.withAlphaComponent(0.7)
    setViewControllers(
      [
        UIHostingController(
          rootView: Text("First")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
              LinearGradient(
                colors: [
                  .blue,
                  .green
                ],
                startPoint: .top,
                endPoint: .bottom
              )
              .edgesIgnoringSafeArea(.all)
            )
        ).configured { $0
          .tabBarItem(UITabBarItem(
            title: "First",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
          ))
        },
        UIHostingController(
          rootView: Text("Second")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
              LinearGradient(
                colors: [
                  .orange,
                  .red
                ],
                startPoint: .top,
                endPoint: .bottom
              )
              .edgesIgnoringSafeArea(.all)
            )
        ).configured { $0
          .tabBarItem(UITabBarItem(
            title: "Second",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
          ))
        },
      ],
      animated: false
    )
  }
}
