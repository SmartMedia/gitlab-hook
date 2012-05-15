require 'rubygems'
require 'bundler/setup'

Bundler.require

configure do
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

get '/:token' do
  if url_original = REDIS.get(params[:token])
    redirect url_original, 302
  else
    halt 404, "URL not found"
  end
end

post '*' do
  twitter = Twitter::Client.new(
    :consumer_key => "ZlD8gk1vdHqC0vCvWKTstw",
    :consumer_secret => "dBXeUOmAcCxxdrnzOeD2Xr9xQeBOStU1qfyNNVHXY",
    :oauth_token => "430986497-y5Bb6jBEYRsLr5GeDfwrR5VRLkrSsa6d5p8xsntw",
    :oauth_token_secret => "8hbVNTzoxJISTX0KOaaBeyA6mHsrAkS2mt2y62rkJhQ"
  )

  body = JSON.parse(request.body.read)

  commits = body['commits']
  repo_name = body['repository']['name']

  commits.each do |commit|
    user_name = commit['author']['name']
    url_original = commit['url']
    url_token = nil
    url_token = rand(36**8).to_s(36)
    REDIS.set(url_token, url_original)
    message = commit['message']
    url = "http://smartgitlab.heroku.com/#{url_token}"
    message = "[#{repo_name}] #{url} #{user_name} - #{message}"
    message = message[0..136] + '...' if message.size > 140

    # puts message

    twitter.update(message)
  end
  ""
end
