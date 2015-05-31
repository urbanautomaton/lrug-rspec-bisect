<!-- vim: set textwidth=0 : -->

# [fit] Test Bisection

![filter](images/bison.jpg)

^ I'm going to talk to you very quickly about test bisection, which is a very handy technique for debugging order-dependent test failures...

---

# Order-Dependent
# Test Failures

^ ...when one or more of your passing tests causes a subsequent test to fail.

^ So you'll be programming away, and you'll run your tests, and they look like this:

---

![inline](images/suite_pass_big.png)

^ "Great!" you think, "I have done the programming well today." 

^ And to get another minor hit, you decide to run your tests again, and then *this* happens:

---

![inline](images/suite_fail_big.png)

^ And it's quarter to 6, and you're tired, and you've got two options:

^
1. Push it, hope it passes on CI and becomes some other sucker's problem
2. Fix it

^ And we are of course professionals with respect for our colleagues, so we sigh, and set about fixing it.

^ We know we can get rid of all the examples *after* the failure...

---

![inline](images/suite_trim_big.png)

^ ...but now we've got to find which of the preceding examples is the culprit, and how do we do that?

^ Well, we can use a technique called binary search, also known as bisection, and it's one which of course I, as a web developer, use all the time

---

![](images/fireworks.jpg)

# Days since last
# implemented
# binary search:

# ~~1729~~
# 0

^ But it is fundamentally very simple, and it goes like this:

---

# Bisection Algorithm

1. Fix test order
2. Remove half the tests preceding the failure
3. Rerun the remainder plus the failure:
  - **PASS**: remove the **other** half, **goto** **3**
  - **FAIL**: **goto** **2** with remaining tests

Repeat until `remainder.length == 1`

^
1. Make sure your tests repeatably run in the same sequence
2. Delete half of the tests!
3. See if your failure has gone

^ Simplified: this assumes there's only one culprit, but the full algorithm is only slightly more complicated.

^ So you fix your tests in the failing order, and you run them again to make sure...

---

![inline](images/alg_1.png)

^ Then you remove half the preceding tests...

---

![inline](images/alg_2.png)

^ ...and the failure disappears...

---

![inline](images/alg_3.png)

^ ...so you try the *other* half...


---

![inline](images/alg_4.png)

^ ...and the failure comes back...


---

![inline](images/alg_5.png)

^ ...so you take half again...

---

![inline](images/alg_6.png)

^ ...and the failure's still there...

---

![inline](images/alg_7.png)

^ ...so you take half again...

---

![inline](images/alg_8.png)

^ ...and the failure disappears...

---

![inline](images/alg_9.png)

^ ...so you take the *other* half...

---

![inline](images/alg_10.png)

^ ...and the failure is back...

---

![inline](images/alg_11.png)

^ ...and there's only one left...

---

![inline](images/alg_12.png)

^ so you win!

^ All you have to do now is debug the actual problem.

---

# [fit] Great!

---

# [fit] Great!
# (but, boring)

---

# [fit] Great!
# (but, boring)
# (also, hard)

^ But you know what's good at doing boring, hard, repetitive tasks?

^ Computers!

^ Enter `rspec --bisect`

---

![](images/specs.jpg)
![](images/bison_crop.jpg)

# [fit] `$ rspec --bisect`

^ Can I hide this? [^1]

^ So let's have a look at a fairly typical bit of professional programming, which I think speaks for itself:

[^1]:
[https://github.com/rspec/rspec-core/pull/1917](https://github.com/rspec/rspec-core/pull/1917)

---

![inline](images/kitten_spec.png)

^ So here we've got a pretty comprehensive suite of tests for our kitten, and I think we could all look at this for a long time and no-one would find any possible problems contained therein.


^ So we run our kitten spec, feeling pretty confident, and indeed it passes

---

![inline](images/kitten_spec_1.png)

---

![inline](images/kitten_spec_2.png)

---

![inline](images/kitten_spec_3.png)

---

![inline](images/kitten_spec_4.png)

---

![inline](images/kitten_spec_5.png)

---

![inline](images/kitten_spec_6.png)

---

![inline](images/bisect_run_1.png)

^ ...and now **all we need to do** is stick `--bisect` on the end...

---

![inline](images/bisect_run_2.png)

^ ...and let it go

---

![inline](images/bisect_run_3.png)

^ it just runs through the same algorithm I outlined, recursively searching within the preceding tests for ones that are necessary for the failure to be observed

---

![inline](images/bisect_run_4.png)

---

![inline](images/bisect_run_5.png)

---

![inline](images/bisect_run_6.png)

---

![inline](images/bisect_run_7.png)

---

![inline](images/bisect_run_8.png)

---

![inline](images/bisect_repro_1.png)

---

![inline](images/bisect_repro_2.png)

---

![inline](images/bisect_repro_3.png)

---

![inline](images/kitten_spec.png)

---

# [fit] Okay, how do I get it?

---

# [fit] RSpec 3.3 (unreleased)

![inline](images/gemfile.png)

---

![left](images/myron.jpg)

# [fit] Thanks are due to...

# [fit] Myron
# [fit] Marston

# [fit] And the rest of the RSpec core team

---

# [fit] What about minitest?

There's a gem for that:

[https://github.com/seattlerb/minitest-bisect](https://github.com/seattlerb/minitest-bisect)

---

# Order-dependent pitfalls

---

# Global state...

```ruby
it "changes the locale" do
  I18n.locale = :de
  # stuff...
  # stuff...
  # stuff...
  # stuff...
  # oops, didn't put the locale back
end
```

---

# Global state... Global state...

```ruby
it "stubs out the time" do
  Timecop.safe_mode = false
  Timecop.freeze(Time.now)
  # stuff...
  # stuff...
  # stuff...
  # oops, didn't put the time back
end
```

---

# Global state... Global state... Glob

```ruby
it "changes the environment" do
  ENV["SOMETHING"] = "hello"
  # stuff...
  # stuff...
  # stuff...
  # stuff...
  # oops, didn't put the env back
end
```

---

# It hurts when I do this

---

# Don't do that

---

# Don't do that
# (eh...)

---

# Do it a bit safer

---

# Helpers

```ruby
def with_locale(locale, &block)
  original_locale = I18n.locale
  I18n.locale = locale
  block.call
ensure
  I18n.locale = original_locale
end
```

---

# Helpers

```ruby
it "changes the locale safely" do
  with_locale(:de) do
    # stuff...
    # stuff...
    # stuff...
    # stuff...
  end
end
```

---

# Helpers

```ruby
RSpec.describe "German proverbs" do
  around(:each) do |example|
    with_locale(:de) { example.call }
  end

  it "ist dicker als Wasser"                   {  }
  it "beißt nicht in die Hand, die es füttert" {  }
end
```

---

# Fin.

![](images/fin.jpg)
