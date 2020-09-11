require 'active_support/inflector'
require 'pading/actionview/tags'

module Pading
  module Actionview
  class Paginator < Tag

    def initialize(template, **options)
      @template = template
      @options = options
      @options[:current_page] = PageProxy.new(@options, options[:current_page_num])

      @output_buffer = if defined?(::ActionView::OutputBuffer)
                         ::ActionView::OutputBuffer.new
                       elsif template.instance_variable_get(:@output_buffer)
                         template.instance_variable_get(:@output_buffer).class.new
                       else
                         ActiveSupport::SafeBuffer.new
                       end
    end


    def to_s(locals = {})
      super @options.merge paginator: self
    end


    def render(&block)
      # total_pages 总页数 大于 1 就渲染从出来
      # instance_eval 将您的块作为一个块传递给instance_eval
      instance_eval(&block) if @options[:total_pages] > 1
      @output_buffer
    end


    %w[first_page prev_page next_page last_page gap].each do |tag|
      eval <<-RUBY, nil, __FILE__, __LINE__ + 1
          def #{tag}_tag
            pp "#{tag.classify}"
            @last = #{tag.classify}.new @template, @options
          end
      RUBY
    end


    def each_page

    end


    def page_tag(page)
      @last = Page.new @template, @options.merge(page: page)
    end

    class PageProxy
      include Comparable

      def initialize(options, page)
        @options, @page = options, page
      end

      def first?
        @page == 1
      end

      def last?
        @page == @options[:total_pages]
      end

      def prev?
        @page == @options[:current_page] - 1
      end

      def next?
        @page == @options[:current_page] + 1
      end


    end
  end


  end
end
