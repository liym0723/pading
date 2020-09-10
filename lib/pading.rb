require "pading/version"

# 当别的程序 require 'xxx' 的时候， xxx 文件就会被加载。 同名文件负责设定gem 和 API

module Pading
  class Error < StandardError; end
  # Your code goes here...
end

require 'pading/config'
# require 'pading/drawing'
require 'pading/activerecord'
# require 'pading/actionview'