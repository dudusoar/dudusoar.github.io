---
title: "Alpha Equal to One Requires the Noise to Vanish"
date: 2026-07-17
draft: false
weight: 11
hiddenInHomeList: true
description: "If every update fully replaces the current estimate, convergence requires the observation error itself to disappear."
tags: ["stochastic approximation", "step size", "noise", "mechanism design"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 11 of 22

If $\alpha=1$, the update is:

$$
w_{k+1}=w^*+\eta_k.
$$

For $w_k$ to converge to $w^*$, the disturbance itself must converge to zero:

$$
\eta_k\to0.
$$

At the level of the simplified variance comparison, this requires:

$$
\operatorname{Var}(\eta_k)\to0.
$$

By contrast, a history-preserving mechanism can work with persistent noise whose variance remains finite:

$$
\operatorname{Var}(\eta_k)=\sigma^2<\infty.
$$

One design demands that noise disappear. The other permits noise to remain and limits how much of it enters each update.

## Compare the Modeling Choices

| Design | What is controlled | What is allowed | Practical implication |
|---|---|---|---|
| Standard stochastic approximation | The step-size sequence $\alpha_k$ | Persistent finite-variance noise | Usually realistic |
| Keep $\alpha=1$ | The noise must approach zero | Full replacement at every step | Strong environmental requirement |
| Ideal limit | $\eta_k\equiv0$ | $\alpha=1$ | Noise-free abstraction |

In the forest analogy, insisting on $\alpha=1$ means that every later sound must become almost perfectly accurate. Wind, leaves, and echoes would have to stop affecting the inferred location. A more realistic strategy accepts that errors will persist and reduces how strongly each one changes the route.

## Control the Mechanism, Not the Environment

This comparison reveals a broader modeling principle:

> Place weaker assumptions on factors you cannot control, then design the controllable mechanism to tolerate them.

Noise belongs to the environment. The step-size rule belongs to the algorithm. Demanding a perfect environment so that the mechanism can remain unconstrained reverses those roles.

Controlling $\alpha_k$ buys the ability to converge under persistent uncertainty.
