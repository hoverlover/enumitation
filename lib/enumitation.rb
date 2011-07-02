module Enumitation
  autoload :ClassMethods, 'enumitation/class_methods'

  ActiveRecord::Base.instance_eval do
    def enumitation(attribute, values)
      extend ClassMethods

      self.enumitation_values[attribute] = Array(values)
      add_inclusion_validation(attribute, values)
    end
  end
end
