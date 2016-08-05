APP_CONFIG = YAML.load_file(Rails.root.join('config', 'twilio.yml'))[Rails.env]["twilio"].symbolize_keys!
