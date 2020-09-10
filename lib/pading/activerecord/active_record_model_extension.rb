# 不 引入就 会找不到 Pading::PageScopeMethods
require 'pading/activerecord/page_scope_menthods'
module Pading
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    included do

    eval <<-RUBY, nil, __FILE__, __LINE__ + 1
        def self.#{Pading.config.page_method_name}(num=nil)
          per_page = Pading.config.default_per_page
          num = (num.to_i - 1) < 0 ? 0 : num - 1

          limit(per_page).offset(per_page * num).extending do
            include Pading::PageScopeMethods
          end
        end
     RUBY

    end
  end
end
