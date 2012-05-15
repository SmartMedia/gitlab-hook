require 'rubygems'
require 'bundler/setup'

Bundler.require

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
    url = commit['url']
    message = commit['message']

    message = "[#{repo_name}] #{url} #{user_name} - #{message}"
    message = message[0..136] + '...' if message.size > 140

    twitter.update(message)
  end

end
