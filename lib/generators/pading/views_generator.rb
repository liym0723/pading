
require 'pp'
module Pading
  module Generators
    class ViewsGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../../../../app/views/pading', __FILE__)

      def copy_or_fetch
        return copy_default_views if file_name == 'default'
      end

      private
      def copy_default_views
        # self.class.source_root 它将返回其路径名 -> E:/lym_project/gem/pading/app/views/pading/*.html.erb"
        file = File.join self.class.source_root, "*.html.erb"

        # 遍历目录下的全部文件 取出name. 拷贝
        Dir.glob(file).map{|f| File.basename f}.each do |f|
          copy_file f, view_path_for(f)
        end
      end


      # 拷贝到的文件路径
      def view_path_for file
        ['app','views',views_prefix,'pading', File.basename(file)].compact.join("/")
      end

      def views_prefix
        options[:views_prefix].try(:to_s)
      end
    end
  end
end

