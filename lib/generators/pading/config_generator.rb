
require 'pp'
module Pading
  module Generators

    class ConfigGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      desc "copy config to initializers"
      def copy_config_file
        # 复制文件到指定目录
        pp "copy test"

        template 'pading_config.rb', 'config/initializers/pading_config.rb'
      end
    end
  end
end

