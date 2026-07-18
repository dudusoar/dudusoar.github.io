---
title: "How the Initial Error Disappears in Expectation"
date: 2026-07-17
draft: false
weight: 19
hiddenInHomeList: true
description: "Zero-mean noise removes the disturbance terms from the expectation, leaving a product that vanishes when the step sizes sum to infinity."
tags: ["stochastic approximation", "expectation", "initial error", "Robbins-Monro"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 19 of 22

The explicit error formula is:

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

For this simplified calculation, treat $\alpha_i$ and $\beta_j$ as given coefficients and assume ordinary zero-mean noise. The full theorem replaces ordinary zero mean with conditional zero mean given the history.

## Take the Expectation

If:

$$
\mathbb{E}[\eta_j]=0,
$$

then:

$$
\begin{aligned}
\mathbb{E}[\Delta_k]
&=
\left[
\prod_{i=0}^{k-1}(1-\alpha_i)
\right]\Delta_0\\
&\quad+
\sum_{j=0}^{k-1}
\left[
\prod_{i=j+1}^{k-1}(1-\alpha_i)
\right]\beta_j
\underbrace{\mathbb{E}[\eta_j]}_{0}.
\end{aligned}
$$

Therefore:

$$
\mathbb{E}[\Delta_k] =
\left[
\prod_{i=0}^{k-1}(1-\alpha_i)
\right]\Delta_0.
$$

## Use the Infinite-Sum Condition

If:

$$
\sum_k\alpha_k=\infty,
$$

then:

$$
\prod_{i=0}^{k-1}(1-\alpha_i)\to0.
$$

It follows that:

$$
\mathbb{E}[\Delta_k]\to0.
$$

In the river analogy, imagine repeating the journey many times under different wind and echo realizations. If the inferred target errors are unbiased, they cancel in the average. What remains is the influence of the starting position, and the infinite cumulative contraction removes it.

For a concrete constant-step illustration, put the river at $100$ meters and start every traveler at $40$, so $\Delta_0=-60$. With $\alpha=0.2$ and unbiased judgment errors:

$$
\mathbb{E}[\Delta_{10}]
=(1-0.2)^{10}(-60)
\approx-6.44\text{ m}.
$$

Across repeated journeys, the average position is now only about $6.44$ meters short of the river. This cancellation is an ensemble statement: an individual traveler still hears a particular, non-canceling sequence of errors.

This calculation gives the expectation-level meaning of:

$$
\sum_k\alpha_k=\infty.
$$

It prevents the initial error from retaining a permanent coefficient.

The result is necessary but incomplete. A zero mean does not imply that individual paths are stable, or even that the dispersion around the mean is small. The next step is to analyze variance.
