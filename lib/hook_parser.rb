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

        url = shortener.shorten(gitlab_url)
        msg = "[#{repo_name}] #{url.short_url} #{user_name} - #{message}"

        @messages << msg
      end
    end

  end
end