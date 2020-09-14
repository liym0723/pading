# 不 引入就 会找不到 Pading::PageScopeMethods
require 'pading/activerecord/page_scope_menthods'
module Pading
  module ActiveRecordModelExtension
    extend ActiveSupport::Concern

    # 解释器使用目标类或模块作为参数调用此方法
    # include Foo -> 执行 do 里面的
    included do

    # eval ->  来为类生成实例方法 可以传把一段 Ruby 代码写在一个字符串中传过去
    # __FILE__, __LINE__  为了更好的debug, 能看到方法在那里定义的
    eval <<-RUBY, nil, __FILE__, __LINE__ + 1
        def self.#{Pading.config.page_method_name}(num=nil)
          per_page = Pading.config.default_per_page
          num = (num.to_i - 1) < 0 ? 0 : num.to_i - 1
          # extending 给一个 scope 增加方法，返回的仍然是 scope.
          # 如果传递的是 block, 则可以直接调用 block 里面的方法, 如
          # 果传递的是 module, 则可以调用 module 里面的方法。
          # 不推荐直接使用，这会大大提高复杂度，但扩展时可以使
          # 用。
          limit(per_page).offset(per_page * num).extending do
            include Pading::PageScopeMethods
          end
          
        end
     RUBY

    end
  end
end
