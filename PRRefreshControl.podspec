Pod::Spec.new do |s|
  s.name         = "PRRefreshControl"
  s.version      = "0.1.1"
  s.summary      = "Yet another and better refresh control for scroll views."
  s.homepage     = "https://github.com/Elethom/PRRefreshControl"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Elethom Hunter" => "elethomhunter@gmail.com" }
  s.social_media_url   = "https://twitter.com/ElethomHunter"
  s.platform     = :ios
  s.ios.deployment_target = "5.0"
  s.source       = { :git => "https://github.com/Elethom/PRRefreshControl.git", :tag => "0.1.1" }
  s.source_files  = "Classes/*.{h,m}"
  s.public_header_files = "Classes/*.h"
  s.resources = "Resources/PRRefreshControl.bundle"
  s.requires_arc = true
end
