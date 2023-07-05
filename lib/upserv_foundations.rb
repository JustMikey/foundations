# frozen_string_literal: true

require_relative 'upserv_foundations/version'

# Helpers
require 'upserv_foundations/helpers/components/ui_helper'

# Helper Classes
if defined? ActionView::Base
  ActionView::Base.include UpservFoundations::Components::UiHelper
end

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end

  # Make the asset files available to Rails applications
  class Engine < ::Rails::Engine
    initializer 'upserv_foundations.assets' do |app|
      app.config.assets.paths << root.join('vendor', 'assets', 'stylesheets')
      app.config.assets.paths << root.join('app', 'javascript')
      app.config.assets.paths << root.join('lib', 'upserv_foundations', 'javascript')
      # stuff I tried to get JS to autoload and failed miserably
      # app.config.assets.paths << root.join('lib', 'upserv_foundations', 'javascript', 'controllers')
      app.config.autoload_paths << root.join('lib', 'upserv_foundations', 'javascript', 'lib')
      # app.config.autoload_paths << root.join('lib', 'upserv_foundations', 'javascript', 'controllers')
      # was getting "cannot modify frozen string" error so we tried below... but then I realized it's
      # because autoload_paths cannot be used if the file name already exists in the rails app... ex.
      # lib/upserv_foundations/javascript/controllers/dropdown_controller.js here and
      # app/javascript/controllers/dropdown_controller.js in rails app will cause the cannot modify
      # frozen string error so you don't need this prepare stuff (which didn't work anyways)
      # app.config.to_prepare do
      #   paths = Rails.application.config.paths
      #   paths.add 'lib/upserv_foundations/javascript', eager_load: true
      #   paths.add 'lib/upserv_foundations/javascript/controllers', eager_load: true
      #   paths.add 'app/javascript', eager_load: true
      #   paths.add 'app/javascript/controllers', eager_load: true
      # end
    end
  end
end

# app.config.eager_load_paths << File.expand_path('javascript', __dir__)
# app.config.autoload_paths << root.join('lib', 'upserv_foundations', 'javascript')
