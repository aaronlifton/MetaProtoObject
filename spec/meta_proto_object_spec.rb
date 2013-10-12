# encoding: UTF-8

require_relative '../lib/meta_proto_object.rb'

describe "MetaProtoObject" do
  it "should use lambda alias correctly" do
    let :x, λ {|e| e + 1}
    x(1).should == 2
  end
end