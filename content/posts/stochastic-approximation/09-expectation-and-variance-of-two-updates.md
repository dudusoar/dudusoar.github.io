---
title: "Expectation and Variance Explain Why History Stabilizes an Update"
date: 2026-07-17
draft: false
weight: 9
hiddenInHomeList: true
description: "A direct derivation compares memoryless and history-preserving updates under zero-mean finite-variance noise."
tags: ["stochastic approximation", "expectation", "variance", "noise"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 9 of 22

Suppose the statistical properties of $\eta_k$ are known, while the behavior of $w_k$ is what we want to determine. We can use the former to compare two update mechanisms: $\alpha=1$ and $0<\alpha<1$.

The goal is a traveler whose position is centered on the true riverbank $w^*$ and whose individual journeys do not fluctuate excessively.

## The Memoryless Update

With $\alpha=1$:

$$
w_{k+1}=w^*+\eta_k.
$$

Therefore:

$$
\begin{aligned}
\mathbb{E}[w_{k+1}]&=w^*+\mathbb{E}[\eta_k],\\
\operatorname{Var}(w_{k+1})&=\operatorname{Var}(\eta_k).
\end{aligned}
$$

If the sound-based estimate is unbiased, your average position is the river. But the position at each step fluctuates exactly as much as one raw observation.

## The History-Preserving Update

For a transparent derivation, first hold the step size constant:

$$
0<\alpha<1.
$$

The update is:

$$
w_{k+1}=(1-\alpha)w_k+\alpha(w^*+\eta_k).
$$

Expanding recursively gives:

$$
\begin{aligned}
w_1&=\alpha(w^*+\eta_0)+(1-\alpha)w_0,\\
w_2&=\alpha(w^*+\eta_1)+\alpha(1-\alpha)(w^*+\eta_0)+(1-\alpha)^2w_0,
\end{aligned}
$$

and in general:

$$
w_k =
\sum_{i=0}^{k-1}\alpha(1-\alpha)^i
(w^*+\eta_{k-1-i})
+
(1-\alpha)^kw_0.
$$

The current position is an exponentially weighted combination of past inferred river locations. Recent judgments receive larger weights; older judgments remain, but their influence decays.

## Compute the Expectation

Taking expectations:

$$
\begin{aligned}
\mathbb{E}[w_k]
&=
w^*\sum_{i=0}^{k-1}\alpha(1-\alpha)^i\\
&\quad+
\sum_{i=0}^{k-1}\alpha(1-\alpha)^i
\mathbb{E}[\eta_{k-1-i}]
+
(1-\alpha)^kw_0.
\end{aligned}
$$

The geometric sum is:

$$
\sum_{i=0}^{k-1}\alpha(1-\alpha)^i =
1-(1-\alpha)^k.
$$

If $\mathbb{E}[\eta_k]=0$, then:

$$
\mathbb{E}[w_k] =
\left[1-(1-\alpha)^k\right]w^*
+
(1-\alpha)^kw_0
\longrightarrow w^*.
$$

## Compute the Variance

Only the noise-weighted part is random:

$$
\sum_{i=0}^{k-1}\alpha(1-\alpha)^i\eta_{k-1-i}.
$$

If the disturbances are independent:

$$
\operatorname{Var}(w_k) =
\sum_{i=0}^{k-1}
\alpha^2(1-\alpha)^{2i}
\operatorname{Var}(\eta_{k-1-i}).
$$

Assume the noise is independent and identically distributed with:

$$
\mathbb{E}[\eta_k]=0,
\qquad
\operatorname{Var}(\eta_k)=\sigma^2<\infty.
$$

Then:

$$
\operatorname{Var}(w_k) =
\alpha^2\sigma^2
\sum_{i=0}^{k-1}(1-\alpha)^{2i}.
$$

Evaluating the geometric sum:

$$
\operatorname{Var}(w_k) =
\alpha^2\sigma^2
\frac{1-(1-\alpha)^{2k}}
{1-(1-\alpha)^2}.
$$

Hence:

$$
\lim_{k\to\infty}\operatorname{Var}(w_k) =
\frac{\alpha\sigma^2}{2-\alpha}.
$$

## Compare the Two Mechanisms

| Step size | Limiting expectation | Variance |
|---|---|---|
| $\alpha=1$ | $w^*$ | $\sigma^2$ |
| $0<\alpha<1$ | $w^*$ | approaches $\frac{\alpha\sigma^2}{2-\alpha}$ |

Both positions are centered on the riverbank in expectation under zero-mean noise. The history-preserving update can reduce variance by preventing one judgment from determining the entire route.

## A Numerical Comparison

Suppose the standard deviation of one sound-based location error is $20$ meters, so $\sigma^2=400\text{ m}^2$.

- With full replacement, the traveler's position has standard deviation $20$ meters at every step.
- With $\alpha=0.2$, the limiting variance is

  $$
  \frac{0.2}{2-0.2}\cdot 400 \approx 44.44\text{ m}^2,
  $$

  which corresponds to a standard deviation of about $6.67$ meters.

Constant smoothing therefore keeps the traveler much closer to the river on average, but it does not make the remaining fluctuation disappear.

In the river analogy, $\alpha<1$ does not make one sound more accurate. It makes one mistaken sound responsible for only part of the route.

This conclusion depends on the noise assumptions. If the noise is biased, extremely heavy-tailed, or strongly correlated, preserving history can preserve bad information rather than average it away.
