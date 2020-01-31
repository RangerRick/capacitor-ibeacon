
  Pod::Spec.new do |s|
    s.name = 'CapacitorIbeacon'
    s.version = '0.0.1'
    s.summary = 'IBeacon Transmit and Scan'
    s.license = 'MIT'
    s.homepage = 'https://github.com/RangerRick/capacitor-ibeacon.git'
    s.author = 'Benjamin Reed <rangerrick@befunk.com>'
    s.source = { :git => 'https://github.com/RangerRick/capacitor-ibeacon.git', :tag => s.version.to_s }
    s.source_files = 'ios/Plugin/**/*.{swift,h,m,c,cc,mm,cpp}'
    s.ios.deployment_target  = '11.0'
    s.dependency 'Capacitor'
  end