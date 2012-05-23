require 'singleton'

module GitLabHook
  class ShorterURL
    include Singleton

    def self.hostname=(url)
      @@hostname = url
    end

    def self.get(token)
      store.get(token)
    end

    def self.set(url)
      # TODO check for duplicate token
      new_token = token
      store.set(new_token, url)
      "#{@@hostname}/#{new_token}"
    end

    private

    def self.store
      uri ||= URI.parse(ENV["REDISTOGO_URL"])
      @@store ||= Redis.new(host: uri.host, port: uri.port, password: uri.password)
    end

    def self.token
      rand(36**8).to_s(36)
    end

  end
end