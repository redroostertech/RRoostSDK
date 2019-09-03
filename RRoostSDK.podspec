Pod::Spec.new do |s|
  s.name             = 'RRoostSDK'
  s.version          = '0.1.0'
  s.summary          = 'RRoostSDK provides access to utilities and extensions that makes it easy to build applications.'

  s.description      = <<-DESC
  This is the cocoapod for the starter app template for most apps being built by a member of the RedRooster Technologies Inc. development team and it's strategic partners.
                     DESC

  s.homepage         = 'https://github.com/redroostertech/RRTech-Starter-App-Template'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RedRooster Technologies Inc.' => 'info@redroostertec.com' }
  s.source           = { :git => 'https://github.com/redroostertech/RRTech-Starter-App-Template.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mwestbrooksjr'

  s.platform = :ios, '10.0'
  s.ios.deployment_target = '10.0'
  s.swift_version = '4.0'

  s.source_files = 'RRoostSDK/Classes/**/*'

  s.resource_bundles = {
    'RRoostSDK' => ['RRoostSDK/Classes/**/*.{ttf,otf,xib}', 'RRoostSDK/Assets/*.{xcassets,imageset,pdf,png}']
  }
  
end
