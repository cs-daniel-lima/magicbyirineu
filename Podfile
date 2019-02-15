# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'magicbyirineu' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  def testing_pods
    pod 'Nimble-Snapshots'
    pod 'Quick'
    pod 'Nimble'
    pod 'KIF', :configurations => ['Debug']
  end

  # Pods for magicbyirineu

  target 'magicbyirineuTests' do
    inherit! :search_paths
    # Pods for testing
    
    testing_pods
    
  end

end
