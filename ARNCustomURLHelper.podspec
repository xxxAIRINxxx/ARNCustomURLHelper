#
# Be sure to run `pod lib lint ARNCustomURLHelper.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ARNCustomURLHelper"
  s.version          = "0.2.0"
  s.summary          = "iOS Custom URL Scheme Helper."
  s.homepage         = "https://github.com/xxxAIRINxxx/ARNCustomURLHelper"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "xxxAIRINxxx" => "xl1138@gmail.com" }
  s.source           = { :git => "https://github.com/xxxAIRINxxx/ARNCustomURLHelper.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.frameworks   = 'MessageUI'

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'ARNCustomURLHelper' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
