---
title: "The Same Step Size Behaves Differently with and without Noise"
date: 2026-07-17
draft: false
weight: 7
hiddenInHomeList: true
description: "Alpha equal to one is optimal for an exact target but accepts the full disturbance when the target is noisy."
tags: ["stochastic approximation", "noise", "step size", "iterative methods"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 7 of 22

The choice between $\alpha=1$ and $\alpha<1$ changes meaning as soon as the target contains noise.

## Without Noise

| Step size | Update | Meaning |
|---|---|---|
| $\alpha=1$ | $w_{k+1}=w^*$ | The current observation is the exact target |
| $0<\alpha<1$ | $w_{k+1}=(1-\alpha)w_k+\alpha w^*$ | Moves partway from the current position to the target |

If the target judgment is exact and the model allows direct movement, $\alpha=1$ is the fastest choice: a riverbank at 100 meters and a target of 100 meters produce immediate arrival.

## With Noise

These expressions are the analyst's decomposition of the executable update through $\text{target}_k=w^*+\eta_k$:

| Step size | Update | Meaning |
|---|---|---|
| $\alpha=1$ | $w_{k+1}=w^*+\eta_k$ | Memoryless update |
| $0<\alpha<1$ | $w_{k+1}=(1-\alpha)w_k+\alpha(w^*+\eta_k)$ | Moves partway toward the latest noisy target |

With noise, the physical position $w_k$ encodes the accumulated effect of historical judgments. Only $\alpha<1$ preserves some weight from that position.

In the river analogy, $\alpha=1$ means moving directly to the newest location inferred from the sound. The full current error becomes your new position error. With $\alpha<1$, several observations influence the route rather than allowing one sound to determine it completely.

Because $\eta_k$ is random, expectation and variance provide the natural comparison. Both choices may be unbiased, but they need not be equally stable.

The contrast exposes the basic speed–stability trade-off: a large step is fast when the target is exact and fragile when the target is noisy.

For example, if the true riverbank remains at 100 meters but an echo suggests 70 meters, $\alpha=1$ moves you to 70 meters. The same coefficient succeeds or fails according to whether the available target is exact.
