
Pod::Spec.new do |spec|
  spec.name         = "ReachabilityUI"
  spec.version      = "1.0.0"

  spec.summary      = "ReachabilityUI is a framework meant to help informing the user when an app loses connection to the internet."
  spec.description = "ReachabilityUI is a framework meant to help informing the user when an app loses connection to the internet. With ReachabilityUI you can even register a ReachabilityListener instance that will allow you to get notified about the connection drop. This can be used to adjust your application's UI so that the content won't overlap the banner, or for any other action you might need to take when the connectivity drops."

  spec.homepage     = "https://github.com/nodes-ios/Reachability-UI"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Nodes Agency - iOS" => "ios@nodes.dk" }

  spec.platform     = :ios, "11.0"
  spec.swift_version = '4.2'
  spec.source       = { :git => "https://github.com/nodes-ios/Reachability-UI.git", :tag => "#{spec.version}" }

  spec.subspec 'ReachabilityUI' do |subspec|
    subspec.ios.source_files = 'ReachabilityUI/ReachabilityUI/**/*.swift'
  end

end
