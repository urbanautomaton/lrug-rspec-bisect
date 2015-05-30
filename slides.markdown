# [fit] Test Bisection

![filter](images/bison.jpg)

---

# Order-Dependent
# Test Failures

---

![inline](images/suite_pass.png)

---

![inline](images/suite_fail.png)

---

![inline](images/suite_fail_big.png)

---

# Bisection Algorithm

1. Fix order
2. Remove half the tests preceding the failure
3. Rerun the remainder
  - **pass**: remove the **other** half, goto **3**
  - **fail**: goto **2** with remaining tests

---

![inline](images/alg_1.png)

---

![inline](images/alg_2.png)

---

![inline](images/alg_3.png)

---

![inline](images/alg_4.png)

---

![inline](images/alg_5.png)

---

![inline](images/alg_6.png)

---

![inline](images/alg_7.png)

---

![inline](images/alg_8.png)

---

![inline](images/alg_9.png)

---

![inline](images/alg_10.png)

---

![inline](images/alg_11.png)

---

# [fit] Booooooring

---

# [fit] Booooooring

# (also, hard)

---

![](images/bison.jpg)

# [fit] `$ rspec --bisect`

^ Can I hide this? [^1]

[^1]:
[https://github.com/rspec/rspec-core/pull/1917](https://github.com/rspec/rspec-core/pull/1917)

---

![inline](images/kitten_spec.png)

---

![inline](images/rspec_bisect_pass.png)

---

![inline](images/rspec_fail.png)

---

![inline](images/rspec_fail_seed.png)

---

![inline](images/rspec_fail_fix_order_not_fast.png)

---

![inline](images/rspec_fail_fix_order.png)

---

![inline](images/rspec_failing_command.png)

---

![inline](images/bisect_run_1.png)


---

![inline](images/bisect_run_2.png)

---

![inline](images/bisect_run_3.png)

---

![inline](images/bisect_run_4.png)

---

![inline](images/bisect_run_5.png)

---

![inline](images/bisect_run_6.png)

---

![inline](images/bisect_run_7.png)

---

![inline](images/bisect_reproduction.png)

---

![inline](images/bisect_reproduction_doc.png)

