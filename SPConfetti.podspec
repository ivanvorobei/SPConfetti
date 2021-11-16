Pod::Spec.new do |s|

  s.name = 'SPConfetti'
  s.version = '1.2.6'
  s.summary = 'Show the confetti only when the user is having fun, and if not having fun, dont show it.'
  s.homepage = 'https://github.com/ivanvorobei/SPConfetti'
  s.source = { :git => 'https://github.com/ivanvorobei/SPConfetti.git', :tag => s.version }
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { 'Ivan Vorobei' => 'hello@ivanvorobei.by' }
  
  s.swift_version = '5.1'
  s.ios.deployment_target = '10.0'
  
  s.source_files = 'Sources/SPConfetti/**/*.swift'

  s.pod_target_xcconfig = {
    "SWIFT_ACTIVE_COMPILATION_CONDITIONS"  => "SPCONFETTI_COCOAPODS"
  }
    
  s.resource_bundles = {
    "SPConfetti" => [
        "Sources/SPConfetti/Resources/Assets.xcassets",
    ]
  }

end
