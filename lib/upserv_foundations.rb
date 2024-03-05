# frozen_string_literal: true

require_relative 'upserv_foundations/version'

# Helpers
require 'upserv_foundations/helpers/components/elements/link_to_helper'
require 'upserv_foundations/helpers/components/forms/form_groups_helper'
require 'upserv_foundations/helpers/components/forms/inline_errors_helper'
require 'upserv_foundations/helpers/components/forms/search_bar_helper'
require 'upserv_foundations/helpers/components/forms/search_select_helper'
require 'upserv_foundations/helpers/components/pages/card_helper'
require 'upserv_foundations/helpers/components/pages/modal_helper'
require 'upserv_foundations/helpers/components/pages/page_helper'
require 'upserv_foundations/helpers/components/pages/table_helper'
require 'upserv_foundations/helpers/components/pages/tabs_helper'
require 'upserv_foundations/helpers/components/ui/dropdown_helper'
require 'upserv_foundations/helpers/components/ui/tooltip_helper'
require 'upserv_foundations/helpers/misc_methods_helper'

# Helper Classes
if defined? ActionView::Base
  ActionView::Base.include UpservFoundations::Components::Elements::LinkToHelper
  ActionView::Base.include UpservFoundations::Components::Forms::FormGroupsHelper
  ActionView::Base.include UpservFoundations::Components::Forms::InlineErrorsHelper
  ActionView::Base.include UpservFoundations::Components::Forms::SearchBarHelper
  ActionView::Base.include UpservFoundations::Components::Forms::SearchSelectHelper
  ActionView::Base.include UpservFoundations::Components::Pages::CardHelper
  ActionView::Base.include UpservFoundations::Components::Pages::ModalHelper
  ActionView::Base.include UpservFoundations::Components::Pages::PageHelper
  ActionView::Base.include UpservFoundations::Components::Pages::TableHelper
  ActionView::Base.include UpservFoundations::Components::Pages::TabsHelper
  ActionView::Base.include UpservFoundations::Components::Ui::DropdownHelper
  ActionView::Base.include UpservFoundations::Components::Ui::TooltipHelper
  ActionView::Base.include UpservFoundations::MiscMethodsHelper
end

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end

  # Make the asset files available to Rails applications
  class Engine < ::Rails::Engine
    initializer 'upserv_foundations.assets' do |app|
      app.config.assets.paths << root.join('vendor', 'assets', 'stylesheets')
      app.config.assets.paths << root.join('vendor', 'assets', 'fonts')
      app.config.assets.paths << root.join('lib', 'upserv_foundations', 'javascript')
      # stuff I tried to get JS to autoload and failed miserably
      # have to use |= because << tries to modify a frozen array while |= creates a new one (basically allowing you to modify a frozen array by replacing it)
      # app.config.autoload_paths |= [root.join('lib', 'upserv_foundations', 'javascript', 'controllers')]
      # app.config.assets.paths << root.join('lib', 'upserv_foundations', 'javascript', 'controllers')
      # app.config.autoload_paths << root.join('lib', 'upserv_foundations', 'javascript', 'lib')
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
