class AppConfig < Sinatra::Base
  def self.configuration
      YAML.load_file("#{settings.root}/config.yml")[settings.environment.to_s]
  end

  def self.database
    configuration["database"]
  end

  def self.memcache_connection
    configuration["memcache_connection"]
  end

  def self.token_expire_seconds
    configuration["token_expire_seconds"]
  end
end
