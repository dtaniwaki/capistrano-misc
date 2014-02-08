require 'capistrano'
require 'capistrano/cli'

module CapistranoMisc
end

Dir.glob(File.expand_path("../capistrano-misc/**/*.rb", __FILE__)) { |path| require path }

