Pod::Spec.new do |s|
  s.name         = "ARNCustomURLHelper"
  s.version      = "0.1.0"
  s.summary      = "iOS Custom URL Scheme Helper."
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = "https://github.com/xxxAIRINxxx/ARNCustomURLHelper"
  s.author       = { "Airin" => "xl1138@gmail.com" }
  s.source       = { :git => "https://github.com/xxxAIRINxxx/ARNCustomURLHelper.git", :tag => "#{s.version}" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'ARNCustomURLHelper/*.{h,m}'
end
