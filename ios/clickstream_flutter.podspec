#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint clickstream_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'clickstream_flutter'
  s.version          = '0.0.1'
  s.summary          = 'clickstream flutter SDK'
  s.description      = <<-DESC
clickstream flutter SDK
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.7'

  s.subspec 'Clickstream' do |sc|
    sc.source_files = 'Clickstream/Sources/**/*'
    sc.dependency 'GzipSwift', '5.1.1'
    sc.dependency 'Amplify', '1.30.3'
    sc.dependency 'SQLite.swift', '0.13.2'
  end
end
