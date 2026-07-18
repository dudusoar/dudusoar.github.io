---
title: "Model Error as Distance to the True Target"
date: 2026-07-17
draft: false
weight: 2
hiddenInHomeList: true
description: "Why convergence should track distance to the true target rather than the size of the latest update."
tags: ["stochastic approximation", "error recursion", "convergence", "iterative methods"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 2 of 22

After writing the update

$$
w_{k+1}=w_k+\alpha_k(\text{target}_k-w_k),
$$

we need a quantity that tells us whether the iteration is approaching the true target. In the forest analogy, the question is:

> Am I moving toward the river, or merely moving around the forest?

## Two Ways to Define Error

The first option is the change between consecutive iterates:

$$
w_{k+1}-w_k =
\alpha_k(\text{target}_k-w_k) =
\alpha_k(w^*+\eta_k-w_k).
$$

The second option is the displacement from the current position to the true target:

$$
\Delta_k=w_k-w^*.
$$

Substituting the update gives:

$$
\begin{aligned}
\Delta_{k+1}
&=w_{k+1}-w^*\\
&=w_k+\alpha_k(\text{target}_k-w_k)-w^*\\
&=(1-\alpha_k)\Delta_k+\alpha_k\eta_k.
\end{aligned}
$$

## Why the Second Error Is the Right One

The difference between two updates can be rewritten as:

$$
w_{k+1}-w_k=-\alpha_k\Delta_k+\alpha_k\eta_k.
$$

This quantity is an update velocity, not the convergence target. If it becomes zero, the process has stopped moving, but it may have stopped far from $w^*$.

By contrast:

$$
\lim_{k\to\infty}\Delta_k=0
\quad\Longleftrightarrow\quad
\lim_{k\to\infty}w_k=w^*.
$$

Only $\Delta_k$ answers whether the traveler reached the true riverbank.

In the river analogy, $w_{k+1}-w_k$ measures how far you moved during one step. A zero movement does not mean you reached the river. The vector $\Delta_k=w_k-w^*$ measures your actual displacement from the river, so $\Delta_k=0$ means you arrived.

## The Core Error Recursion

The analysis therefore centers on:

$$
\boxed{
\Delta_{k+1}=(1-\alpha_k)\Delta_k+\alpha_k\eta_k
}
$$

Its two terms have distinct roles:

- $(1-\alpha_k)\Delta_k$ contracts the old error because you moved toward the estimated target.
- $\alpha_k\eta_k$ injects part of the current observation error into the new position.

This is the central tension in stochastic approximation. Every update can reduce the old error, but every noisy observation can also add a new one.

## A Concrete Failure of the First Error

Suppose the true riverbank is at $w^*=100$ meters, but the step size becomes nearly zero while the traveler remains at $w_k=70$ meters. Then:

$$
w_{k+1}-w_k\approx0,
$$

even though:

$$
\Delta_k=w_k-w^*=-30\text{ meters}.
$$

The route has almost stopped changing, but the traveler is still 30 meters from the river. Convergence must therefore track $\Delta_k$, not the latest movement.

The distinction between the two candidate errors is ultimately the distinction between velocity and position: stopping is not the same as arriving.
