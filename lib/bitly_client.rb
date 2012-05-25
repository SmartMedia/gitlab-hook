module GitLabHook
  class BitlyClient

    attr_reader :client

    def initialize
      config = GitLabHook::Config.config
      Bitly.use_api_version_3
      @client = Bitly.new(config[:bitly][:username], config[:bitly][:api_key])
      return client
    end

  end
end
