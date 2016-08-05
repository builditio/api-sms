module ApiHelpers
    extend ActiveSupport::Concern

    def self.included(base)
        base.class_eval do
            def self.message_params(context)


                context.parameter do
                    key :name, 'X-APPLICATION-ID'
                    key :in, :header
                    key :description, 'Client application name'
                    key :required, false
                    key :type, :string
                end

                context.parameter do
                    key :name, 'X-TRANSACTION-ID'
                    key :in, :header
                    key :description, 'Client transaction id'
                    key :required, false
                    key :type, :string
                end
            end

            def self.paging_params(context)
                context.parameter do
                    key :name, :page
                    key :in, :query
                    key :description, 'The page number to be fetched'
                    key :required, false
                    key :type, :object
                    items do
                      key :type, :string
                    end
                end

                

              end
        end
    end
end
