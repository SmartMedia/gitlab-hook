module GitLabTweet
  class HookParser
    attr_reader :body, :tweets, :shortener

    def initialize(options)
      @tweets = []
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
        tweet = "[#{repo_name}] #{url} #{user_name} - #{message}"
        tweet = tweet[0..136] + '...' if tweet.size > 140

        @tweets << tweet
      end
    end

  end
end