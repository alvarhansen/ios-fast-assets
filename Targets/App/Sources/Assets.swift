import UIKit

private final class BundleToken {
    static let bundle: Bundle = {
        Bundle(for: BundleToken.self)
    }()
}

public struct ImageAsset {
    public fileprivate(set) var name: String

    public var image: UIImage {
        let bundle = BundleToken.bundle
        #if FAST_ASSETS
        let path = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent() // Sources
            .deletingLastPathComponent() // App
            .appendingPathComponent("Resources")
            .appendingPathComponent("Assets.xcassets")
            .appendingPathComponent("\(name).imageset")
            .appendingPathComponent("\(name).png")  //Should not rely on png type, probably have to try different types or scan directory. Scanning would be useful for finding correct scale image
            .path

        let image = UIImage(contentsOfFile: path)
        #else
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        #endif
        return image!
    }
}
public enum Asset {
    public static let someImage = ImageAsset(name: "SomeImage")
}
