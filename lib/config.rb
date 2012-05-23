require 'erb'

module GitLabHook
  class Config
    
    def self.load
      hash = YAML.load(ERB.new(File.read('config/gitlab_hook.yml.erb')).result)
      hash = symbolize_keys(hash)
    end

    private

    def self.symbolize_keys(hash)
      hash.inject({}) do |options, (key, value)|
        options[(key.to_sym rescue key) || key] = value
        options
      end
    end

  end
end