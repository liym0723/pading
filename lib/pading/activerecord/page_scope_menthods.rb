module Pading
  module PageScopeMethods

    def per(num, max_per_page: nil)

      if (n = num.to_i ) < 0 ||  !(/^\d/ =~ num.to_s)
        self
      elsif n.zero? # zero 是否为0
        limit(n)
      else
        per_page = Pading.config.default_per_page
        limit(n).offset(per_page * (n - 1))
      end

      limit(1).offset(2)
    end

  end
end