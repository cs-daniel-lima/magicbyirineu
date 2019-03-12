# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

target 'magicbyirineu' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'ReachabilitySwift', '4.3.0'
  pod 'Kingfisher', '5.1.1'
  pod 'SnapKit', '4.2.0'
  pod 'Reusable', '4.0.5'
  
  def testing_pods
    pod 'Nimble-Snapshots', '6.9.1'
    pod 'Quick', '1.3.4'
    pod 'Nimble', '7.3.4'
    pod 'KIF', '3.7.4', :configurations => ['Debug']
  end

  # Pods for magicbyirineu

  target 'magicbyirineuTests' do
    inherit! :search_paths
    # Pods for testing
    
    testing_pods
    
  end

end
