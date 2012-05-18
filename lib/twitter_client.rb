module GitLabTweet
  class TwitterClient

    attr_reader :client

    def initialize(options)
      config = YAML.load_file(options[:config_path])
      config = symbolize_keys(config)
      @client = Twitter::Client.new(config)
    end

    def update(tweet)
      client.update(tweet)
    end

    private

    def symbolize_keys(hash)
      h = {}
      hash.each_pair do |key, value|
        h[(key.to_sym rescue key)] = hash[key]
      end
      h
    end

  end
end