require 'rubygems'
require 'bundler/setup'
require_relative 'lib/gitlab_hook'

include GitLabHook

Bundler.require

configure do
  TwitterClient.config(path: 'config/twitter.yml')
  CONFIG = YAML.load_file('config/gitlab_tweet.yml')
  ShorterURL.hostname = CONFIG['hostname']
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
  access_token = params[:access_token]
  if access_token != CONFIG['access_token']
    halt 403, "Please provide correct access_token."
  else
    messages = GitLabHook::HookParser.new(json: request.body.read, shortener: ShorterURL).messages
    messages.each do |tweet|
      TwitterClient.update(tweet)
    end
    ""
  end
end
