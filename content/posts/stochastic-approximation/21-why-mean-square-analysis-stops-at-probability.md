---
title: "Why Mean-Square Analysis Stops at Convergence in Probability"
date: 2026-07-17
draft: false
weight: 21
hiddenInHomeList: true
description: "Vanishing expectation and variance control each time slice, but they do not directly control the shape of an infinite sample path."
tags: ["stochastic approximation", "convergence in probability", "almost sure convergence", "Chebyshev inequality"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 21 of 22

Suppose the expectation and variance calculations give:

$$
\mathbb{E}[\Delta_k]\to0,
\qquad
\operatorname{Var}(\Delta_k)\to0.
$$

What kind of convergence follows?

## From the Second Moment to Probability

By the variance identity:

$$
\operatorname{Var}(\Delta_k)
=
\mathbb{E}[\Delta_k^2]
-
\left(\mathbb{E}[\Delta_k]\right)^2.
$$

Therefore:

$$
\mathbb{E}[\Delta_k^2]
=
\operatorname{Var}(\Delta_k)
+
\left(\mathbb{E}[\Delta_k]\right)^2.
$$

Both terms approach zero, so:

$$
\mathbb{E}[\Delta_k^2]\to0.
$$

For every $\varepsilon>0$, Chebyshev's inequality gives:

$$
\mathbb{P}(|\Delta_k|>\varepsilon)
\le
\frac{\mathbb{E}[\Delta_k^2]}{\varepsilon^2}
\longrightarrow0.
$$

Hence:

$$
\Delta_k\xrightarrow{p}0.
$$

This is convergence in probability.

## A Time-Slice Statement Is Not a Path Statement

Convergence in probability says:

> At a large time $k$, the random variable $\Delta_k$ is likely to be close to zero.

It controls the distribution at each time index.

In the river analogy, if you inspect step $k$ across many possible journeys, most positions are near the river.

Almost-sure convergence says:

$$
\mathbb{P}
\left(
\lim_{k\to\infty}\Delta_k=0
\right)
=
1.
$$

It controls complete paths:

> Except on a probability-zero set, each fixed trajectory eventually converges to zero.

In the forest, almost every individual journey eventually approaches the river and stays close.

## Why the Difference Matters

Expectation and variance can show:

- the mean at time $k$ is near zero;
- the dispersion at time $k$ is small;
- the probability of a large error at time $k$ is small.

They do not directly rule out a path that makes rare excursions infinitely often. Each time slice can have a small failure probability while the shape of an infinite path remains uncontrolled.

Dvoretzky's energy proof instead studies:

$$
h_k=\Delta_k^2
$$

and the accumulated conditional increments:

$$
\mathbb{E}[h_{k+1}-h_k\mid\mathcal{H}_k].
$$

That argument constrains the long-run energy behavior along paths and reaches:

$$
\Delta_k\xrightarrow{\mathrm{a.s.}}0.
$$

The expectation–variance route is not wrong. It explains why the distribution concentrates and why the step-size conditions make sense. It simply does not complete the stronger pathwise task.
