<!-- vim: set textwidth=0 : -->

# [fit] Test Bisection

![filter](images/bison_4_3.jpg)

^ I'm going to talk to you very quickly about test bisection, which is a very handy technique for debugging order-dependent test failures...

---

# Order-Dependent
# Test Failures

^ ...when one or more of your passing tests causes a subsequent test to fail.

^ The good news is, most modern test frameworks will randomise test order, to flush out bugs exactly like this.

^ The *bad* news is, most modern test frameworks will randomise test order, to flush out bugs exactly like this, so at 5.45 on a Friday your tests will look like this:

---

![inline](images/suite_pass_big.png)

^ and you'll think, "Great! I have done the programming well today." 

^ but for some reason you run the tests again, and all of a sudden for no apparent reason they look like this:

---

![inline](images/suite_fail_big.png)

^ We've not changed anything here, but one moment our tests passed, and one moment they didn't.

^ So now we've got two options:

^
1. Push it, hope it passes on CI and becomes some other sucker's problem
2. Fix it

^ And we are of course professionals with respect for our colleagues, so we sigh, and set about fixing it.

^ So, which of these horrid little green dots is causing our failure?

^ Well, unless something profoundly eldritch is going on, we know we can ignore all of the test cases *after* the failure...

---

![inline](images/suite_trim_big.png)

^ ...but now we've got to find which of the preceding examples is the culprit, and how do we do that?

^ Well, we can use a technique called binary search, also known as bisection

---

# Bisection
# (AKA Binary Search)

^ Binary search, as applied to this problem, goes like this.

---

# Fix test order
![inline](images/alg_1.png)

^ Our first item of business is to fix the order that our tests are running in, so we've got a repeatable failure.

^ Then we start the actual bisection by ignoring half of the previous tests...

---

# Take half the candidates
![inline](images/alg_2.png)

^ ...and the failure disappears, so the half we ignored is implicated

---

# Pass!
![inline](images/alg_3.png)

^ ...so you try the *other* half...


---

# Take other half
![inline](images/alg_4.png)

^ ...and the failure comes back...

---

# Fail!
![inline](images/alg_5.png)

^ ...so you take half again...

---

# Take half of new set
![inline](images/alg_6.png)

^ ...and the failure's still there...

---

# Fail!
![inline](images/alg_7.png)

^ ...so you take half again...

---

# Take half of new set
![inline](images/alg_8.png)

^ ...and the failure disappears...

---

# Pass!
![inline](images/alg_9.png)

^ ...so you take the *other* half...

---

# Take other half
![inline](images/alg_10.png)

^ ...and the failure is back...

---

# Fail!
![inline](images/alg_11.png)

^ ...and there's only one left...

---

# Done!
![inline](images/alg_12.png)

^ so you win!

^ All you have to do now is debug the actual problem.

---

# [fit] Great!

^ Okay, so that's great - in complexity terms, we've reduced an O(n) problem to an O(log n) one.

---

# [fit] Great!
# (but, boring)

^ however, when you're doing things by hand, even log n is pretty dull, and as well as that

---

# [fit] Great!
# (but, boring)
# (also, hard)

^ it's actually pretty hard, at least with current versions of RSpec, to maintain a consistent test order while cutting down the set of tests you're running.

^ Fortunately, computers are pretty good at doing boring, repetitive tasks, and RSpec itself is pretty good at controlling its own test order.

^ Enter `rspec --bisect`

---

![](images/bison_4_3.gif)

# [fit] `$ rspec --bisect`[^1]

<!--
^ Can I hide this? [^1]
-->

^ So this is a new feature that was merged a few weeks ago and is landing in RSpec 3.3, which automates more-or-less the algorithm I just outlined (more on the 'more or less' later).

^ So let's have a look at a fairly typical bit of professional programming, which I think speaks for itself:

[^1]:
[https://github.com/rspec/rspec-core/pull/1917](https://github.com/rspec/rspec-core/pull/1917)

---

![inline](images/kitten_spec.png)

^ So here we've got a pretty comprehensive suite of tests for a kitten, and if you look particularly hard, you'll notice it contains a subtle order-dependent bug.

^ Let's ignore it for the moment though, for the sake of dramatic tension.

---

![inline](images/kitten_spec_1.png)

^ So we run our kitten spec, feeling pretty confident...

---

![inline](images/kitten_spec_2.png)

^ and indeed it passes. Great!

---

![inline](images/kitten_spec_3.png)

^ but we run it again...

---

![inline](images/kitten_spec_4.png)

^ ...and this time it fails. :-(

---

![inline](images/kitten_spec_5.png)

^ Nothing's changed between these two runs, so we instantly suspect an order-dependent failure.

^ RSpec provides the seed it used to randomise the order for our failing test run, so we can add that to our command to fix the order.

---

![inline](images/kitten_spec_6.png)

^ And now we've got a repeatable failure.

^ Normally, this is where the hard work would start, particularly if we had more than the 12 examples this test contains.

---

![inline](images/bisect_run_1.png)

^ But now all we need to do is stick `--bisect` on the end...

---

![inline](images/bisect_run_2.png)

^ ...and let it go!

---

![inline](images/bisect_run_3.png)

^ It begins by running the entire failing set, to discover which failures it expects, and record the set and order of candidate culprits.

^ It then starts the bisection proper, recursively searching within the preceding tests for ones that are necessary for the failure to be observed.

---

![inline](images/bisect_run_4.png)

^ First it looks to halve the original candidate set...

---

![inline](images/bisect_run_5.png)

^ ...then it tries to halve it again...

---

![inline](images/bisect_run_6.png)

^ ...and so on in such manner...

---

![inline](images/bisect_run_7.png)

^ ...until it reaches a single possible culprit.

---

![inline](images/bisect_run_8.png)

^ Then, finally, it spits out a single minimised command for reproducing the failure.

---

![inline](images/bisect_repro_1.png)

^ All we have to do is take that command, paste it in...

---

![inline](images/bisect_repro_2.png)

^ ...and I'm adding the documentation formatter so we can see what it runs, then we just run it.

---

![inline](images/bisect_repro_3.png)

^ And we can now see from our output that our culprit is "a kitten WILL DESTROY EVERYTHING YOU HOLD DEAR" etc.

^ So we can go back to our spec, hunt down that example, and lo and behold...

---

![inline](images/kitten_spec.png)

^ It becomes reasonably apparent what the problem is.

---

# "More or less"

^ So I said RSpec implements "more or less" the algorithm I illustrated earlier. Well, in the case where there's a single culprit example, it does indeed follow exactly the same procedure.

^ However, order-dependent failures could be more complex than that. You could have a situation where two or more passing tests make accumulating changes that cause a failure, but only when they happen together. If you tried to apply the algorithm I showed, you might get this result:

---

# Fix order

![inline](images/multi_1.png)

^ You'd start with the same failure and candidates

---

# Remove half...

![inline](images/multi_2.png)

^ You'd remove half, and your failure would go away...

---

# Pass!

![inline](images/multi_3.png)

---

# Remove other half...

![inline](images/multi_4.png)

^ But then when you removed the other half...

---

# ???

![inline](images/multi_5.png)

^ The failure would still be missing.

^ RSpec copes with this case by then starting to search for discontiguous blocks of examples to remove.

---

# Order-dependent pitfalls

^ I've got a very quick digression here into some common pitfalls that lead to order-dependent test failures. I hope this will be useful if you don't have any existing order-dependent failures but would like to try out this RSpec feature.

^ So roughly speaking order-dependent test failures break down into three categories.

---

# Globals...

```ruby
it "has a weird craving for Spätzle" do
  I18n.locale = :de
  # stuff...
  # stuff...
  # stuff...
  # stuff...
  # oops, didn't put the locale back
end
```

^ First up is global state. So for example the `i18n` gem stores the current locale as a global variable. So if you want to test something in a German locale, you have to mutate this global state, and you have to remember to put it back again afterwards, otherwise later tests that may have implicit assumptions about the current locale could fail.

---

# Globals... Globals...

```ruby
it "misses Vanilla Ice" do
  Time.stubs(
    now: Time.parse("Mon Jul 02 1990")
  )
  # stuff...
  # stuff...
  # oops, didn't put the time back
end
```

^

---

# Globals... Globals... Glob

```ruby
it "like, cares about the environment" do
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

# ~~Don't do that~~
# Do it a bit safer

---

# Helpers

```ruby
def with_locale(locale)
  original_locale = I18n.locale
  I18n.locale = locale
  yield
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

# Fin.

![](images/fin.jpg)

^ That's all I've got - I will now accept 30 seconds of trolling from the RSpec core team member in the room.
