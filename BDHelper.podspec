

Pod::Spec.new do |s|

  s.name         = "BDHelper"
  s.version      = "0.0.1"
  s.summary      = "a help file for your workbace"

  s.description  = "a help file for your workbace , you can use it eazy"

  s.homepage     = "https://github.com/markStudy/BDHelper"

  s.license      = "MIT"

  s.author       = { "Mark_Mac" => "641546030@qq.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/markStudy/BDHelper.git", :tag => s.version }

# s.source_files  = "BDHelper", "BDHelper/**/*.{h,m}"
# s.exclude_files = "Classes/Exclude"

  # s.dependency "JSONKit", "~> 1.4"


    s.subspec 'MKHelper' do |ss|
    ss.source_files = 'BDHelper/MKHelper/*.{h,m}'
    end

end
