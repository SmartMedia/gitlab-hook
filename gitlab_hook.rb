require 'rubygems'
require 'bundler/setup'
require_relative 'lib/gitlab_hook'

include GitLabHook

Bundler.require

configure do
  CONFIG = Config.load
  TwitterClient.config(CONFIG[:twitter])
  ShorterURL.hostname = CONFIG[:hostname]
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
  if access_token != CONFIG[:access_token]
    halt 403, "Please provide correct access_token."
  else
    messages = HookParser.new(json: request.body.read, shortener: ShorterURL).messages
    messages.each do |tweet|
      TwitterClient.update(tweet)
    end
    ""
  end
end
