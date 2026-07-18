---
title: "Expand the Error into Initial Bias and Historical Noise"
date: 2026-07-17
draft: false
weight: 18
hiddenInHomeList: true
description: "The explicit error formula separates the residual initial condition from the weighted sum of all past disturbances."
tags: ["stochastic approximation", "error recursion", "noise", "convergence"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 18 of 22

The recursion:

$$
\Delta_{k+1} =
(1-\alpha_k)\Delta_k
+
\beta_k\eta_k
$$

can be expanded into two sources of error:

$$
\Delta_k =
\left[
\prod_{i=0}^{k-1}(1-\alpha_i)
\right]\Delta_0
+
\sum_{j=0}^{k-1}
\left[
\prod_{i=j+1}^{k-1}(1-\alpha_i)
\right]\beta_j\eta_j.
$$

The first term carries the initial error. The second carries the entire history of disturbances.

## Expand the First Steps

At the first update:

$$
\Delta_1=(1-\alpha_0)\Delta_0+\beta_0\eta_0.
$$

At the second:

$$
\begin{aligned}
\Delta_2
&=(1-\alpha_1)\Delta_1+\beta_1\eta_1\\
&=(1-\alpha_1)
\left[(1-\alpha_0)\Delta_0+\beta_0\eta_0\right]
+\beta_1\eta_1\\
&=(1-\alpha_1)(1-\alpha_0)\Delta_0\\
&\quad+(1-\alpha_1)\beta_0\eta_0
+\beta_1\eta_1.
\end{aligned}
$$

Continuing this substitution yields the general formula above.

## Put Numbers into the Expansion

Suppose the river is at $100$ meters and the traveler starts at $0$, so $\Delta_0=-100$. Let the first two judgment errors be $\eta_0=20$ and $\eta_1=-10$. Then:

$$
\Delta_2=
(1-\alpha_1)(1-\alpha_0)(-100)
+(1-\alpha_1)\beta_0(20)
+\beta_1(-10).
$$

The three terms have distinct meanings: residual starting error, the surviving effect of the first mistaken judgment, and the newly injected second judgment error. The formula is bookkeeping for the route's entire causal history.

## The Residual Initial Error

The term:

$$
\left[
\prod_{i=0}^{k-1}(1-\alpha_i)
\right]\Delta_0
$$

is the remaining influence of the starting point. Each update multiplies it by another contraction factor.

In the river analogy, this is the part of the current error caused by where the journey began. Persistent movement toward the target repeatedly shrinks it.

## The Accumulated Historical Noise

The term:

$$
\sum_{j=0}^{k-1}
\left[
\prod_{i=j+1}^{k-1}(1-\alpha_i)
\right]\beta_j\eta_j
$$

contains every disturbance.

Noise $\eta_j$ enters with strength $\beta_j$. Each later update then attenuates it through another factor $(1-\alpha_i)$.

In the forest, one echo may move you in the wrong direction at time $j$, but later observations and movements keep rewriting that mistake. Its effect does not remain unchanged forever.

This explicit form converts the recursion into a deterministic residual plus a weighted random sum. That separation makes expectation and variance calculations possible.
