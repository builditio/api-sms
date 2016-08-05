class V1::ApidocsController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'SMS Service Definition'
      key :description, 'Welcome to the Pinnacol RESTful Service API framework. ' \
                        'This service is responsible for providing SMS related ' \
                        'infrastructure services to all Pinnacol applications.'
      key :termsOfService, 'http://helloreverb.com/terms/'
      contact do
        #key :name, 'Created by the Pinnacol Assurance Application Serices Team'
      end

    end

    tag do
      key :name, 'message'
      key :description, 'Message Operations'
    end

    key :host, 'api-sms.dev'
    key :basePath, '/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
      V1::MessagesController,
      Message,
      ErrorModel,
      self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
