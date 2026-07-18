---
title: "Why the Squared Step Sizes Must Be Summable"
date: 2026-07-17
draft: false
weight: 14
hiddenInHomeList: true
description: "For a changing step-size sequence, square summability bounds the total variance injected by noisy observations."
tags: ["stochastic approximation", "Robbins-Monro", "variance", "step size"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 14 of 22

Why does stochastic approximation also require:

$$
\sum_k\alpha_k^2<\infty?
$$

The constant-step calculation gives an intuitive variance comparison, but a real stochastic-approximation schedule changes with $k$. We need a form that works for an entire sequence.

## Expand a Variable-Step Update

Start with:

$$
w_{k+1} =
(1-\alpha_k)w_k
+
\alpha_k(w^*+\eta_k).
$$

The first two updates are:

$$
w_1=(1-\alpha_0)w_0+\alpha_0(w^*+\eta_0),
$$

$$
\begin{aligned}
w_2
&=(1-\alpha_1)w_1+\alpha_1(w^*+\eta_1)\\
&=(1-\alpha_1)(1-\alpha_0)w_0\\
&\quad+(1-\alpha_1)\alpha_0(w^*+\eta_0)
+\alpha_1(w^*+\eta_1).
\end{aligned}
$$

In general:

$$
w_k=A_kw_0+\sum_{i=0}^{k-1}B_{k,i}(w^*+\eta_i),
$$

where:

$$
A_k=\prod_{j=0}^{k-1}(1-\alpha_j)
$$

is the remaining weight on the initial estimate, and:

$$
B_{k,i} =
\alpha_i
\prod_{j=i+1}^{k-1}(1-\alpha_j)
$$

is the weight of observation $i$ at time $k$.

The $i$th observation enters with strength $\alpha_i$ and is then attenuated by every later factor $(1-\alpha_j)$.

## Expectation Removes the Initial Error

Under zero-mean noise:

$$
\mathbb{E}[w_k] =
A_kw_0
+
\sum_{i=0}^{k-1}B_{k,i}w^*.
$$

Because the update is a weighted average:

$$
A_k+\sum_{i=0}^{k-1}B_{k,i}=1.
$$

Therefore:

$$
\mathbb{E}[w_k] =
w^*+A_k(w_0-w^*).
$$

To make the initial error vanish, we need:

$$
A_k =
\prod_{j=0}^{k-1}(1-\alpha_j)
\longrightarrow0.
$$

For small $\alpha_j$:

$$
\log A_k =
\sum_{j=0}^{k-1}\log(1-\alpha_j)
\approx
-\sum_{j=0}^{k-1}\alpha_j.
$$

Thus:

$$
\sum_k\alpha_k=\infty
$$

is what removes the initial error in expectation.

## Variance Tracks Residual Noise Weights

Only the term:

$$
\sum_{i=0}^{k-1}B_{k,i}\eta_i
$$

is random. If the disturbances are independent with variance $\sigma^2$:

$$
\operatorname{Var}(w_k) =
\sigma^2\sum_{i=0}^{k-1}B_{k,i}^2.
$$

Substituting the weights:

$$
\operatorname{Var}(w_k) =
\sigma^2
\sum_{i=0}^{k-1}
\alpha_i^2
\prod_{j=i+1}^{k-1}(1-\alpha_j)^2.
$$

This sum measures the squared residual influence of all past disturbances.

In the river analogy, an error from observation $i$ enters the route with strength $\alpha_i$. Later movements do not erase it immediately; they attenuate it through the product of subsequent contraction factors.

## A Worst-Case Bound

Every factor in:

$$
\prod_{j=i+1}^{k-1}(1-\alpha_j)^2
$$

is at most one, so:

$$
B_{k,i}^2 =
\alpha_i^2
\prod_{j=i+1}^{k-1}(1-\alpha_j)^2
\le\alpha_i^2.
$$

Therefore:

$$
\operatorname{Var}(w_k)
\le
\sigma^2\sum_{i=0}^{k-1}\alpha_i^2,
$$

and:

$$
\limsup_{k\to\infty}\operatorname{Var}(w_k)
\le
\sigma^2\sum_{i=0}^{\infty}\alpha_i^2.
$$

Hence:

$$
\sum_{i=0}^{\infty}\alpha_i^2<\infty
$$

is a sufficient condition for a finite variance bound.

The bound is deliberately conservative. It discards all later contraction and analyzes the worst case in which no historical noise is attenuated. If the variance is controlled even under that bound, the actual recursion is also controlled.

## Constant and Changing Step Sizes Answer Different Questions

| Analysis | Step-size assumption | Variance result | Use |
|---|---|---|---|
| Constant-step calculation | $\alpha_k=\alpha$ | Exact limit $\frac{\alpha\sigma^2}{2-\alpha}$ | Builds intuition |
| Sequence calculation | Changing $\alpha_k$ | Upper bound $\sigma^2\sum_i\alpha_i^2$ | Covers general schedules |

The two Robbins–Monro conditions divide the work:

- $\sum_k\alpha_k=\infty$ removes the initial error.
- $\sum_k\alpha_k^2<\infty$ bounds the accumulated noise variance.

The second condition does not tell the process to stop moving. It says that the strength with which each new disturbance is written into the state must become square-summable.
