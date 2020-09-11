require 'active_support/inflector'
require 'pading/actionview/paginator'
module Pading
  module HelperMethods

    def test_paginate(scope, paginator_class: Pading::Actionview::Paginator, template: nil, **options)
      # scope.class -> User::ActiveRecord_Relation
      # 所以能调用 PageScopeMenthods 下面的方法

      options[:total_pages] ||= scope.total_pages
      options.reverse_merge! current_page: scope.current_page, per_page: scope.limit_value, remote: false

      # 最后返回的 其实是一个渲染好的模板。
      paginator = paginator_class.new (template || self), options
      paginator.to_s

    end
  end
end