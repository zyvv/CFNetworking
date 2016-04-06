Pod::Spec.new do |s|
  s.name             = "SFNetworking"
  s.version          = "1.0"
  s.summary          = "对GET和POST请求的简单封装"
  s.description      = <<-DESC
                       基于AFNetworking对GET和POST请求的简单封装
                       DESC
  s.license          = 'MIT'
  s.homepage         = "http://zyvv.github.io/"
  s.author           = { "zyvv" => "zhangyangv@foxmail.com" }
  s.source           = { :git => "https://github.com/zyvv/SFNetworking.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'SFNetworking/*.{h,m}'
  s.dependency 'AFNetworking', '~> 2.0'
end
