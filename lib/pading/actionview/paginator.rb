require 'active_support/inflector'
require 'pading/actionview/tags'

module Pading
  module Actionview
  class Paginator < Tag

    def initialize(template, **options)
      @template = template
      @options = options
      @options[:current_page] = PageProxy.new(@options, options[:current_page_number])
      #
      # undefined method `safe_append='
      # 允许写 多个 <% %>
      @output_buffer = if defined?(::ActionView::OutputBuffer)
                         ::ActionView::OutputBuffer.new
                       elsif template.instance_variable_get(:@output_buffer)
                         # instance_variable_get 获取并返回对象的实例变量的值。 如果未定义实例变量，则返回nil
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
      # Kaminari.config.window = 1
      window = 1
      each_start = @options[:current_page_number] - 1 - window
      each_end = @options[:current_page_number] + 1 + window
      each_start = 1 if each_start < window
      each_end = @options[:total_pages] if each_end > @options[:total_pages]

      (each_start..each_end).each do |page|
        yield PageProxy.new(@options,page)
      end

    end


    def page_tag(page)
     Page.new @template, @options.merge(page: page)
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
        @page == @options[:current_page_number] - 1
      end

      def next?
        @page == @options[:current_page_number] + 1
      end

      def display_tag?
        (@options[:current_page_number] - @page ).abs <= 1
      end


      def current?
        @options[:current_page_number] == @page
      end

      def rel
        if next?
          '下一页'
        elsif prev?
          '上一页'
        end
      end


      def to_s #:nodoc:
        @page.to_s
      end

    end
  end


  end
end
