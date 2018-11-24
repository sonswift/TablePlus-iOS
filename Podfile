# Uncomment the next line to define a global platform for your project

# Define iOS min version
platform :ios, '11.0'

# Using Pods frameworks
use_frameworks!

TARGET_NAME='TablePlus-iOS'

def main_pods
  # Define main Cocoapods in this App
  pod 'AlamofireObjectMapper'
  pod 'RealmSwift'
  pod 'SwiftDate'
end

target TARGET_NAME do

  main_pods
  
  target 'TablePlus-iOSTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TablePlus-iOSUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    project = installer.pods_project
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end

    # Auto update swift optimization level after installing or updating
    print "Remove warning SWIFT_OPTIMIZATION_LEVEL & CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED\n"
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
        config.build_settings['CLANG_ANALYZER_LOCALIZABILITY_NONLOCALIZED'] = true
    end

    podsTargets = installer.pods_project.targets.find_all { |target| target.name.start_with?('Pods') }
    podsTargets.each do |target|
        target.frameworks_build_phase.clear
    end
end
