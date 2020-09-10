require 'active_support/lazy_load_hooks' # 允许 Rails 延迟加载部分组件，从而加快应用的启动速度

ActiveSupport.on_load :action_view do
  # 加载 helper
end
