require 'spec_helper'

describe Middleman::Sync do
  describe :version do
    subject { Middleman::Sync::VERSION }
    it { should be_kind_of(String) }
  end
end