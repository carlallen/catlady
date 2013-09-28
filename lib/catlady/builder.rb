module Catlady
  class Builder
    require 'fileutils'

    def self.build(distribution)
      new(distribution).build
    end

    def initialize(distribution)
      @distribution = distribution
      @configuration = config["configuration"]
      @sdk = config["sdk"]
      @scheme = config["scheme"]
    end

    def build
      increment_version
      `xcodebuild -scheme "#{@scheme}" -configuration #{@configuration} -sdk #{@sdk} archive PROVISIONING_PROFILE="#{uuid}"`
    end


    def increment_version
      app_info = Plist::parse_xml("AppInfo.plist")
      app_info["CFBundleVersion"] = (app_info["CFBundleVersion"].to_i + 1).to_s
      Plist::Emit.save_plist(app_info, "AppInfo.plist")
    end

    def uuid
      @uuid ||= install_provision_profile
    end

    def install_provision_profile
      pp_uuid=`grep UUID -A1 -a #{profile_file} | grep -o "[-A-Z0-9]\{36\}"`
      FileUtils.mv(profile_file,
                   File.expand_path("~/Library/MobileDevice/Provisioning\ Profiles/#{pp_uuid}.mobileprovision"))
      pp_uuid
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
      @profile_file ||= agent.download_profile(profile)
    end
  end
end