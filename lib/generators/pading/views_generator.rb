
require 'pp'
module Pading
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      # source_root 存储并返回定义这个类所在的位置
      # __FILE__ -> E:/lym_project/gem/pading/lib/generators/pading/views_generator.rb"
      # File.expand_path('../../../../app/views/pading', __FILE__) ->E:/lym_project/gem/pading/app/views/pading
      # E:/lym_project/gem/pading/app/views/pading
      source_root File.expand_path('../../../../app/views/pading', __FILE__)

      def copy_or_fetch
        # self.class.source_root 它将返回其路径名 -> E:/lym_project/gem/pading/app/views/pading/*.html.erb"
        # 复制文件到指定文件夹
        FileUtils.cp_r "#{self.class.source_root}/.", 'app/views/pading'
      end

    end
  end
end

