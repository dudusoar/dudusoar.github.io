---
title: "Why the Step Size Must Stay Below One under Noise"
date: 2026-07-17
draft: false
weight: 5
hiddenInHomeList: true
description: "Step sizes between zero and one are the only range that combines monotone error contraction with attenuation of new noise."
tags: ["stochastic approximation", "step size", "noise", "stability"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 5 of 22

Why should $\alpha_k$ lie between zero and one? The answer has two parts: geometry explains overshooting, and the error recursion explains noise amplification.

## Geometry Without Noise

If $\eta_k=0$, then:

$$
w_{k+1}=(1-\alpha_k)w_k+\alpha_k w^*.
$$

The result depends on the value of $\alpha_k$:

| Step size | Position of $w_{k+1}$ | Behavior |
|---|---|---|
| $\alpha_k\in(0,1)$ | Between $w_k$ and $w^*$ | Moves steadily toward the target |
| $\alpha_k=1$ | Exactly at $w^*$ | Reaches the target in one step |
| $\alpha_k>1$ | Beyond $w^*$ | Overshoots and may oscillate |

In the river analogy, $\alpha_k>1$ means walking past the estimated river location. With no noise, that merely overshoots the river. With noise, it overshoots a location that may already be wrong.

## Noise Makes Large Steps More Dangerous

With noise:

$$
w_{k+1}=w_k+\alpha_k(w^*-w_k+\eta_k).
$$

The same coefficient that moves the estimate also scales the disturbance. If $\alpha_k>1$, it amplifies the noisy direction.

The error recursion makes both effects explicit:

$$
\Delta_{k+1}
=
\underbrace{(1-\alpha_k)}_{\text{old-error coefficient}}\Delta_k
+
\underbrace{\alpha_k}_{\text{noise coefficient}}\eta_k.
$$

## Requirement 1: Contract the Old Error

Contraction requires:

$$
|1-\alpha_k|<1
\quad\Longleftrightarrow\quad
0<\alpha_k<2.
$$

From contraction alone, $\alpha_k=1.5$ is possible. The old error is multiplied by $-0.5$, so its magnitude shrinks while its direction alternates.

## Requirement 2: Attenuate New Noise

For deterministic $\alpha_k$:

$$
\operatorname{Var}(\alpha_k\eta_k)
=
\alpha_k^2\operatorname{Var}(\eta_k)
=
\alpha_k^2\sigma^2.
$$

| $\alpha_k$ | Variance contributed by the new noise |
|---|---|
| $0.1$ | $0.01\sigma^2$ |
| $0.5$ | $0.25\sigma^2$ |
| $1.0$ | $\sigma^2$ |
| $1.5$ | $2.25\sigma^2$ |

The larger the step, the more strongly one noisy observation affects the next estimate.

## The Intersection of the Two Requirements

| Range | Old error | New noise | Result |
|---|---|---|---|
| $(0,1)$ | Contracts monotonically | Attenuated | Satisfies both goals |
| $1$ | Old error disappears | Enters at full strength | Requires separate analysis |
| $(1,2)$ | Contracts by oscillation | Amplified | Possible without noise, risky with noise |
| $\ge2$ | Does not contract | Amplified | Unstable |

The interval $(0,1)$ is the only range that gives both monotone contraction and noise attenuation.

Keeping $\alpha_k<1$ does not mean refusing to reach the target quickly. It means recognizing that the observed target may be wrong. Moving only partway preserves the ability to correct the route after the next observation.
