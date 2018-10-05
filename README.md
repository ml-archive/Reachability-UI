### Intro

Demo Project + Framework showcasing how to integrate the ReachabilityUI framework in a Nodes like VIPER architecture.

ReachabilityUI is a framework that is meant to help displaying the Network connection banner when the user looses connection to the internet in an app.

### Requirements

- iOS 11
- Swift 4.0+

### Instalation 

`github "nodes-ios/Reachability-UI"`

### Usage 

#### Initialise the ReachabilityUI dependencies

In your Dependencies struct, or wherever you initialise your dependencies, conform to the ReachabilityUI protocols `HasReachabilityUIRepository` and `HasReachabilityRepository` as follows: 

```
struct Dependencies {
    public static let shared = Dependencies()

    public var reachabilityRepository: ReachabilityRepository
    public var reachabilityUIEmbedableRepository: ReachabilityUIEmbedableRepository
    public var reachabilityUIControlRepository: ReachabilityUIControlRepository

    init() {
        // create an instance of ReachabilityUIManager, this will later be used to get notified of the connectivity change.    
        // Using this you will be able to adjust your layout, in such a way, that it won't overlap the content of your 
        // that it won't overlap the content of your  application.
        let reachabilityUIManager = ReachabilityUIManager()
        reachabilityUIEmbedableRepository = reachabilityUIManager
        reachabilityUIControlRepository = reachabilityUIManager
        // create an instance of ReachabilityManager, and call the setup function with your ReachabilityUIManager.
        // This will allow the ReachabilityUIManager to get notified about connectivity changes
        reachabilityRepository = ReachabilityManager()
        reachabilityRepository.setup(reachabilityUIManager)
    }

}

extension Dependencies: HasReachabilityUIRepository, HasReachabilityRepository {}
```

#### Initialise the ReachabilityUI banner 

To be able to get the Reachability banner on top of your views, in your `AppDelegate.swift` you will need to add the following code snippet: 

```
import ReachabilityUI

private var reachabilityCoordinator: ReachabilityCoordinator!

private func addReachability() {
    // create a ReachabilityConfiguration instance  
    let configuration = ReachabilityConfiguration(noConnectionTitle: "No Connection",
    noConnectionTitleColor: .white,
    noConnectionBackgroundColor: UIColor.red.withAlphaComponent(0.6),
    title: "Connected",
    titleColor: .white,
    backgroundColor: UIColor.green.withAlphaComponent(0.6),
    height: 30,
    font: UIFont.systemFont(ofSize: 12),
    textAlignment: .center)
    
    // create the ReachabilityCoordinator and pass it along the previously created ReachabilityConfiguration together with the ReachabilityUIEmbedableRepository
    let coordinator = ReachabilityCoordinator(window: window,
    reachabilityUIEmbedableRepository: dependencies.reachabilityUIEmbedableRepository,
    with: configuration)
    reachabilityCoordinator = coordinator
    coordinator.start()
}
```

#### Subscribe to ReachabilityUI notification in order to get notified about the connectivity change and adjust your layout. 

```
func subscribe() {
    // create a ReachabilityListener and register it by calling your previously
    // created ReachabilityUIEmbedableRepository's addListener function 
    // this function takes the listener and a listener id
    let listener: ReachabilityListener = { [weak self] isConnected in
    self?.output?.present(World.ReachabilityListener.Response(isConnected: isConnected))
    }
    reachabilityUIEmbedableRepository.addListener(listener: listener, for: "\(self)")
}

// in your deinit, remove the reference to the listener
deinit {
    reachabilityUIEmbedableRepository.removeListener(for: "\(self)")
}
```


### Credits

@anho (Andrei Hogea)

Reachability logic is as presented by Marco Santarossa on https://medium.com/@marcosantadev/network-reachability-with-swift-576ca5070e4b
