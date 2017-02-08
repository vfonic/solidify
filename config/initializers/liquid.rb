# Liquid::Template.error_mode = :strict

module Liquid
  # Include allows templates to relate with other templates
  #
  # Simply include another template:
  #
  #   {% include 'product' %}
  #
  # Include a template with a local variable:
  #
  #   {% include 'product' with products[0] %}
  #
  # Include a template for a collection:
  #
  #   {% include 'product' for products %}
  #
  class Include < Tag
    def read_template_from_file_system(context)
      @variable_name_expr = ''
      # rubocop:disable all
      file_system = context.registers[:file_system] || Liquid::Template.file_system

      file_system.read_template_file(context.evaluate(@template_name_expr), context)
      # rubocop:enable all
    end
  end

  # This implements an abstract file system which retrieves template files
  # named in a manner similar to Rails partials, ie. with the template name
  # prefixed with an underscore. The extension ".liquid" is also added.
  #
  # For security reasons, template paths are only allowed to contain letters,
  # numbers, and underscore.
  #
  # Example:
  #
  # file_system = Liquid::LocalFileSystem.new("/some/path")
  #
  # file_system.full_path("mypartial")
  # # => "/some/path/_mypartial.liquid"
  # file_system.full_path("dir/mypartial")
  # # => "/some/path/dir/_mypartial.liquid"
  #
  # Optionally in the second argument you can specify a custom pattern for
  # template filenames.
  # The Kernel::sprintf format specification is used.
  # Default pattern is "_%s.liquid".
  #
  # Example:
  #
  # file_system = Liquid::LocalFileSystem.new("/some/path", "%s.html")
  #
  # file_system.full_path("index") # => "/some/path/index.html"
  #
  class LocalFileSystem
    # rubocop:disable all
    def full_path(template_path)
      full_path = if template_path.include?('/'.freeze)
        File.join(root, File.dirname(template_path), @pattern % File.basename(template_path))
      else
        File.join(root, @pattern % template_path)
      end

      raise FileSystemError, "Illegal template path '#{File.expand_path(full_path)}'" unless File.expand_path(full_path).start_with?(File.expand_path(root))

      full_path
    end
    # rubocop:enable all
  end
end

module Liquid
  module Rails
    class FileSystem < ::Liquid::LocalFileSystem
      def read_template_file(template_path, context)
        @pattern = @pattern.gsub(/^_/, '')
        theme = context.registers[:theme]
        template_path = "themes/#{theme.id}/snippets/#{template_path}"

        super
      end
    end

    class TemplateHandler
      # rubocop:disable all
      def render(template, local_assigns = {})
        @view.controller.headers['Content-Type'] ||= 'text/html; charset=utf-8'

        assigns = if @controller.respond_to?(:liquid_assigns, true)
          @controller.send(:liquid_assigns)
        else
          @view.assigns
        end
        assigns['content_for_layout'] = @view.content_for(:layout) if @view.content_for?(:layout)
        assigns.merge!(local_assigns.stringify_keys)

        liquid = Liquid::Template.parse(template)
        # rubocop:enable all

        rendered_template = liquid.render(
          assigns,
          filters: filters,
          # strict_variables: true,
          # strict_filters: true,
          registers: {
            view: @view, controller: @controller, helper: @helper,
            theme: @view.assigns['theme']
          }
        )

        if liquid.errors.present?
          if ::Rails.env.development? || ::Rails.env.test?
            errors_text = liquid.errors.map(&:to_s).join("\n")
            ::Rails.logger.error(errors_text)
          end

          raise liquid.errors.first
        end

        rendered_template
      end
    end

    # rubocop:disable all
    class PaginateTag < ::Liquid::Block
      def render(context)
        @context = context

        context.stack do
          collection = @context[@collection_name].presence || @context.environments[0][@collection_name]

          if collection.present?
            if collection.is_a? Array
              paginated_collection = Kaminari.paginate_array(collection.to_a).page(current_page).per(@page_size)
            elsif collection.respond_to?(:page)
              paginated_collection = collection.page(current_page).per(@page_size)
            end

            page_count = paginated_collection.total_pages
            pagination = {}
            pagination['collection']      = paginated_collection
            pagination['current_offset']  = (current_page - 1) * @page_size
            pagination['current_page']    = current_page
            pagination['page_size']       = @page_size
            pagination['pages']           = page_count
            pagination['items']           = paginated_collection.total_count
            pagination['previous']        = link('&laquo; Previous'.html_safe, current_page - 1) unless 1 >= current_page
            pagination['next']            = link('Next &raquo;'.html_safe, current_page + 1)     unless page_count < current_page + 1
            pagination['parts']           = []

            hellip_break = false
            if page_count > 1
              1.upto(page_count) do |page|
                if current_page == page
                  pagination['parts'] << no_link(page)
                elsif page == 1
                  pagination['parts'] << link(page, page)
                elsif page == page_count - 1
                  pagination['parts'] << link(page, page)
                elsif (page <= current_page - window_size) || (page >= current_page + window_size)
                  next if hellip_break
                  pagination['parts'] << no_link('&hellip;')
                  hellip_break = true
                  next
                else
                  pagination['parts'] << link(page, page)
                end

                hellip_break = false
              end
            end
            context['paginate'] = pagination
          end

          super
        end
      end
    end
    # rubocop:enable all
  end
end
