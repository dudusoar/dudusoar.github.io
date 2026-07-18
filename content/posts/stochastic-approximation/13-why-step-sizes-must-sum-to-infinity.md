---
title: "Why the Step Sizes Must Sum to Infinity"
date: 2026-07-17
draft: false
weight: 13
hiddenInHomeList: true
description: "A finite total step size can make an iteration stop moving before its error has disappeared."
tags: ["stochastic approximation", "Robbins-Monro", "step size", "convergence"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 13 of 22

Why does stochastic approximation require:

$$
\sum_k\alpha_k=\infty?
$$

In the river analogy, the condition asks:

> If I become less willing to trust each new sound, could I stop moving before I reach the river?

## The Iteration Must Retain Enough Movement

The actual length of step $k$ is:

$$
\alpha_k\|\text{target}_k-w_k\|.
$$

The total distance moved is:

$$
\sum_k
\alpha_k\|\text{target}_k-w_k\|.
$$

We control $\alpha_k$, but we do not directly control the remaining target distance. The desired result is:

$$
\|\text{target}_k-w_k\|\to0.
$$

That quantity should disappear because the iteration has reached the target, not because $\alpha_k$ has become too small to move.

The condition:

$$
\sum_k\alpha_k=\infty
$$

removes a finite upper bound on the cumulative corrective effort. We do not know the true target or the distance to it, so the mechanism cannot spend a finite movement budget and then assume it has arrived.

## What Goes Wrong with a Finite Sum

If:

$$
\sum_k\alpha_k<\infty,
$$

then the total step-size budget is finite. The sequence can make $\alpha_k$ tiny while the target distance remains large. Actual movements then approach zero even though the estimate is still wrong.

In the forest, this is what happens when your willingness to follow each new sound decays too quickly. The sound may still indicate a direction, but you move so little that you remain deep in the forest.

The condition does not say every path must travel an infinite geometric distance. It says the algorithm cannot lose its capacity for cumulative correction before the error itself gives a reason to stop.

When no reliable stopping signal or global target information is available, continued corrective capacity is the safer mechanism.
