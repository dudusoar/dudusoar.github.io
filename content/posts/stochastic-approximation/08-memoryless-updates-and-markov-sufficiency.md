---
title: "A Memoryless Update Is Not the Same as Markov Sufficiency"
date: 2026-07-17
draft: false
weight: 8
hiddenInHomeList: true
description: "Discarding history is justified only when the current state is sufficient; a single noisy target is not."
tags: ["stochastic approximation", "Markov property", "state", "noise"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 8 of 22

When $\alpha=1$, the update

$$
w_{k+1}=w^*+\eta_k
$$

looks memoryless. That resemblance can be confused with the Markov property, but the two ideas are not equivalent.

## A Memoryless Update Fully Trusts the Current Observation

At $\alpha_k=1$:

$$
w_{k+1}=\text{target}_k=w^*+\eta_k.
$$

The update:

- ignores the previous state $w_k$;
- erases all earlier estimates;
- depends only on the current noisy target.

In the river analogy, you completely trust the latest sound and move directly to the location it suggests. The difficulty is that $\text{target}_k$ is not the river. It is an estimate contaminated by location error.

## Markov Means Sufficient, Not Merely Recent

The Markov property says that the current state contains all information needed to describe the next transition. It assumes that the current state is sufficient.

A noisy target does not become sufficient simply because it is current. Discarding history in this setting creates three problems:

- one observation can dominate the estimate;
- repeated observations cannot reveal a longer-term trend;
- errors cannot be averaged across time.

Markovian memorylessness is legitimate because the current state already contains the relevant past. The update with $\alpha=1$ is memoryless because it throws the past away even though the current observation is incomplete and noisy.

The first is a property of a sufficient state representation. The second is information loss.
