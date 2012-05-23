require 'singleton'

module GitLabHook
  class TwitterClient
    include Singleton

    def self.config(options)
      config = YAML.load_file(options[:path])
      config = config.symbolize_keys
      @@client = Twitter::Client.new(config)
    end

    def self.update(tweet)
      @@client.update(tweet)
    end

  end
end