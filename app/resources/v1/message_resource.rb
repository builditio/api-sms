class V1::MessageResource < JSONAPI::Resource

  ## METADATA (start) ==========================================================
  model_name 'Message'
  ## METADATA (end)

  ## ATTRIBUTES (start) ========================================================
  attribute :message_id
  attribute :from_number
  attribute :to_number
  attribute :body
  attribute :callback
  attribute :media_url
  ## ATTRIBUTES (end)

  ## FILTERS (start) ===========================================================
  filters :body, :to_number
  ## FILTERS (end)


  ## SORTING (start) ===========================================================
  ## SORTING (end)


end # class V1::MessageResource
