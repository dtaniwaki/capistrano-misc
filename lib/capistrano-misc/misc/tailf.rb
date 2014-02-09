module CapistranoMisc::Misc
  module Tailf
    def self.load_into(configuration)
      configuration.load do
        namespace :misc do
          desc 'tailf in all the servers'
          task :tailf, roles: :app do
            file = ENV['tailf_file'] || fetch(:tailf_file, nil) || "*.log"
            dir = fetch(:tailf_dir, "#{current_path}/log")
            path = File.join(dir, file)
            run "tail -f #{path}" do |channel, stream, data|
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
  CapistranoMisc::Misc::Tailf.load_into(Capistrano::Configuration.instance)
end
