Pod::Spec.new do |s|

  s.name         = "ExpandingCellTransition"
  s.version      = "0.0.4"
  s.summary      = "Transition for UIViewController has UITableView"
  s.homepage     = "https://github.com/hmuronaka/ExpandingCellTransition"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "hmuronaka" => "capriccio27@gmail.com" }
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/hmuronaka/ExpandingCellTransition.git", :tag => "#{s.version}" }
  s.source_files  = "ExpandingCellTransition/**/*.swift"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true

end
