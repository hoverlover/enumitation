require 'rubygems'
require 'bundler/setup'

require 'active_record'
require 'enumitation'

RSpec.configure do |config|
  config.mock_with :rr
end

# Stub out AR
ActiveRecord::Base.class_eval do
  alias_method :save, :valid?
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type, null)
  end
end
