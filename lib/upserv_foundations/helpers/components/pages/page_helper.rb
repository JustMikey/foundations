# frozen_string_literal: true

module UpservFoundations
  module Components
    module Pages
      # pages
      module PageHelper
        # def page_max_width_default
        #   @page_max_width_default ||= '2500'
        # end

        # def page_min_width_default
        #   @page_min_width_default ||= '0px'
        # end

        # def page_container(options = {}, &block)
        #   options[:id] = 'page-container'
        #   content_tag 'DIV', options do
        #     block.call
        #   end
        # end

        # def page_header(options = {}, &block)
        #   options[:id] =  'page-header-container'
        #   options[:style] ||= nil
        #   assign_page_header_or_body_style(options)
        #   content_tag 'DIV', options do
        #     block.call
        #   end
        # end

        # def page_body(options = {}, &block)
        #   options[:id] = 'page-body-max-width'
        #   assign_page_header_or_body_style(options)
        #   content_tag 'DIV', id: 'page-body' do
        #     content_tag 'DIV', options do
        #       block.call
        #     end
        #   end
        # end

        # def assign_page_header_or_body_style(options)
        #   base_style = "min-width: #{yield(:page_min_width).presence || '0px'}; max-width: #{yield(:page_max_width).presence || page_max_width_default};"
        #   options[:style] = "#{base_style}#{" #{options[:style]}" if options[:style]}"
        # end

        # def table_page_body(options = {}, &block)
        #   options[:for_table] = true
        #   page_body(options, block)
        # end

        def page_body_columns(options = {}, &block)
          options[:block] = block
          options[:style] ||= nil
          concat(render('global/components/pages/page_body_columns', options))
        end

        def page_body_column(options = {}, &block)
          options[:block] = block
          options[:style] ||= nil
          options[:klass] = options[:class]
          concat(render('global/components/pages/page_body_column', options))
        end
      end
    end
  end
end