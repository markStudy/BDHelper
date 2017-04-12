

Pod::Spec.new do |s|

  s.name         = "BDHelper"
  s.version      = "0.0.1"
  s.summary      = "A short description of BDHelper."

  s.description  = "nothing"

  s.homepage     = "http://EXAMPLE/BDHelper"

  s.license      = "MIT"

  s.author             = { "Mark_Mac" => "641546030@qq.com" }

  s.platform           = :ios, "7.0"

  s.source       = { :git => "https://github.com/markStudy/BDHelper.git" }

#s.source_files  = "BDHelper", "BDHelper/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  # s.dependency "JSONKit", "~> 1.4"


    s.subspec 'MKHelper' do |ss|
    ss.source_files = 'BDHelper/MKHelper/*.{h,m}'
    end

end
