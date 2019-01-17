Pod::Spec.new do |s|
  s.name             = 'WRCycleScrollView'
  s.version          = '0.1.0'
  s.summary          = 'A cycle scroll view in Swift.'

  s.description      = <<-DESC
'WRCycleScrollView, the only cycle scroll view you need in iOS.'
                       DESC

  s.homepage         = 'https://github.com/wangrui460/WRCycleScrollView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangrui460' => 'wangruidev@gmail.com' }
  s.source           = { :git => 'https://github.com/wangrui460/WRCycleScrollView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = "4.2"
  s.ios.deployment_target = '8.0'

  s.source_files = 'WRCycleScrollView/Classes/**/*'

  s.dependency 'Kingfisher', '>= 4.10.0'
end
