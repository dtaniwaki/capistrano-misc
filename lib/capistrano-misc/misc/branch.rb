module CapistranoMisc::Misc
  module Branch
    def self.load_into(configuration)
      configuration.load do
        namespace :misc do
          desc 'Select branch to deploy from console'
          task :branch do
            branch = fetch(:branch, nil)
            next if branch.is_a?(String)
          
            regexp = branch.is_a?(Regexp) ? branch : /.*/
            branches = run_locally(%Q|#{scm} fetch && #{scm} branch -a|).split("\n").map{ |s| s.sub(/^[ *]*/, "") }
            branches = branches.grep(regexp)
          
            options = ['0: Use revision number']
            options.concat branches.map.with_index{|revision, idx|"#{idx+1}: #{revision}"}
            options.concat ['q: Quit']
            while
              s = Capistrano::CLI.ui.ask(%Q|Choose branch from \n#{options.join("\n")}\n or type tag to deploy (make sure to push the tag first): |).strip
              if s =~ /q(uit)?/i
                exit
              elsif s.to_i.to_s != s
                next
              end
              break
            end
          
            case idx = s.to_i
            when 0
              tag = Capistrano::CLI.ui.ask('Type revision or tag to deploy: ').strip
            else
              tag = branches[idx-1]
            end
          
            if tag.nil? || tag !~ regexp
              logger.important "err :: The branch you specified is not allowed to deploy"
              exit
            end
          
            set :branch, tag
          end
        end
      end
    end
  end
end

if Capistrano::Configuration.respond_to?(:instance) && !Capistrano::Configuration.instance.nil?
  CapistranoMisc::Misc::Branch.load_into(Capistrano::Configuration.instance)
end
