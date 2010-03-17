# Include hook code here

require 'java_support'
if RUBY_PLATFORM == 'java'
  require 'jruby_interface'
else
  require 'yajb_interface'
end