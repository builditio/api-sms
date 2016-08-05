require 'twilio-ruby'

class Message < ActiveRecord::Base

    ## SCHEMA (start) ===========================================================
    self.table_name = :messages
    self.primary_key = :message_id
    ## SCHEMA (end)

    ## VALIDATIONS (start) ======================================================
    before_validation :set_defaults
    validates :message_id, length: { maximum: 32 }, allow_blank: false
    validates :from_number, length: { maximum: 20 }, allow_blank: false
    validates :to_number, length: { minimum: 10 }, allow_blank: false
    validates :body, length: { maximum: 200 }, allow_blank: false
    ## VALIDATIONS (end)

    ## MEDIA (Start) ============================================================
    mount_uploader :media_file, MediaUploader
    ## MEDIA (End)

    ## HOOKS (Start) ============================================================
    after_commit :deliver_message
    ## HOOKS (End)

    ## ASSOCIATIONS (start) =====================================================
    ## ASSOCIATIONS (end)

    ## CLASS HELPERS (start) ====================================================
    ## CLASS HELPERS (end)

    ## INSTANCE HELPERS (start) =================================================

    # Basic hook to set defaults on the entity prior to validation.
    # The primary key, message_id will be a unique UUID, and will only be generated
    # if it is not set.
    # The from number is also required and as such will default to a preconfigured
    # default from_number if unset.
    def set_defaults
        self.message_id  ||= Api::Sms::Util::Uuid.generate
        self.from_number ||= APP_CONFIG[:default_from]
    end # def set_defaults

    # Current implementation is synchronous, connecting to Twilio and issuing a request
    # to send the message. All messages are accepted unless request is malformed.
    # As Twilio sends asynchronously, we have not immediate knowledge that the message
    # was in fact sent. Follow-up requests or a registered callback would be required in order
    # to determine the actual delivery state.
    # This method is required to support the delivery to multiple to_number(s), defined
    # in a comma delimitted string. Twilio does not however support receiving multiple numbers
    # in a single request, so we are required to issue multiple requests.
    # Be sure that the media_url is valid and that the asset can be found, otherwise the
    # request will fail.
    def deliver_message
        # set up a client to talk to the Twilio REST API
        @client = Twilio::REST::Client.new APP_CONFIG[:account_sid], APP_CONFIG[:auth_token]
        # Iterate over each to_number and issue request
        to_number.split(',').each do |to_num|
          begin
            options = {from: from_number, to: to_num, body: body}
            options.merge!(media_url: media_url) unless media_url.blank?
            options.merge!(media_url: prepare_media_file_url) unless self.media_file.file.nil?
            @client.account.messages.create(options)
          rescue => e
              logger.error "[ERROR] #{e.message}"
          end
        end
    end # def deliver_message

    # Returns the full URI of the associated asset. Current implementation utilizes
    # CarrierWave, storing the
    def prepare_media_file_url
      self.media_file.url
    end # def prepare_media_file_url

    ## INSTANCE HELPERS (end)


end # class Message
