Pod::Spec.new do |spec|

  
  spec.name         = "MSTouchID"
  spec.version      = "0.0.1"
  spec.summary      = "It's used to login or pay via faceID and TouchID."


  spec.homepage     = "https://github.com/MarcSteven/MSTouchID"


  
  spec.license      = "MIT "


  
  spec.author             = { "MarcSteven" => "marczhao@memoriesus.com" }
  spec.social_media_url   = "https://twitter.com/MarcSteven"

  

   spec.ios.deployment_target = "9.0"
  

  
  spec.source       = { :git => "https://github.com/MarcSteven/MSTouchID.git", :tag => "#{spec.version}" }


  spec.swift_versions = ['5.0','5.1']
  spec.source_files  = "MSTouchID/Sources/**/*"
  spec.frameworks = "LocalAuthentication"
  

  
end
