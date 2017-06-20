Pod::Spec.new do |spec|
spec.name             = 'VscFont'
spec.ios.deployment_target = '7.0'
spec.version          = '1.0.0'
spec.summary          = '在线下载字体(必须是苹果系统支持的字体)'
spec.description      = <<-DESC
在线下载字体(必须是苹果系统支持的字体),可以在系统的字体册查看
DESC
spec.homepage         = 'https://github.com/vcsatanial/VscFont'
spec.license          = { :type => 'MIT', :file => 'LICENSE' }
spec.author           = { 'VincentSatanial' => '116359398@qq.com' }
spec.source           = { :git => 'https://github.com/vcsatanial/VscFont.git', :tag => spec.version }

spec.source_files = 'VscFont/*.{h,m}'
spec.requires_arc = true
end
