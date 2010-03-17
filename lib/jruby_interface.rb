# 
# To change this template, choose Tools | Templates
# and open the template in the editor.

CLASS_PATH.each {|lib| require(lib)}

class Symbol
  def jclass
    self.to_s.constantize
  end
end

module JrubyInterface

  def self.included(klass)
    klass.class_eval do
      require 'java'

      def j_import(klass_name)
        include_class klass_name
      end
  
      def j_new(klass_name, package = nil, params = nil)
        constantized_object = j_class(klass_name, package)
        if params
          constantized_object.new(params)
        else
          constantized_object.new
        end
      end
      
      def j_class(klass_name, package = nil)
        Object.module_eval("#{package}.#{klass_name}", __FILE__, __LINE__)
      end
      
    end  
  end
end

class Date
  def to_java_date
    java_format = "yyyy/MM/dd"
    ruby_format = "%Y/%m/%d"
    formatted = strftime(ruby_format)
    java_formatter = java.text.SimpleDateFormat.new(java_format)
    java_formatter.parse(formatted)
  end
end

class Hash
  def to_java_hash
    java_hash = java.util.HashMap.new
    self.each_pair {|k,v|
      java_value = v
      java_value = v.to_java_hash if v.is_a?(Hash)
      java_value = v.to_java_date if v.is_a?(Date)
      java_hash.put(k.to_s, java_value)
    }
    java_hash
  end
end