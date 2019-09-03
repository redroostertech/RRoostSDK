#
# Be sure to run `pod lib lint RRTech-Starter-App-Template.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RRTech-Starter-App-Template'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RRTech-Starter-App-Template.'

  s.description      = <<-DESC
  This is the cocoapod for the starter app template for most apps being built by a member of the RedRooster Technologies Inc. development team and it's strategic partners.
                     DESC

  s.homepage         = 'https://github.com/mwestbrooksjr@gmail.com/RRTech-Starter-App-Template'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RedRooster Technologies Inc.' => 'info@redroostertec.com' }
  s.source           = { :git => 'https://github.com/redroostertech/RRTech-Starter-App-Template.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mwestbrooksjr'

  s.platform = :ios, '10.0'
  s.ios.deployment_target = '10.0'
  s.swift_version = '4.0'

  s.source_files = 'RRTech-Starter-App-Template/Classes/**/*'
  s.resources = 'RRTech-Starter-App-Template/Assets/*'

  s.resource_bundles = {
    'RRTech-Starter-App-Template' => 'RRTech-Starter-App-Template/Classes/**/*.{ttf,otf,xib}',
    'ImageResources' => 'RRTech-Starter-App-Template/Assets/*.{xcassets,imageset,pdf,png}'
  }

#  s.dependency 'Alamofire'
#  s.dependency 'IQKeyboardManagerSwift'
#  s.dependency 'ObjectMapper'
#  s.dependency 'SVProgressHUD'
#  s.dependency 'KeychainSwift'
end
