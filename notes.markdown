# Outline

* Intro
* Order dependent failures
* Bisection:
  - Fix order
  1. Remove half of the preceding tests
  2. rerun tests
    * pass: remove *other* half, goto 2)
    * fail: goto 1) with remaining tests
* diagram
* RSpec sorting
* Example suite
* Passing run
* Failing run!
* Fix order, fail fast
* RSpec ordering digression
* Bisect!


So I'm here because of a bet, that I couldn't pitch and deliver a talk
about a single command-line flag for a single executable.

Here to show you something that could literally save your life.

Well, 30 minutes of your life. In certain circumstances. It doesn't
repel crocodiles or anything.

* Order dependent tests
* Manuel bisection
  - binary search, exactly as if we were real programmers
* Automated bisection
  - binary search, exactly as if we were button pressers


USE THIS FOR RSPEC BISECT

https://dwigif.appspot.com/

WITH THE BISON
