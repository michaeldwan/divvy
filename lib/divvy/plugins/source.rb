module Divvy
  module Plugins
    module Source
      
      def source(source, options = {}, &block)
        SourceInstaller.new(self, source, options, &block)
      end
            
      class SourceInstaller
        def initialize(runner, source, options = {}, &block)
          @runner = runner
          @source = source
          @options = {
            :prefix => '/usr/local',
            :archives => '/usr/local/sources',
            :builds => '/usr/local/build'
          }.merge(options)
          
          @befores = {}
          @afters = {}
          @stages = {
            :prepare => Proc.new { prepare },
            :download => Proc.new { download },
            :extract => Proc.new { extract },
            :configure => Proc.new { configure },
            :build => Proc.new { build },
            :install => Proc.new { install }
          }
          self.instance_eval(&block) unless block.nil?
          
          [:prepare, :download, :extract, :configure, :build, :install].each do |stage|
            puts "before #{stage}" if Divvy.verbose
            @befores[stage].call if @befores[stage]
            puts "stage #{stage}" if Divvy.verbose
            @stages[stage].call if @stages[stage]
            puts "after #{stage}" if Divvy.verbose            
            @afters[stage].call if @afters[stage]
          end
        end
        
        attr_reader :options, :source, :runner
        
        def before(stage, &block)
          @befores[stage] = block
        end

        def after(stage, &block)
          @afters[stage] = block
        end

        def stage(stage, &block)
          @stages[stage] = block
        end
        
        def skip(*stages)
          stages.each { |stage| @stages.delete(stage) }
        end
        
        def build_dir #:nodoc:
          "#{options[:builds]}/#{options[:custom_dir] || base_dir}"
        end

        def base_dir #:nodoc:
          if source.split('/').last =~ /(.*)\.(tar\.gz|tgz|tar\.bz2|tb2)/
            return $1
          end
          raise "Unknown base path for source archive: #{ssource}, please update code knowledge"
        end
        
        def archive_name
          name = @source.split('/').last
          raise "Unable to determine archive name for source: #{source}, please update code knowledge" unless name
          name
        end

        private
          def prepare
            runner.mkdir(options[:prefix])
            runner.mkdir(options[:archives])
            runner.mkdir(options[:builds])
          end
                            
          def download
            run("wget -cq --directory-prefix='#{options[:archives]}' #{source}")
          end
                  
          def extract
            extract_command = case source
              when /(tar.gz)|(tgz)$/
                'tar xzf'
              when /(tar.bz2)|(tb2)$/
                'tar xjf'
              when /tar$/
                'tar xf'
              when /zip$/
                'unzip'
              else
                raise "Unknown source archive format: #{source}"
            end
            
            run("bash -c 'cd #{options[:builds]} && #{extract_command} #{options[:archives]}/#{archive_name}'")
          end
                  
          def configure
            # command = "bash -c 'cd #{build_dir} && ./configure --prefix=#{@options[:prefix]} "            
            command = "cd #{build_dir} && ./configure --prefix=#{@options[:prefix]} "
            extras = {
              :enable  => '--enable', :disable => '--disable',
              :with    => '--with',   :without => '--without'
            }
            extras.inject(command) { |m, (k, v)| m << create_options(k, v) if options[k]; m }
            
            # command << " > #{archive_name}-configure.log 2>&1'"
            
            run(command)
          end
        
          def build
            # run("bash -c 'cd #{build_dir} && make > #{archive_name}-build.log 2>&1'")
            run("cd #{build_dir} && make")
          end
                  
          def install
            # run("bash -c 'cd #{build_dir} && make install > #{archive_name}-install.log 2>&1'")
            run("cd #{build_dir} && make install")
          end
          
          def create_options(key, prefix) #:nodoc:
            options[key].inject(' ') { |m, option| m << "#{prefix}-#{option} "; m }
          end
                    
          def method_missing(symbol, *args)
            runner.send(symbol, args)
          end
      end
    end
  end
end

Divvy.register_plugin(Divvy::Plugins::Source)