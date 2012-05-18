require 'rubygems'
require 'bundler/setup'
require_relative 'lib/gitlab_tweet'

include GitLabTweet

Bundler.require

configure do
  TwitterClient = GitLabTweet::TwitterClient.new(config_path: 'config/twitter.yml')
  GitLabTweet::ShorterURL.hostname = YAML.load_file('config/gitlab_tweet.yml')['hostname']
end

get '/:token' do
  token = params[:token]
  if url = ShorterURL.get(token)
    redirect url, 302
  else
    halt 404, "URL with token #{token} not found."
  end
end

post '*' do
  tweets = GitLabTweet::HookParser.new(json: request.body.read, shortener: GitLabTweet::ShorterURL).tweets
  tweets.each do |tweet|
    TwitterClient.update(tweet)
  end
  ""
end
