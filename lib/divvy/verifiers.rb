module Divvy
  module Verifiers
    # Checks to make sure <tt>path</tt> is a file on the remote server.
    def has_file(path)
      @commands << "test -f #{path}"
    end
    
    def file_contains(path, text)
      @commands << "grep '#{text}' #{path}"
    end
    
    # Tests that the directory <tt>dir</tt> exists.
    def has_directory(dir)
      @commands << "test -d #{dir}"
    end
    
    # Checks if <tt>path</tt> is an executable script. This verifier is "smart" because
    # if the path contains a forward slash '/' then it assumes you're checking an 
    # absolute path to an executable. If no '/' is in the path, it assumes you're
    # checking for a global executable that would be available anywhere on the command line.
    def has_executable(path)
      # Be smart: If the path includes a forward slash, we're checking
      # an absolute path. Otherwise, we're checking a global executable
      if path.include?('/')
        @commands << "test -x #{path}"
      else
        @commands << "[ -n \"`echo \\`which #{path}\\``\" ]"
      end
    end
    
    # Checks to make sure <tt>process</tt> is a process running
    # on the remote server.
    def has_process(process)
      @commands << "ps aux | grep '#{process}' | grep -v grep"
    end
    
    # Checks if ruby can require the <tt>files</tt> given. <tt>rubygems</tt>
    # is always included first.
    def ruby_can_load(*files)
      # Always include rubygems first
      files = files.unshift('rubygems').collect { |x| "require '#{x}'" }
      
      @commands << "ruby -e \"#{files.join(';')}\""
    end
    
    # Checks if a gem exists by calling "sudo gem list" and grepping against it.
    def has_gem(name, version=nil)
      version = version.nil? ? '' : version.gsub('.', '\.')
      @commands << "sudo gem list | grep -e '^#{name} (.*#{version}.*)$'"
    end
    
    # Checks that <tt>symlink</tt> is a symbolic link. If <tt>file</tt> is 
    # given, it checks that <tt>symlink</tt> points to <tt>file</tt>
    def has_symlink(symlink, file = nil)
      if file.nil?
        @commands << "test -L #{symlink}"
      else
        @commands << "test '#{file}' = `readlink #{symlink}`"
      end
    end
  end
end