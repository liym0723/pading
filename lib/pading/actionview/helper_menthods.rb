# 变形器将单词从单数转换为复数，将类名转换为表名，将模块化类名转换为不带名，将类名转换为外键。
# 复数形式，单数形式和不可数单词的默认变形会保留在inflections.rb中
require 'active_support/inflector'
require 'pading/actionview/paginator'
module Pading
  module HelperMethods

    def test_paginate(scope, paginator_class: Pading::Actionview::Paginator, template: nil, **options)
      # scope.class -> User::ActiveRecord_Relation
      # 所以能调用 PageScopeMenthods 下面的方法

      options[:total_pages] ||= scope.total_pages
      options.reverse_merge! current_page_number: scope.current_page, per_page: scope.limit_value, remote: false

      # 最后返回的 其实是一个渲染好的模板。
      paginator = paginator_class.new (template || self), options

      paginator.to_s

    end
  end
end