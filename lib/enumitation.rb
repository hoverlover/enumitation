module Enumitation
  autoload :ClassMethods, 'enumitation/class_methods'

  ActiveRecord::Base.class_eval do
    def self.inherited(subclass)
      subclass.extend ClassMethods
      super
    end
  end
end
