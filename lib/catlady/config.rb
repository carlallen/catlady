module Catlady
  class Config
    require 'yaml'

    def self.yml_file
      @yml_file ||= fetch_yml_file
    end

    def self.fetch_yml_file
      filename = ENV["CATLADY_YML"] || "catlady.yml"
      if File.exist?(filename)
        YAML.load_file(filename)
      else
        raise CatldayYMLError
      end
    end

    def self.[](key)
      if yml_file.include?(key)
        yml_file[key]
      else
        raise CatladyMissingKeyError.new(key)
      end
    end


    class CatldayYMLError < StandardError
      def initialize(msg=nil)
        super(msg || "Missing catlday.yml")
      end
    end

    class CatladyMissingKeyError < StandardError
      def initialize(key)
        super("Missing key '#{key}' in catlady.yml")
      end
    end
  end
end