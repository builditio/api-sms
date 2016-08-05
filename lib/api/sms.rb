module Api
  module Sms
    module Util; end
    module Json; end
  end
end

require 'api/sms/util/uuid'
require 'api/sms/json/resource'

JSONAPI::Resource.send(:include, Api::Sms::Json::Resource)
