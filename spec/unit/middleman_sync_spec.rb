require "spec_helper"

describe Middleman::Sync do

  describe :version do
    subject { Middleman::Sync::VERSION }
    it { should be_kind_of(String) }
  end

  describe :middleman do

    it "should get some data" do
      @app = middleman_app("glob-app")
      @app.class.should == Middleman::Application::MiddlemanApplication1
    end

  end

end