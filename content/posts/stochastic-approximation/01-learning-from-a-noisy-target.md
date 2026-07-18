---
title: "Where Stochastic Approximation Begins: Learning from a Noisy Target"
date: 2026-07-17
draft: false
weight: 1
hiddenInHomeList: true
description: "Stochastic approximation begins when the true target is hidden and each update can use only a noisy estimate of it."
tags: ["stochastic approximation", "iterative methods", "noise", "convergence"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 1 of 22

Stochastic approximation studies a basic question: can an iterative update converge when every target observation contains noise? Robbins and Monro introduced the framework in 1951, and Dvoretzky gave a general convergence theorem in 1956. Its basic form is:

$$
\text{New}=\text{Old}+\alpha(\text{Target}-\text{Old}).
$$

## Begin with a Visible Target

Suppose the value we want is $w^*$. If we can observe it directly, a natural update is:

$$
w_{k+1}=w_k+\alpha(w^*-w_k).
$$

The difference $w^*-w_k$ points from the current estimate to the target. As a vector, it separates into direction and distance:

$$
w^*-w_k
=
\frac{w^*-w_k}{\|w^*-w_k\|}
\cdot
\|w^*-w_k\|.
$$

Imagine searching for a river at night. Here, $w_k$ is your current position and $w^*$ is the river's true location. If you can see the river, the update means:

> Walk toward the river by an $\alpha$ fraction of the remaining distance.

With $\alpha=1$, you go directly to the river. With $0<\alpha<1$, you cover only part of the distance.

## Replace the Target with a Noisy Estimate

In reality, you cannot see the river. You can only hear it. The sound is not the target; it is a signal from which you form an estimated river location, $\text{target}_k$.

Wind, leaves, echoes, and terrain can shift this estimate away from the true location:

$$
\text{target}_k=w^*+\eta_k,
$$

where:

$$
\eta_k=\text{target}_k-w^*
$$

is the location error caused by the current observation.

The update therefore becomes:

$$
w_{k+1}=w_k+\alpha(\text{target}_k-w_k).
$$

The difficult part is now visible: every step must use a target that may be wrong.

## Let the Step Size Change

You should not completely trust one noisy observation. The coefficient $\alpha$ can be read as:

> The fraction of the estimated distance that you are willing to walk.

With $\alpha=1$, you fully trust the latest estimate and move directly to $\text{target}_k$. With $0<\alpha<1$, you move only partway and retain some of your previous estimate.

Stochastic approximation normally allows this fraction to change over time:

$$
\alpha\longrightarrow\alpha_k.
$$

The update becomes:

$$
w_{k+1}=w_k+\alpha_k(\text{target}_k-w_k).
$$

## Read the Update as a Weighted Average

The same expression can be written as:

$$
w_{k+1}=(1-\alpha_k)w_k+\alpha_k\text{target}_k.
$$

The new estimate is a weighted average of old information and the latest observation. The step size $\alpha_k$ determines how much influence each receives.

This leaves the central question for the rest of the series:

> Under what conditions does $w_k$ converge to the unobserved target $w^*$?
