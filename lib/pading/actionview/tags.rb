module Pading
    module Actionview
        PARAM_KEY_BLACKLIST = [:authenticity_token, :commit, :utf8, :_method, :script_name].freeze
        class Tag

            def initialize(template, params: {}, theme: nil, views_prefix: nil, **options)
                @template, @theme, @views_prefix, @options = template, theme, views_prefix, options
                @params = template.params
                # @params in Rails 5 no longer inherits from Hash
                @params = @params.to_unsafe_h if @params.respond_to?(:to_unsafe_h)
                @params = @params.with_indifferent_access
                @params.except!(*PARAM_KEY_BLACKLIST)
                @params.merge! params
            end


            def page_url_for(page)
                @template.url_for @params.update(:test_page => page)
            end

            def to_s(locals = {})
                @template.render partial: partial_path, locals: @options.merge(locals), formats: [:html]
            end

            def partial_path
                [
                    @views_prefix,
                    "pading",
                    @theme,
                    self.class.name.demodulize.underscore
                ].compact.join("/")
            end

            module Link
                def page
                    raise '用实际页面值覆盖页面以将其替换为页面。'
                end
                def url
                    page_url_for page
                end
                def to_s(locals = {}) #:nodoc:
                    locals[:url] = url
                    super locals
                end
            end

            class Page < Tag
                include Link
                def page
                    @options[:page]
                end
                def to_s(locals = {}) #:nodoc:
                    locals[:page] = page
                    super locals
                end
            end
            class FirstPage < Tag
                include Link
                def page
                    1
                end
            end

            class LastPage < Tag
                include Link
                def page
                   1
                end
            end

            class PrevPage < Tag
                include Link
                def page
                   1
                end
            end

            class NextPage < Tag
                include Link
                def page
                   1
                end
            end

            class Gap < Tag
            end


        end
    end

end


