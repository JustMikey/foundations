# frozen_string_literal: true

require_relative 'upserv_foundations/version'

require 'upserv_foundations/helpers/components/ui_helper'
ActionView::Base.include UpservFoundations::Components::UiHelper

# Add all helper files to ActionView::Base
Dir.glob('lib/upserv_foundations/helpers/**/*.rb').each do |file|
  require_file = file.sub('lib/', '').sub(
    '.rb', ''
  )
  require require_file
  # Extract the directory path without "lib/"
  dir_path = File.dirname(file).sub('lib/upserv_foundations/helpers/',
                                    'upserv_foundations/')
  # Convert the directory path to Pascal case without underscores
  class_name = dir_path.split('/').map do |part|
    part.split('_').map(&:capitalize).join
  end.join('::')
  # Add the final module and class name
  class_name += "::#{File.basename(file, '.rb').split('_').map(&:capitalize).join}"
  puts  require_file
  puts  class_name
  # ActionView::Base.include Object.const_get(class_name)
end

# Add things you would want in all rails apps
module UpservFoundations
  class Error < StandardError; end
end
