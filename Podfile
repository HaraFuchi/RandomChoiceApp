# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'RandomChoiceApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RandomChoiceApp
  
  pod 'SwiftLint','0.42.0'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'SkeletonView'
  pod 'ReachabilitySwift'

target  'RandomChoiceTests' do
    inherit! :search_paths
    pod 'Firebase'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
  end
end

end
