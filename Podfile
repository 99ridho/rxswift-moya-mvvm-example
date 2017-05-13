# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'RxSwift Github MVVM' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RxSwift Github MVVM
  pod 'Moya/RxSwift'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya-ModelMapper/RxSwift', '4.0.0'
  pod 'SnapKit'
  pod 'RxOptional'

  target 'RxSwift Github MVVMTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RxSwift Github MVVMUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0' # or '3.0'
        end
    end
end
