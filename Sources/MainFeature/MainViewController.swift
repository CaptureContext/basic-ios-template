import AppUI
import SwiftUI

public final class MainViewController: UITabBarController {
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    tabBar.backgroundColor = .systemBackground.withAlphaComponent(0.7)
    setViewControllers(
      [
        UIHostingController(
          rootView: VStack {
            HStack {
                Image.resource(.usgsUnsplash)
                  .resizable()
                  .aspectRatio(1, contentMode: .fill)
                  .frame(width: 120, height: 120)
                  .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                  .overlay(Color.black.opacity(0.1))
                  .overlay(
                    Text("shared\nresource")
                      .foregroundColor(.white)
                      .multilineTextAlignment(.center)
                      .font(.system(size: 12, weight: .regular, design: .monospaced))
                  )
                Image.resource(.usgsUnsplash_2)
                  .resizable()
                  .aspectRatio(1, contentMode: .fill)
                  .frame(width: 120, height: 120)
                  .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                  .overlay(Color.black.opacity(0.1))
                  .overlay(
                    Text("local\nresource")
                      .foregroundColor(.white)
                      .multilineTextAlignment(.center)
                      .font(.system(size: 12, weight: .regular, design: .monospaced))
                  )
            }
            Text("First")
              .fontWeight(.semibold)
              .foregroundColor(Color.white)
              .padding(.vertical, 6)
              .padding(.horizontal, 32)
              .background(Color.black)
              .clipShape(Capsule())
          }
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
              .overlay(Color.black.opacity(0.1))
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
            .fontWeight(.semibold)
            .foregroundColor(Color.black)
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
