require 'spec_helper'

module Catlady
  describe Builder do
    it "should fetch the provisioning profile" do
      builder = Builder.new("qa")
      debugger
      builder.profile_file.should_not be_nil
    end
  end
end