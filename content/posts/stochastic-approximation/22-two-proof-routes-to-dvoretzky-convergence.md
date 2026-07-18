---
title: "Two Proof Routes Explain Different Levels of Convergence"
date: 2026-07-17
draft: false
weight: 22
hiddenInHomeList: true
description: "Expectation and variance explain distributional concentration; the energy and martingale route proves almost-sure convergence."
tags: ["stochastic approximation", "Dvoretzky", "convergence", "martingale"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 22 of 22

Dvoretzky's recursion supports two natural proof routes:

$$
\Delta_{k+1} =
(1-\alpha_k)\Delta_k
+
\beta_k\eta_k.
$$

One expands $\Delta_k$ and studies its expectation and variance. The other studies the conditional drift of the energy $h_k=\Delta_k^2$.

The routes are complementary. The first explains why the Robbins–Monro conditions are reasonable. The second gives the almost-sure convergence result.

## The Shared Mechanism

Both routes rely on the same ideas:

$$
\sum_k\alpha_k=\infty
$$

keeps pulling any remaining error toward zero;

$$
\sum_k\beta_k^2<\infty
$$

limits the total squared strength of the injected noise;

$$
\mathbb{E}[\eta_k\mid\mathcal{H}_k]=0
$$

rules out a systematic disturbance direction given the history; and:

$$
\mathbb{E}[\eta_k^2\mid\mathcal{H}_k]\le C
$$

bounds disturbance strength.

Both routes study why repeated noisy movement can still approach the river. They differ in whether they inspect the distribution at time $k$ or the evolution of a complete path.

## Route 1: Expectation and Variance

The first route:

1. expands $\Delta_k$ explicitly;
2. proves $\mathbb{E}[\Delta_k]\to0$;
3. proves $\operatorname{Var}(\Delta_k)\to0$;
4. applies Chebyshev's inequality.

The conclusion is:

$$
\Delta_k\xrightarrow{p}0.
$$

This says that the error at a large time is likely to be small.

The route makes the conditions easy to interpret:

- the infinite sum of $\alpha_k$ removes the initial error;
- the finite sum of $\beta_k^2$ controls accumulated disturbance variance;
- later contractions keep attenuating old noise.

Its simplified form often treats the coefficients as given and assumes independent or uncorrelated disturbances. It does not fully capture the fact that the current error already contains the entire disturbance history.

## Route 2: Energy and Martingale Convergence

The second route defines:

$$
h_k=\Delta_k^2
$$

and derives:

$$
\mathbb{E}[h_{k+1}-h_k\mid\mathcal{H}_k]
\le
-\alpha_k(2-\alpha_k)\Delta_k^2
+
C\beta_k^2.
$$

The route then:

1. uses the summable noise term to prove that $h_k$ converges almost surely;
2. obtains $\sum_k\alpha_kh_k<\infty$;
3. combines it with $\sum_k\alpha_k=\infty$;
4. rules out any positive limiting value of $h_k$.

Therefore:

$$
h_k\to0
$$

and:

$$
\Delta_k\to0
\quad\text{almost surely}.
$$

This argument follows energy along each sample path rather than inspecting isolated time slices.

## Squared Error and Squared Step Size Are Different Objects

The notation can hide an important distinction.

The energy:

$$
h_k=\Delta_k^2
$$

squares the current error so that distance from zero becomes nonnegative.

The condition:

$$
\sum_k\alpha_k^2<\infty
$$

squares the step size to control cumulative disturbance variance.

They operate at different levels. Because the square function is continuous:

$$
h_k\to0
\quad\Longleftrightarrow\quad
\Delta_k\to0.
$$

This equivalence does not conflict with the separate step-size requirements.

## The Core Comparison

| Question | Expectation–variance route | Energy–martingale route |
|---|---|---|
| Object | $\mathbb{E}[\Delta_k]$ and $\operatorname{Var}(\Delta_k)$ | Conditional increment of $h_k=\Delta_k^2$ |
| Main operation | Expand the full recursion | Analyze one-step energy change |
| Noise treatment | Often independence or lack of correlation | Conditional mean given history |
| Control level | Distribution at each time | Almost every sample path |
| Typical conclusion | $\Delta_k\xrightarrow{p}0$ | $\Delta_k\xrightarrow{\mathrm{a.s.}}0$ |
| Main value | Explains the conditions | Completes the pathwise theorem |

The expectation–variance route is not a redundant proof. It explains why the recursion should converge. The energy route proves that it does so in the stronger almost-sure sense.

## The Full Chain

The series began with:

$$
w_{k+1} =
w_k+\alpha_k(\text{target}_k-w_k),
$$

converted it into:

$$
\Delta_{k+1} =
(1-\alpha_k)\Delta_k
+
\alpha_k\eta_k,
$$

and used the Robbins–Monro conditions:

$$
\sum_k\alpha_k=\infty,
\qquad
\sum_k\alpha_k^2<\infty.
$$

Dvoretzky then generalized the recursion to:

$$
\Delta_{k+1} =
(1-\alpha_k)\Delta_k
+
\beta_k\eta_k.
$$

The two proof routes complete the picture:

- expectation and variance explain why the distribution approaches zero;
- energy and martingale tools explain why almost every path converges to zero.

This closes the stochastic-approximation chain and provides the mathematical structure to look for in updates such as TD learning and Q-learning: contraction of old error plus controlled injection of sampling noise.
