require 'spec_helper'

describe InfluxDB::Rails::Configuration do
  before do
    @configuration = InfluxDB::Rails::Configuration.new
  end

  describe "#ignore_user_agent?" do
    it "should be true for user agents that have been set as ignorable" do
      @configuration.ignored_user_agents = %w{Googlebot}
      @configuration.ignore_user_agent?("Googlebot/2.1").should be_truthy
    end

    it "should be false for user agents that have not been set as ignorable" do
      @configuration.ignored_user_agents = %w{Googlebot}
      @configuration.ignore_user_agent?("Mozilla/5.0").should be_falsey
    end

    it "should be false if the ignored user agents list is empty" do
      @configuration.ignored_user_agents = []
      @configuration.ignore_user_agent?("Googlebot/2.1").should be_falsey
    end

    it "should be false if the ignored user agents list is inadvertently set to nil" do
      @configuration.ignored_user_agents = nil
      @configuration.ignore_user_agent?("Googlebot/2.1").should be_falsey
    end
  end
  
  describe ".new" do
    context "udp settings" do
      it "should return correct default settings" do
        @configuration.use_udp.should == false
        @configuration.udp_host.should == 'localhost'
        @configuration.udp_port.should == 4444
      end
    end
  end
  
end
