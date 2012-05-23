module GitLabHook
  class HookParser
    attr_reader :body, :messages, :shortener

    def initialize(options)
      @messages = []
      @body = JSON.parse(options[:json])
      @shortener = options[:shortener]
      parse
    end

    private

    def parse
      repo_name = body['repository']['name']
      commits = body['commits']

      commits.each do |commit|
        user_name = commit['author']['name']
        message = commit['message']
        gitlab_url = commit['url']

        url = shortener.set(gitlab_url)
        msg = "[#{repo_name}] #{url} #{user_name} - #{message}"
        msg = msg[0..136] + '...' if msg.size > 140

        @messages << msg
      end
    end

  end
end