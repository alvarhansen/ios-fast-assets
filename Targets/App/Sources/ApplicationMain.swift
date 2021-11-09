import UIKit

@UIApplicationMain
class ApplicationMain: UIResponder, UIApplicationDelegate {

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        print(Asset.someImage.image.size)

        return true
    }

}
