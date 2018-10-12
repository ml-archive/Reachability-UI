[![Carthage Compatible](https://img.shields.io/badge/carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Plaforms](https://img.shields.io/badge/platforms-iOS%20-lightgrey.svg)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/nodes-ios/Reachability-UI/blob/master/LICENSE)
### Intro

Demo Project + Framework showcasing the integration of the ReachabilityUI framework in a Nodes like VIPER architecture.

ReachabilityUI is a framework that is meant to help displaying the Network connection banner when the user loses connection to the internet in an app.
With ReachabilityUI you can even register a `ReachabilityListener` instance that will allow you to get notified about the connection drop. This can be used to adjust your application's UI so that the content won't overlap the banner, or for any other action you might need to take when the connectivy drops.

## 📝 Requirements

- iOS 11
- Swift 4.0+

## 📦 Installation

### Carthage 
~~~bash
github "nodes-ios/Reachability-UI"
~~~

## 💻 Usage

#### Initialise the ReachabilityUI dependencies

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

#### Initialise the ReachabilityUI banner 

To be able to get the Reachability banner on top of your views, in your `AppDelegate.swift` you will need to add the following code snippet: 

```swift
private func addReachability() {
    // create a ReachabilityConfiguration instance  
    let configuration = ReachabilityConfiguration(
        noConnectionTitle: "No Connection",
        noConnectionTitleColor: .white,
        noConnectionBackgroundColor: UIColor.red.withAlphaComponent(0.6),
        title: "Connected",
        titleColor: .white,
        backgroundColor: UIColor.green.withAlphaComponent(0.6),
        height: 30,
        font: UIFont.systemFont(ofSize: 12),
        textAlignment: .center,
        animation: .fadeInOut)
    )

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

#### Subscribe to ReachabilityUI callback in order to get notified about the connectivity change and adjust your layout. 

```swift
private var listener: ReachabilityListenerProtocol!

func subscribe() {
    listener = reachabilityListenerFactory.makeListener()
    listener.listen { [weak self] (isConnected) in
        // TODO: react to change in connected state
    }
}

```

## 👥 Credits
Made with ❤️ at [Nodes](http://nodesagency.com).

Reachability logic is as presented by Marco Santarossa on https://medium.com/@marcosantadev/network-reachability-with-swift-576ca5070e4b

## 📄 License
**Reachability-UI** is available under the MIT license. See the [LICENSE](https://github.com/nodes-ios/Reachability-UI/blob/master/LICENSE) file for more info.
