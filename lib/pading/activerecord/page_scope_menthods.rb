module Pading
  module PageScopeMethods

    def per(num, max_per_page: nil)
      # offset_value  limit_value 元编程自动生成的查询
      if (n = num.to_i ) < 0 ||  !(/^\d/ =~ num.to_s)
        self
      elsif n.zero? # zero 是否为0
        limit(n)
      else
        limit(n).offset(offset_value / limit_value * n)
      end
    end


    # 获取当前page
    def current_page
      (offset_value / limit_value) + 1
    end


    def total_count(column_name = :all, _options = nil)
      return @total_count if defined?(@total_count) && @total_count
      c = except(:offset, :limit, :order)
      c = c.except(:includes) unless references_eager_loaded_tables?
      c = c.count(column_name)
      @total_count = if c.is_a?(Hash) || c.is_a?(ActiveSupport::OrderedHash)
                       c.count
                     elsif c.respond_to? :count
                       c.count(column_name)
                     else
                       c
                     end

    end

    def total_pages
      (total_count.to_f / limit_value).ceil
    end


    def next_page
      current_page + 1 unless last_page?
    end

    def prev_page
      current_page - 1 unless first_page?
    end

    def first_page?
      current_page == 1
    end

    def last_page?
      current_page == total_pages
    end

  end
end