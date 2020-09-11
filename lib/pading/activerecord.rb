require 'active_support/lazy_load_hooks' # 允许 Rails 延迟加载部分组件，从而加快应用的启动速度

ActiveSupport.on_load :active_record do
  require 'pading/activerecord/active_record_extension'

  # ActiveRecordExtension 加入 record
  # class 为 ActiveRecord  可以调用里面的方法
  ::ActiveRecord::Base.send :include, Pading::ActiveRecordExtension
end
