Pod::Spec.new do |s|

  s.name = 'SPConfetti'
  s.version = '1.0.2'
  s.summary = ''
  s.homepage = 'https://github.com/ivanvorobei/SPConfetti'
  s.source = { :git => 'https://github.com/ivanvorobei/SPConfetti.git', :tag => s.version }
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { 'Ivan Vorobei' => 'hello@ivanvorobei.by' }
  
  s.swift_version = '5.1'
  s.ios.deployment_target = '12.0'
  
  s.source_files = 'Sources/SPConfetti/**/*.swift'

end
