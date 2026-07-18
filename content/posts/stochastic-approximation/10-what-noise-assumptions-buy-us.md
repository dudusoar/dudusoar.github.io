---
title: "What the Noise Assumptions Actually Buy Us"
date: 2026-07-17
draft: false
weight: 10
hiddenInHomeList: true
description: "Zero mean, finite variance, independence, and identical distribution each support a different part of noise averaging."
tags: ["stochastic approximation", "noise", "variance", "independence"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 10 of 22

Preserving history helps only when the history contains enough signal to average out the noise. The usual noise assumptions explain when that hope is justified.

In the river analogy, $\eta_k$ is not the wind or the echo itself. It is the location error produced after those physical disturbances affect your judgment:

$$
\eta_k=\text{target}_k-w^*.
$$

The assumptions describe the errors in the inferred target.

## Four Assumptions, Four Jobs

- **Zero mean:** errors do not systematically push the estimate in one direction.
- **Finite variance:** errors have a controllable scale.
- **Independence:** repeated observations do not merely repeat the same hidden error.
- **Identical distribution:** old and new observations have comparable statistical quality.

Together, they make historical averaging a way to reduce noise rather than preserve bias.

## Zero Mean Prevents Systematic Drift

If:

$$
\mathbb{E}[\eta_k]=0,
$$

then:

$$
\mathbb{E}[\text{target}_k]
=
\mathbb{E}[w^*+\eta_k]
=
w^*.
$$

The observation is unbiased. If instead every target has mean $w^*+b$, the iteration is pulled toward the wrong location. Averaging cannot remove a bias shared by every sample.

## Finite Variance Makes Averaging Effective

The constant-step analysis gives:

$$
\operatorname{Var}(w_k)
=
\sum_{i=0}^{k-1}
\alpha^2(1-\alpha)^{2i}
\operatorname{Var}(\eta_{k-1-i}).
$$

To bound this sum, the noise variances must be bounded by a finite common scale. A small coefficient cannot make an infinite variance finite.

### Heavy-Tailed Counterexample

A standard Cauchy random variable has density:

$$
f(x)=\frac{1}{\pi}\frac{1}{1+x^2}.
$$

Its tails are so heavy that even $\mathbb{E}[|\eta_k|]$ does not exist. More importantly, the average of independent standard Cauchy variables has the same distribution:

$$
\frac{1}{n}\sum_{i=1}^n\eta_i
\sim
\operatorname{Cauchy}(0,1).
$$

The average does not narrow as more observations arrive.

### Sparse Explosions

Consider:

$$
\eta_k=
\begin{cases}
0, & \text{with probability }1-\frac{1}{k^2},\\
+k^2, & \text{with probability }\frac{1}{2k^2},\\
-k^2, & \text{with probability }\frac{1}{2k^2}.
\end{cases}
$$

Its expectation is zero, but:

$$
\operatorname{Var}(\eta_k)
=
\mathbb{E}[\eta_k^2]
=
k^2
\longrightarrow\infty.
$$

Most observations are harmless, but occasional extreme errors grow with time. Preserving history can become a way to remember disasters.

## Independence Removes Covariance Terms

For a weighted sum:

$$
\operatorname{Var}\left(\sum_i a_i\eta_i\right)
=
\sum_i a_i^2\operatorname{Var}(\eta_i)
+
2\sum_{i<j}a_ia_j\operatorname{Cov}(\eta_i,\eta_j).
$$

Independence makes the covariance terms zero. Without it, positively correlated errors can move together and defeat averaging.

In the extreme case $\eta_k=\eta_0$ for every $k$, all observations repeat the same error. Then:

$$
\operatorname{Var}(w_k)
=
\left[1-(1-\alpha)^k\right]^2\sigma^2
\longrightarrow\sigma^2.
$$

No matter how many observations are averaged, the shared error remains.

## Identical Distribution Keeps History Comparable

If every disturbance has variance $\sigma^2$, the old and new observations have comparable quality.

Without this condition, the environment may change. For example:

$$
\operatorname{Var}(\eta_k)=k
$$

makes recent observations increasingly noisy. Because recent observations receive the largest weights, the geometric decay of older weights may not control the growing variance.

The reverse change also causes friction: if early observations are noisy and later observations are clean, preserving too much old history slows adaptation.

## What the Assumptions Mean

Each assumption protects a different property:

| Assumption | What it protects |
|---|---|
| Zero mean | Correct average direction |
| Finite variance | Controllable disturbance magnitude |
| Independence | No persistent covariance across observations |
| Identical distribution | Comparable information quality over time |

The assumptions do not say the forest must be quiet. They say repeated judgments must contain enough independent, unbiased, bounded information for history to reduce error.
