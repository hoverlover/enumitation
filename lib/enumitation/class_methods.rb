module Enumitation
  module ClassMethods

    def self.extended(base)
      # If we've already been extended, don't do it again
      return if defined? base.enumitation_values

      class << base
        attr_accessor :enumitation_values
      end

      base.enumitation_values = {}
    end

    def select_options_for(attribute)
      return [] if enumitation_values.empty?

      enumitation_values[attribute].map do |val|
        [display_value(attribute, val), val]
      end
    end

    private

    def display_value(attribute, val)
      # Try looking up using i18n.  If nothing found, just return the val.

      I18n.t(val,
             :scope => "enumitation.models.#{self.name.underscore}.#{attribute.to_s.underscore}",
             :default => val)
    end

    def add_inclusion_validation(attribute, values)
      self.validates_inclusion_of attribute, :in => values
    end
  end
end
