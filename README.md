[![Carthage Compatible](https://img.shields.io/badge/carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Plaforms](https://img.shields.io/badge/platforms-iOS%20-lightgrey.svg)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nodes-ios/Reachability-UI/blob/master/LICENSE)
### Intro

ReachabilityUI is a framework meant to help informing the user when an app loses connection  to the internet.

With ReachabilityUI you can even register a `ReachabilityListener` instance that will allow you to get notified about the connection drop. This can be used to adjust your application's UI so that the content won't overlap the banner, or for any other action you might need to take when the connectivity drops.

Please refer to the demo project for a showcase on how to integrate the ReachabilityUI framework in a Nodes like VIPER architecture.


## 📝 Requirements

- iOS 11
- Swift 4.0+

## 📦 Installation

### Carthage
~~~bash
github "nodes-ios/Reachability-UI"
~~~

### Cocoapods
~~~bash
pod "Reachability-UI"
~~~

## 💻 Usage

#### Initialize the ReachabilityUI Dependencies

Conform to `HasReachabilityListenerRepository` and create a `ReachabilityUIManager` instance:

```swift
import UIKit
import ReachabilityUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    public var reachabilityListenerFactory: ReachabilityListenerFactoryProtocol!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        reachabilityListenerFactory = ReachabilityUIManager()

        return true
    }
}

extension AppDelegate: HasReachabilityListenerRepository {}
```

#### Initialize the ReachabilityUI Banner

To enable the Reachability banner in your views, add the following code snippet to your `AppDelegate.swift`:

```swift
private func addReachability() {
    // create a ReachabilityConfiguration instance  
    let configuration = ReachabilityConfiguration(title: "Connected",
                                                  noConnectionTitle: "No Connection",
                                                  options: nil)

    // create the ReachabilityCoordinator and pass it along the previously
    // created ReachabilityConfiguration together with the ReachabilityListenerFactoryProtocol
    let coordinator = ReachabilityCoordinator(
        window: window,
        reachabilityListenerFactory: reachabilityListenerFactory,
        configuration: configuration
    )
    reachabilityCoordinator = coordinator
    coordinator.start()
}
```

#### Listen for Reachability Changes
To get notified about connectivity changes you must create a `listener` and start listening in order to get notified about the connectivity changes.

```swift
private var listener: ReachabilityListenerProtocol!

func subscribe() {
    listener = reachabilityListenerFactory.makeListener()
    listener.listen { [weak self] (isConnected) in
        // TODO: react to change in connected state
    }
}

```

#### Change Configurations
You can change the various options in the `ReachabilityConfiguration` to tailor the component to your needs.
```swift

 let configuration = ReachabilityConfiguration(title: "Connected",
                                               noConnectionTitle: "No Connection",
                                               options: [.appearance : ReachabilityConfiguration.Appearance.bottom,
                                                         .appearanceAdjustment : CGFloat(-100),
                                                         .animation : ReachabilityConfiguration.Animation.slideAndFadeInOutFromBottom])

```

The following keys can be used in the `options` dictionary:
* `.titleColor` (must be a `UIColor`)
* `.noConnectionTitleColor` (must be a `UIColor`)
* `.noConnectionBackgroundColor` (must be a `UIColor`)
* `.backgroundColor` (must be a `UIColor`)
* `.height` (must be a `CGFloat`)
* `.font` (must be a `UIFont`)
* `.textAlignment` (must be a `NSTextAlignment`)
* `.animation` (must be a `ReachabilityConfiguration.Animation`)
* `.appearance` (must be a `ReachabilityConfiguration.Appearance`)
* `.appearanceAdjustment` (must be a `CGFloat`)

If options are set to `nil`, default options will be used. Any options set, will override the default state.

## 👥 Credits
Made with ❤️ at [Nodes](http://nodesagency.com).

Reachability logic is as presented by Marco Santarossa on https://medium.com/@marcosantadev/network-reachability-with-swift-576ca5070e4b

## 📄 License
**Reachability-UI** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/Reachability-UI/blob/master/LICENSE) file for more info.
