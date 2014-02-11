module CapistranoMisc::Misc
  module Guard
    def self.load_into(configuration)
      configuration.load do
        set :guard_env, :production

        namespace :misc do
          desc 'Guard specified env from accidentally execution'
          task :guard do
            env = self.rails_env.to_s
  
            guard = case
            when guard_env.is_a?(Regexp)
              env =~ guard_env
            else
              [guard_env].flatten.map(&:to_sym).include?(rails_env.to_sym)
            end
  
            if guard
              res = Capistrano::CLI.ui.ask %Q|Do you realy want to deploy to #{rails_env}, yes/no(no)?: |
              if res =~ /^(n|no)$/i
                exit
              elsif res !~ /^(y|yes)$/i
                next
              end
            end
          end
        end
      end
    end
  end
end

if Capistrano::Configuration.respond_to?(:instance) && !Capistrano::Configuration.instance.nil?
  CapistranoMisc::Misc::Guard.load_into(Capistrano::Configuration.instance)
end
