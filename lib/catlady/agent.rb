module Catlady
  class Agent
    def self.new(username, password)
      Cupertino::ProvisioningPortal::Agent.new.tap do |agent|
        agent.username = username
        agent.password = password
      end
    end
  end
end
