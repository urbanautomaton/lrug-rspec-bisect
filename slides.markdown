
# [fit] Bisecting Kittens

---

# [fit] 10 minutes
# [fit] an unreleased command-line flag

---

![](images/atom_bomb.jpg)

# `$ git commit --atrocities`[^1]

[^1]:
[https://twitter.com/whitequark/status/589958268623151104](https://twitter.com/whitequark/status/589958268623151104)

---

![](images/bison.jpg)

# `$ rspec --bisect`

---

![filter](images/kitten.jpg)

# Kitten Spec

---

# A passing suite

![](images/kitten.jpg)

![inline](images/rspec_bisect_pass.png)

---

# A passing suite?

![filter](images/kitten.jpg)

![inline](images/rspec_fail.png)

---

![filter](images/kitten.jpg)

![inline](images/rspec_fail_doc.png)

---

# Bisect to the rescue!

![filter](images/kitten.jpg)

![inline](images/rspec_bisect_output.png)

---

# Bisect to the rescue!

![filter](images/kitten.jpg)

![inline](images/rspec_minimal_repro.png)

---

```ruby
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
```
