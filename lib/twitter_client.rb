module GitLabHook
  class TwitterClient

    attr_reader :client

    def self.load
      client = new.client
    end

    def initialize
      config = GitLabHook::Config.config
      @client = Twitter::Client.new(config[:twitter])
    end

    def update(msg)
      msg = msg[0..136] + '...' if msg.size > 140
      client.update(msg)
    end

  end
end