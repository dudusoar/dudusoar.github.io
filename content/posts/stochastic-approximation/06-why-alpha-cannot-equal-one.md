---
title: "Why Alpha Cannot Equal One Under Persistent Noise"
date: 2026-07-17
draft: false
weight: 6
hiddenInHomeList: true
description: "With alpha equal to one, every update discards history and inherits the full error of the latest noisy target."
tags: ["stochastic approximation", "step size", "noise", "variance"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 6 of 22

Step sizes above one can amplify noise and overshoot the target. But what about $\alpha=1$? Without noise, it reaches the target in one step. Under persistent noise, the same choice becomes a memoryless update.

## The Argument in One Chain

The logic is:

1. With no noise, $\alpha=1$ reaches $w^*$ immediately.
2. With noise, it becomes $w_{k+1}=w^*+\eta_k$ and discards all history.
3. With $\alpha<1$, the update retains both the old estimate and the new observation.
4. Both updates can be unbiased, but the history-preserving update can have lower variance.
5. That advantage depends on assumptions about the noise: zero mean, finite variance, independence, and identical distribution in the simplified analysis.
6. If $\alpha$ must remain one, convergence requires the noise itself to vanish.

## What Changes When Alpha Equals One

The general update is:

$$
w_{k+1}=(1-\alpha)w_k+\alpha(w^*+\eta_k).
$$

At $\alpha=1$:

$$
w_{k+1}=w^*+\eta_k.
$$

The new estimate contains no trace of $w_k$. In the river analogy, every new sound erases the route implied by all previous sounds. You move directly to the latest estimated river location, including its full error.

With $0<\alpha<1$:

$$
w_{k+1}=(1-\alpha)w_k+\alpha(w^*+\eta_k).
$$

Only part of the latest error enters the new state, while earlier observations remain encoded in $w_k$.

## The Central Trade-Off

If the noise is unbiased, both mechanisms can center their estimates around $w^*$. Their variances differ:

- $\alpha=1$ leaves the full variance of one observation in every update.
- $\alpha<1$ averages multiple observations through the state and can reduce that variance.

The point is not that history eliminates noise. History weakens the influence of any single noisy observation.

Under persistent real-world noise, $\alpha<1$ trades mechanism design for tolerance: we control the step size so that we do not need the environment to become noiseless.
