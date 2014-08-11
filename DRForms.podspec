Pod::Spec.new do |s|
  s.name         = "DRForms"
  s.version      = "1.0.8"
  s.summary      = "iOS Objective-C library for implementing dynamic forms."
  s.homepage     = "https://github.com/darrarski/DRForms-iOS"
  s.license      = 'MIT'
  s.author       = { "Darrarski" => "darrarski@gmail.com" }
  s.source       = { :git => "https://github.com/darrarski/DRForms-iOS.git", :tag => "v1.0.8" }
  s.platform     = :ios
  s.source_files = 'DRForms'
  s.requires_arc = true
end
