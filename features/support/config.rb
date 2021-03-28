# Wrapper for dealing with some predefined settings we're using during the test

class Config

  def initialize
    settings_path = 'config/settings.yml'
    @config = YAML.safe_load(File.read(settings_path))
  end

  def settings
    JSON.parse(@config.to_json, object_class: OpenStruct)
  end

end