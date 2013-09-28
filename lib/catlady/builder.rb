module Catlady
  class Builder
    def self.build(distribution)
      new(distribution).build
    end

    def initialize(distribution)
      @distribution = distribution
      @configuration = config["configuration"]
      @sdk = config["sdk"]
    end

    def build
      `xcodebuild -configuration #{@configuration} -sdk #{@sdk} PROVISIONING_PROFILE=#{profile_file}`
    end

    def agent
      @agent ||= Catlady::Agent.new(config["apple_account"]["apple_id"],
                                   config["apple_account"]["password"])
    end

    def config
      @config ||= Catlady::Config[@distribution]
    end

    def profile
      @profile ||= agent.list_profiles(config["provisioning_profile"]["type"].to_sym).find do |profile|
        profile.name == config["provisioning_profile"]["name"]
      end
    end

    def profile_file
      @profile_file = agent.download_profile(profile)
    end
  end
end