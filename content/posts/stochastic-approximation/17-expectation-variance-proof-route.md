---
title: "A Second Proof Route Starts from Expectation and Variance"
date: 2026-07-17
draft: false
weight: 17
hiddenInHomeList: true
description: "Expanding the recursion explains how initial error and historical noise decay, but usually yields convergence in probability rather than almost-sure convergence."
tags: ["stochastic approximation", "expectation", "variance", "convergence in probability"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 17 of 22

The energy proof controls entire sample paths. A more direct route expands $\Delta_k$ and studies:

$$
\mathbb{E}[\Delta_k]
\quad\text{and}\quad
\operatorname{Var}(\Delta_k).
$$

If both approach zero, the distribution of $\Delta_k$ concentrates near zero. This route is intuitive, but it usually proves convergence in probability rather than the almost-sure convergence in Dvoretzky's theorem.

## The Simplified Setting

Begin with:

$$
\Delta_{k+1}
=
(1-\alpha_k)\Delta_k
+
\beta_k\eta_k.
$$

For this route, treat $\alpha_k$ and $\beta_k$ as given coefficients and use ordinary assumptions such as zero-mean, bounded-variance, independent or uncorrelated disturbances.

The full Dvoretzky theorem allows more general random coefficients and history dependence. That extra generality is why the pathwise energy argument remains necessary.

## Step 1: Expand the Recursion

Repeated substitution gives:

$$
\Delta_k
=
\left[
\prod_{i=0}^{k-1}(1-\alpha_i)
\right]\Delta_0
+
\sum_{j=0}^{k-1}
\left[
\prod_{i=j+1}^{k-1}(1-\alpha_i)
\right]\beta_j\eta_j.
$$

The first term is the residual initial error. The second is the accumulated effect of historical noise.

In the river analogy, the remaining location error has two sources: where the journey began and every mistaken sound heard along the way.

## Step 2: Analyze the Expectation

If:

$$
\mathbb{E}[\eta_j]=0,
$$

then the noise terms disappear in expectation:

$$
\mathbb{E}[\Delta_k]
=
\left[
\prod_{i=0}^{k-1}(1-\alpha_i)
\right]\Delta_0.
$$

Because:

$$
\sum_k\alpha_k=\infty,
$$

the product tends to zero:

$$
\prod_{i=0}^{k-1}(1-\alpha_i)\to0.
$$

Therefore:

$$
\mathbb{E}[\Delta_k]\to0.
$$

## Step 3: Analyze the Variance

Under independent or uncorrelated noise:

$$
\operatorname{Var}(\Delta_k)
=
\sum_{j=0}^{k-1}
\beta_j^2\sigma_j^2
\prod_{i=j+1}^{k-1}(1-\alpha_i)^2,
$$

where:

$$
\sigma_j^2=\operatorname{Var}(\eta_j).
$$

The factor $\beta_j^2$ controls how strongly disturbance $j$ enters the system. The product controls how much of it survives subsequent contractions.

With bounded noise variance:

$$
\sigma_j^2\le C,
$$

along with:

$$
\sum_j\beta_j^2<\infty
$$

and:

$$
\sum_i\alpha_i=\infty,
$$

the variance approaches zero:

$$
\operatorname{Var}(\Delta_k)\to0.
$$

## Step 4: Conclude Convergence in Probability

If:

$$
\mathbb{E}[\Delta_k]\to0,
\qquad
\operatorname{Var}(\Delta_k)\to0,
$$

then:

$$
\mathbb{E}[\Delta_k^2]\to0.
$$

Chebyshev's inequality gives, for any $\varepsilon>0$:

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

## What This Route Does and Does Not Prove

The route explains:

- how the initial error disappears;
- how later contractions attenuate historical disturbances;
- why $\sum_k\alpha_k=\infty$ and $\sum_k\beta_k^2<\infty$ are natural;
- why the distribution at time $k$ concentrates near zero.

But it controls each time index separately. It says:

> At a large time $k$, the error is likely to be small.

Dvoretzky's theorem says:

> Along almost every fixed sample path, the error eventually converges to zero.

The first is a statement about a sequence of distributions. The second is a statement about entire random trajectories.
