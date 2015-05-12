require 'spec_helper'

RSpec.describe "Multiple contributions" do

  it "adds a little bit" do
    ENV["THING"] = (ENV["THING"].to_i + 5).to_s
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "adds a little bit more" do
    ENV["THING"] = (ENV["THING"].to_i + 5).to_s
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "is a boring test" do
    expect(true).to be_truthy
  end

  it "naively expects global state to be left alone" do
    expect(ENV["THING"].to_i < 10).to be_truthy
  end

end
