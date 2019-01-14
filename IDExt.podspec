Pod::Spec.new do |s|
  s.name                  = 'IDExt'
  s.version               = '1.0.0'
  s.summary               = 'IDExt framework for Swift.'
  s.description           = <<-DESC
                            Written in Swift.
                            My helper Framework.
                            DESC
  s.homepage              = 'https://github.com/omidgolparvar/IDExt'
  s.license               = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author                = { 'Omid Golparvar' => 'iGolparvar@gmail.com' }
  s.source                = { :git => "https://github.com/omidgolparvar/IDExt.git", :tag => s.version.to_s }
  s.swift_version         = '4.2'
  s.platform              = :ios, '10.0'
  s.requires_arc          = true
  s.ios.deployment_target = '10.0'
  s.pod_target_xcconfig   = { 'SWIFT_VERSION' => '4.2' }

  s.source_files = [
    'IDExt/*.{h,swift}',
    'IDExt/**/*.swift',
  ]
  
  s.public_header_files = 'IDExt/*.h'

  s.libraries  = "z"
  
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
  s.dependency 'UIDeviceComplete'
  s.dependency 'PersianSwift'
  s.dependency 'PKHUD', '~> 5.0'
  s.dependency 'SwiftEntryKit', '0.8.4'

end