require 'rubygems'
require 'bundler/setup'
require_relative 'lib/gitlab_hook'

include GitLabHook

Bundler.require

configure do
  CONFIG = GitLabHook::Config.load
  TwitterClient = Twitter::Client.new(CONFIG[:twitter])
  Bitly.use_api_version_3
  BitlyClient = Bitly.new(CONFIG[:bitly][:username], CONFIG[:bitly][:api_key])
end

post '*' do
  access_token = params[:access_token]
  if access_token != CONFIG[:access_token]
    halt 403, "Please provide correct access_token."
  else
    messages = HookParser.new(json: request.body.read, shortener: BitlyClient).messages
    messages.each do |tweet|
      TwitterClient.update(tweet)
    end
    ""
  end
end
