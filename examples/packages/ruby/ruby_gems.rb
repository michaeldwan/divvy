package :ruby_gems do
  requires :build_essential, :ruby

  verify do
    has_executable 'gem'
  end

  apply do
    source "http://rubyforge.org/frs/download.php/56227/rubygems-1.3.3.tgz" do
      skip :configure, :build
      stage :install do
        run("cd #{build_dir} && ruby setup.rb")
        run('ln -Fs /usr/bin/gem1.8 /usr/bin/gem')
        run('gem update')
        run('gem update --system')        
      end
    end
  end
end