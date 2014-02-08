module CapistranoMisc::Misc
  module Log
    def self.load_into(configuration)
      configuration.load do
        namespace :misc do
          task :log, roles: :app do
            file = ENV['file'] || "*.log"
            run "tail -f #{current_path}/log/#{file}" do |channel, stream, data|
              trap("INT") { puts "Interupted!"; exit 0; }
              puts data
              puts
              break if stream == :err
            end
          end
        end
      end
    end
  end
end

if Capistrano::Configuration.respond_to?(:instance) && !Capistrano::Configuration.instance.nil?
  CapistranoMisc::Misc::Log.load_into(Capistrano::Configuration.instance)
end
