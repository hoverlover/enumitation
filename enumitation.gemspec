# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "enumitation/version"

Gem::Specification.new do |s|
  s.name        = "enumitation"
  s.version     = Enumitation::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chad Boyd"]
  s.email       = ["hoverlover@gmail.com"]
  s.homepage    = "http://github.com/hoverlover/enumitation"
  s.summary     = %q{Fake enums for ActiveModel}
  s.description = <<DESC
Ever wanted to restrict an attribute to specific values, but not wanted to
create a join table to hold the values, and didn't want (or couldn't) create
an enum field?  Now you can, with enumitation!
DESC

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
