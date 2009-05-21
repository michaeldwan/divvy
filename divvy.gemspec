# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{divvy}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Dwan"]
  s.date = %q{2009-05-20}
  s.default_executable = %q{divvy}
  s.email = %q{mpdwan@gmail.com}
  s.executables = ["divvy"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/divvy",
     "divvy.gemspec",
     "examples/packages/build_essential.rb",
     "examples/packages/databases/mysql.rb",
     "examples/packages/databases/sqlite3.rb",
     "examples/packages/ruby/rails.rb",
     "examples/packages/ruby/ruby.rb",
     "examples/packages/ruby/ruby_gems.rb",
     "examples/packages/scm/git.rb",
     "examples/packages/utilities/screen.rb",
     "lib/divvy.rb",
     "lib/divvy/package.rb",
     "lib/divvy/package_runner.rb",
     "lib/divvy/plugins/apt.rb",
     "lib/divvy/plugins/file_utilities.rb",
     "lib/divvy/plugins/gem.rb",
     "lib/divvy/plugins/source.rb",
     "lib/divvy/provisioner.rb",
     "lib/divvy/script.rb",
     "lib/divvy/server.rb",
     "lib/divvy/verification.rb",
     "lib/divvy/verifiers.rb",
     "test/divvy_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mdwan/divvy}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Divvy is an easy to configure, easy to extend server provisioning framework written in Ruby.}
  s.test_files = [
    "test/divvy_test.rb",
     "test/test_helper.rb",
     "examples/packages/build_essential.rb",
     "examples/packages/databases/mysql.rb",
     "examples/packages/databases/sqlite3.rb",
     "examples/packages/ruby/rails.rb",
     "examples/packages/ruby/ruby.rb",
     "examples/packages/ruby/ruby_gems.rb",
     "examples/packages/scm/git.rb",
     "examples/packages/utilities/screen.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
