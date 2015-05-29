require 'spec_helper'

RSpec.describe "A kitten" do

  it "is totally innocent" do
    expect(ENV["guilty"]).to be_falsey
  end

  it("is fluffy")               {  }
  it("likes string")            {  }
  it("fears hoovers")           {  }
  it("likes laser pointers")    {  }
  it("is cute")                 {  }
  it("meows")                   {  }
  it("purrs")                   {  }
  it("likes being skritched")   {  }
  it("loves catnip")            {  }
  it("sits in cardboard boxes") {  }
  
  it "WILL DESTROY EVERYTHING YOU HOLD DEAR, MUHAHAHAHAHAHAAAAA" do
    ENV["guilty"] = "true"
  end

end
