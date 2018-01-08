Pod::Spec.new do |s|
  s.name         = "Oak"
  s.version      = "2.2.0"
  s.summary      = "Oak"

  s.homepage     = "https://github.com/getwagit/Oak.git"
  s.license      = "MIT"
  
  s.author             = { 
    "Markus Riegel" => "markus@getwagit.com",
    "Joachim Fröstl" => "hello@jogga.co"
  }
  
  s.platform     = :ios, "9.0"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

  s.source       = { :git => "https://github.com/getwagit/Oak.git", :tag => "#{s.version}" }
  s.source_files  = "Oak/**/*.{swift,h,m}"
end