require "bundler/setup"
require "pp-adaptive"

Pathname.glob(File.join(File.dirname(__FILE__), "**/shared/**/*.rb")).each do |file|
  require file
end
