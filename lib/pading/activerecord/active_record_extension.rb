
require 'pading/activerecord/active_record_model_extension'

module Pading
  module ActiveRecordExtension
    extend ActiveSupport::Concern

    module ClassMethods #:nodoc:
      # Future subclasses will pick up the model extension
      def inherited(kls) #:nodoc:
        # inherited 当前类定义子类时，就会触发此回调
        super
        pp "===1111111111111111111"
        kls.send(:include, Pading::ActiveRecordModelExtension) if kls.superclass == ::ActiveRecord::Base
      end
    end

    included do
      # Existing subclasses pick up the model extension as well
      descendants.each do |kls|
        kls.send(:include, Pading::ActiveRecordModelExtension) if kls.superclass == ::ActiveRecord::Base
      end
    end
  end
end
