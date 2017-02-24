Pod::Spec.new do |s|
  s.name = "Cache"
  s.version = "0.0.1"
  s.summary = "Protocol-oriented static caching interface for wrapping NSCache API"
  s.description = "Declare a static shared cache object in your definition of choice and adopt the Cacheable protocol. Interface with an easy to use and easy to read API with just one line of code."
  s.homepage = "https://github.com/mtfourre/Cacheable"
  s.license = { :type => "Unlicense", :file => "LICENSE" }
  s.author = { "Michael Fourre" => "mtfourre@gmail.com" }
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.source = { :git => 'https://github.com/mtfourre/Cache.git' }
  s.source_files = "*.swift"
end
