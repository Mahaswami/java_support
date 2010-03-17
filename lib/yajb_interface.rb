# 
# To change this template, choose Tools | Templates
# and open the template in the editor.

JBRIDGE_OPTIONS = {:classpath =>  CLASS_PATH.join(":")}

require 'yajb/jbridge'
require 'yajb/jlambda'


include JavaBridge

module YajbInterface
  def self.included(klass)
    klass.class_eval do
      
      def j_import(klass_name)
        jimport klass_name
      end
  
      def j_new(klass_name, package = nil, params = nil)
        if params
          jnew klass_name.to_sym, params
        else
          jnew klass_name.to_sym
        end
      end
      
      def j_class(klass_name, package = nil)
              klass_name.to_sym.jclass
      end
      
    end
  end
end
