module GitLabHook
  class BitlyClient

    attr_reader :client

    def initialize
      config = GitLabHook::Config.config
      @client = Bitly.new(config[:bitly][:username], config[:bitly][:api_key])
      Bitly.use_api_version_3
    end

  end
end
