# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Haml::Template.options[:ugly] = true
