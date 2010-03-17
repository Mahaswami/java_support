unless Object.const_defined? 'CLASS_PATH'
    Object.const_set "CLASS_PATH", []
end

module JavaSupport
  def self.included(klass)
    klass.class_eval do
      if RUBY_PLATFORM == 'java'
        include JrubyInterface
      else
        include YajbInterface
      end
    end
  end
end
