module Api::Sms::Json::Resource

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.send(:extend, ClassMethods)
  end # def self.included

  module InstanceMethods
  end # module InstanceMethods

  module ClassMethods

    def hello name
      puts "Hello #{name}"
    end

  end # module ClassMethods

end # module Api::Sms::Json::Resource
