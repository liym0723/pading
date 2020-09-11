
module Pading
  class << self
    def configure
      yield config
    end


    def config
      @config ||= Config.new
    end
  end



  class Config
    attr_accessor :default_per_page, :max_per_page, :page_method_name

    def initialize
      @default_per_page = 25 # 每页默认多少数据
      @max_per_page = nil # 最大页数
      @page_method_name = :test_page # 使用功能名称
      @param_name = :test_page
    end


  end
end




