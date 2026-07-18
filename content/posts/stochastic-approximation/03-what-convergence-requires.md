---
title: "What a Noisy Iteration Needs in Order to Converge"
date: 2026-07-17
draft: false
weight: 3
hiddenInHomeList: true
description: "A compact map of the step-size and noise assumptions behind stochastic-approximation convergence."
tags: ["stochastic approximation", "convergence", "step size", "noise"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 3 of 22

To prove that a noisy update converges, we must constrain both the mechanism we control and the noise we do not.

The original update is:

$$
w_{k+1}=w_k+\alpha_k(w^*+\eta_k-w_k),
$$

and its error recursion is:

$$
\Delta_{k+1}=(1-\alpha_k)\Delta_k+\alpha_k\eta_k.
$$

## Assumptions on the Step Size

The standard conditions are:

$$
0\le\alpha_k<1,
$$

$$
\sum_k\alpha_k=\infty,
$$

and:

$$
\sum_k\alpha_k^2<\infty.
$$

Each controls a different failure mode:

- $0\le\alpha_k<1$ keeps each new position between the current position and the noisy target.
- $\sum_k\alpha_k=\infty$ prevents the process from losing the ability to correct its initial error.
- $\sum_k\alpha_k^2<\infty$ limits the cumulative strength with which noise enters the system.

## Assumptions on the Noise

At the basic level, the disturbance sequence $\{\eta_k\}$ is assumed to satisfy:

$$
\mathbb{E}[\eta_k]=0,
\qquad
\operatorname{Var}(\eta_k)=\sigma^2<\infty.
$$

Zero mean rules out a persistent directional bias. Finite variance makes the disturbance strength controllable.

## The River Interpretation

In the forest analogy:

- The step-size conditions determine how much of the vector toward each inferred river location you follow.
- $\sum_k\alpha_k=\infty$ prevents you from becoming so cautious that you stop before reaching the river.
- $\sum_k\alpha_k^2<\infty$ prevents every new echo from entering your route with a large weight forever.
- $\mathbb{E}[\eta_k]=0$ says the inferred river location is not systematically shifted to the same side.
- $\operatorname{Var}(\eta_k)<\infty$ says those location errors remain on an averagable scale.

These assumptions are not decorative restrictions chosen to make a proof convenient. They define an executable strategy for learning from a hidden target: control how much you move, and require the observation errors to be unbiased and bounded in strength.

They also define the analogy's boundary. The riverbank is fixed, and each sound is abstracted into a location judgment. Obstacles, non-straight movement, and persistent echo bias would require a richer model.

The rest of the series explains why each condition is needed.
