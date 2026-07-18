---
title: "Dvoretzky's Theorem Turns Noisy Contraction into Pathwise Convergence"
date: 2026-07-17
draft: false
weight: 15
hiddenInHomeList: true
description: "Dvoretzky generalizes the stochastic-approximation error recursion and gives conditions for almost-sure convergence."
tags: ["stochastic approximation", "Dvoretzky", "almost sure convergence", "Robbins-Monro"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 15 of 22

Dvoretzky's convergence theorem abstracts the stochastic-approximation error recursion into:

$$
\Delta_{k+1} =
(1-\alpha_k)\Delta_k
+
\beta_k\eta_k.
$$

It states that if old error is contracted persistently, the noise is conditionally unbiased, and the accumulated noise strength is finite, then the error converges to zero almost surely.

## The Missing Result

The earlier parts derived:

$$
\Delta_{k+1} =
(1-\alpha_k)\Delta_k
+
\alpha_k\eta_k,
$$

along with:

$$
\sum_k\alpha_k=\infty,
\qquad
\sum_k\alpha_k^2<\infty,
$$

and basic noise assumptions such as:

$$
\mathbb{E}[\eta_k]=0,
\qquad
\operatorname{Var}(\eta_k)<\infty.
$$

These conditions explain the mechanism: learning cannot stop too early, and the influence of noise must decay. What remains is a theorem connecting the mechanism to the conclusion:

$$
\Delta_k\to0.
$$

In the river analogy, we want more than a claim about average routes. We want to know whether almost every possible night journey eventually reaches the river.

## Historical Context

The original Robbins–Monro problem sought the root of an unknown function:

$$
M(x^*)=c.
$$

The function $M(x)$ is not directly available. At the current point $x_k$, an experiment returns only:

$$
Y_k=M(x_k)+\text{noise}.
$$

The estimate must be updated while data arrive. This setting combines several constraints:

- observations arrive sequentially rather than as one batch;
- the function or system may be a black box;
- individual observations are noisy;
- the estimate must be updated online.

Dvoretzky's 1956 theorem moved beyond one particular root-finding formula. It identified conditions under which a general noisy contraction recursion converges.

The theorem is not a new algorithm. It is a convergence framework for a class of incremental stochastic processes.

## The Stability Pattern

The theorem isolates a simple structure:

$$
\text{convergence}
\approx
\text{persistent contraction}
+
\text{controlled disturbance}.
$$

If:

- the average disturbance direction is unbiased;
- its second moment is bounded;
- the cumulative disturbance strength is finite;
- the contraction does not disappear too early;

then the noise cannot overpower the long-run movement toward zero.

The proof does not follow the sign of $\Delta_k$ directly. It studies the squared error:

$$
h_k=\Delta_k^2.
$$

This turns a signed, oscillating error into a nonnegative energy process. The proof then analyzes:

$$
\mathbb{E}[h_{k+1}-h_k\mid\mathcal{H}_k].
$$

That conditional increment connects the recursion to quasi-martingale and supermartingale convergence tools.

## Why the Noise Coefficient Becomes Beta

In the original update:

$$
\Delta_{k+1} =
(1-\alpha_k)\Delta_k
+
\alpha_k\eta_k,
$$

the same coefficient controls:

1. how strongly old error contracts;
2. how strongly new noise enters.

A general convergence theorem separates these roles:

$$
\Delta_{k+1} =
(1-\alpha_k)\Delta_k
+
\beta_k\eta_k.
$$

Now:

- $\alpha_k$ is the contraction coefficient;
- $\beta_k$ is the noise-injection coefficient.

In the basic river update, the fraction that corrects the route also determines how much of the sound error enters the new position. Dvoretzky separates those effects to cover more general stochastic recursions.

The original stochastic-approximation model is the special case:

$$
\beta_k=\alpha_k.
$$

For a concrete reading, suppose the traveler is $20$ meters east of the river, so $\Delta_k=20$. If $\alpha_k=0.1$, contraction alone reduces the old error to $18$ meters. If the current sound judgment has error $\eta_k=30$ meters and $\beta_k=0.02$, the new disturbance contributes another $0.6$ meter, giving:

$$
\Delta_{k+1}=0.9\cdot20+0.02\cdot30=18.6.
$$

The two coefficients make the analytical separation visible: $\alpha_k$ controls how old route error is contracted, while $\beta_k$ controls how strongly the new judgment error enters. In the basic river update they happen to be the same coefficient.

## A Working Statement of the Theorem

Let:

$$
\Delta_{k+1} =
(1-\alpha_k)\Delta_k
+
\beta_k\eta_k,
$$

where $\Delta_k$ is the error, $\alpha_k\ge0$ is the contraction coefficient, $\beta_k\ge0$ is the noise coefficient, and $\eta_k$ is the random disturbance.

Let $\mathcal{H}_k$ contain the history available before step $k$, including the current state and previous disturbances and coefficients.

Assume, along almost every sample path:

$$
\sum_k\alpha_k=\infty,
$$

$$
\sum_k\alpha_k^2<\infty,
$$

$$
\sum_k\beta_k^2<\infty.
$$

Also assume conditional unbiasedness and a bounded conditional second moment:

$$
\mathbb{E}[\eta_k\mid\mathcal{H}_k]=0,
\qquad
\mathbb{E}[\eta_k^2\mid\mathcal{H}_k]\le C.
$$

Then:

$$
\Delta_k\xrightarrow{\mathrm{a.s.}}0.
$$

Conditional unbiasedness is stronger and more relevant than ordinary zero mean. The current state already contains past disturbances, so the next disturbance must remain unbiased even after that history is known.

## Recover the Original Update

For:

$$
\beta_k=\alpha_k,
$$

the condition:

$$
\sum_k\beta_k^2<\infty
$$

becomes the Robbins–Monro condition:

$$
\sum_k\alpha_k^2<\infty.
$$

The theorem therefore says:

> If the step sizes satisfy the Robbins–Monro conditions and the noise remains conditionally unbiased with bounded second moment, then the error converges to zero almost surely.

The earlier expectation and variance arguments explain why the conditions are plausible. Dvoretzky turns them into a statement about almost every random path.
