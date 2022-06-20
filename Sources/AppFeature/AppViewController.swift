import AppUI
import MainFeature

public final class AppViewController: UIViewController {
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    let mainController = MainViewController()
    addChild(mainController)
    view.addSubview(mainController.view)
    mainController.view.frame = view.bounds
    mainController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    mainController.didMove(toParent: self)
  }
}
