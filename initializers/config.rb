module Muzak
  def self.config
    OpenStruct.new(
      echonest_api_key: yaml['echonest']['api_key'],
      echonest_consumer_key: yaml['echonest']['consumer_key'],
      echonest_shared_secret: yaml['echonest']['shared_secret'],
      wunderground_api_key: yaml['wunderground']['api_key']
    )
  end
  
  private

  def self.yaml
    @yaml ||= YAML.load_file('config/muzak.yml')
  end
end  
