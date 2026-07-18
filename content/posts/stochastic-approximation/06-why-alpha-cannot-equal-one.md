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
3. With $\alpha<1$, the new position retains weight from the previous position as well as the new judgment.
4. Both updates can be unbiased, but the history-preserving update can have lower variance.
5. That advantage depends on assumptions about the noise: zero mean, finite variance, independence, and identical distribution in the simplified analysis.
6. If $\alpha$ must remain one, convergence requires the noise itself to vanish.

## What Changes When Alpha Equals One

The traveler executes $w_{k+1}=(1-\alpha)w_k+\alpha\text{target}_k$. After the analyst substitutes $\text{target}_k=w^*+\eta_k$, this becomes:

$$
w_{k+1}=(1-\alpha)w_k+\alpha(w^*+\eta_k).
$$

At $\alpha=1$:

$$
w_{k+1}=w^*+\eta_k.
$$

The new position contains no weighted contribution from $w_k$. In the river analogy, every new sound sends you directly to the latest inferred river location, including its full error.

With $0<\alpha<1$:

$$
w_{k+1}=(1-\alpha)w_k+\alpha(w^*+\eta_k).
$$

Only part of the latest error enters the new state, while earlier observations remain encoded in $w_k$.

## The Central Trade-Off

If the noise is unbiased, both mechanisms can center their positions around $w^*$ in expectation. Their variances differ:

- $\alpha=1$ leaves the full variance of one observation in every update.
- $\alpha<1$ averages multiple observations through the state and can reduce that variance.

The point is not that history eliminates noise. History weakens the influence of any single noisy observation.

Under persistent real-world noise, $\alpha<1$ trades mechanism design for tolerance: we control the step size so that we do not need the environment to become noiseless.

## A Concrete Memoryless Route

Suppose four consecutive sound judgments place the riverbank at 90, 115, 70, and 105 meters. With $\alpha=1$, your position jumps through exactly those four coordinates. The third judgment sends you back to 70 meters, regardless of everything heard before it.

With $0<\alpha<1$, each judgment changes only part of the route. This does not remove the sound error; it prevents one judgment from determining the entire position.
