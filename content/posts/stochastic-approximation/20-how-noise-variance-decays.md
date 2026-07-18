---
title: "How Historical Noise Is Attenuated"
date: 2026-07-17
draft: false
weight: 20
hiddenInHomeList: true
description: "Each disturbance is controlled twice: by its entry coefficient and by every contraction that follows it."
tags: ["stochastic approximation", "variance", "noise", "convergence"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 20 of 22

The expectation can approach zero while the error remains widely dispersed. To determine whether noisy trajectories also concentrate, analyze:

$$
\operatorname{Var}(\Delta_k).
$$

## Isolate the Random Part

Write the explicit recursion as:

$$
\Delta_k=A_k+B_k,
$$

where:

$$
A_k
=
\left[
\prod_{i=0}^{k-1}(1-\alpha_i)
\right]\Delta_0
$$

is deterministic, and:

$$
B_k
=
\sum_{j=0}^{k-1}w_{j,k}\eta_j,
$$

with:

$$
w_{j,k}
=
\left[
\prod_{i=j+1}^{k-1}(1-\alpha_i)
\right]\beta_j.
$$

Because $A_k$ is deterministic:

$$
\operatorname{Var}(\Delta_k)=\operatorname{Var}(B_k).
$$

If the noise terms are independent or at least uncorrelated:

$$
\operatorname{Var}(\Delta_k)
=
\sum_{j=0}^{k-1}
w_{j,k}^2\operatorname{Var}(\eta_j).
$$

Let:

$$
\sigma_j^2=\operatorname{Var}(\eta_j).
$$

Then:

$$
\boxed{
\operatorname{Var}(\Delta_k)
=
\sum_{j=0}^{k-1}
\beta_j^2\sigma_j^2
\prod_{i=j+1}^{k-1}(1-\alpha_i)^2
}
$$

## Later Contractions Erase a Fixed Disturbance

The crucial factor is:

$$
\prod_{i=j+1}^{k-1}(1-\alpha_i)^2.
$$

For small $\alpha_i$:

$$
1-\alpha_i\approx e^{-\alpha_i},
$$

so:

$$
\prod_{i=j+1}^{k-1}(1-\alpha_i)^2
\approx
\exp\left(
-2\sum_{i=j+1}^{k-1}\alpha_i
\right).
$$

Because:

$$
\sum_i\alpha_i=\infty,
$$

for every fixed $j$:

$$
\prod_{i=j+1}^{k-1}(1-\alpha_i)^2
\longrightarrow0.
$$

Any fixed historical disturbance is eventually attenuated by infinitely many later contractions.

In the river analogy, one mistaken sound does not remain fully encoded in the route. Every later observation and movement dilutes it.

## Show That the Total Variance Vanishes

Assume:

$$
\sigma_j^2\le C.
$$

Then:

$$
\operatorname{Var}(\Delta_k)
\le
C\sum_{j=0}^{k-1}
\beta_j^2
\prod_{i=j+1}^{k-1}(1-\alpha_i)^2.
$$

Split the sum into an early finite block and a late tail.

First choose $J$ large enough that:

$$
C\sum_{j=J}^{\infty}\beta_j^2
$$

is arbitrarily small. This uses:

$$
\sum_j\beta_j^2<\infty.
$$

For the finite set $j=0,\ldots,J-1$, each contraction product approaches zero as $k$ grows. A finite sum of those terms also approaches zero.

Therefore:

$$
\operatorname{Var}(\Delta_k)\to0.
$$

## A Concrete Schedule

Let:

$$
\alpha_k=\frac{1}{k},
\qquad
\beta_k^2=\frac{1}{k^2},
\qquad
\sigma_j^2=1.
$$

Then:

$$
\sum_k\beta_k^2
=
\sum_k\frac{1}{k^2}
<\infty.
$$

Also:

$$
\begin{aligned}
\prod_{i=j+1}^{k-1}
\left(1-\frac{1}{i}\right)^2
&=
\prod_{i=j+1}^{k-1}
\left(\frac{i-1}{i}\right)^2\\
&=
\left(\frac{j}{k-1}\right)^2.
\end{aligned}
$$

Hence:

$$
\begin{aligned}
\operatorname{Var}(\Delta_k)
&\le
\sum_{j=1}^{k-1}
\frac{1}{j^2}
\left(\frac{j}{k-1}\right)^2\\
&=
\frac{1}{(k-1)^2}
\sum_{j=1}^{k-1}1\\
&=
\frac{1}{k-1}
\longrightarrow0.
\end{aligned}
$$

Noise is controlled at two stages:

- $\beta_j^2$ limits how strongly it enters;
- later contraction factors determine how quickly the system forgets it.

Small entry weights alone are not the whole story. Continued correction is also needed to erase old errors.
