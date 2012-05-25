require 'erb'

module GitLabHook
  class Config

    def self.config
      load
    end

    private

    def self.load
      @@hash ||= symbolize_keys(YAML.load(ERB.new(File.read('config/gitlab_hook.yml.erb')).result))
    end

    def self.symbolize_keys(hash)
      hash.inject({}) do |options, (key, value)|
        value = symbolize_keys(value) if value.is_a?(Hash)
        options[(key.to_sym rescue key) || key] = value
        options
      end
    end

  end
end