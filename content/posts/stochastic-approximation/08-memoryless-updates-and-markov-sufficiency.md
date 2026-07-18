---
title: "A Memoryless Update Is Not the Same as Markov Sufficiency"
date: 2026-07-17
draft: false
weight: 8
hiddenInHomeList: true
description: "An update can erase the previous iterate without becoming Markov; Markov sufficiency is a property of the chosen state."
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
- gives the previous position zero weight in the new position;
- depends only on the current noisy target.

In the river analogy, you completely trust the latest sound and move directly to the location it suggests. The difficulty is that $\text{target}_k$ is not the river. It is an estimate contaminated by location error.

## Markov Means Sufficient, Not Merely Recent

The Markov property says that, once the current state is given, the past adds no information needed to describe the next transition. This is a statement about whether the chosen state is sufficient. It is not a rule that says an algorithm should trust only its newest observation.

The value of $\alpha$ and the Markov property therefore answer different questions:

- $\alpha$ defines how the next position is computed.
- Markov sufficiency defines what information the state must contain for the transition law.

## A Concrete Distinction

Suppose the distribution of the next sound judgment depends only on the traveler's current position $w_k$. Given that position, two travelers who arrived there by different routes have the same next-step distribution. The position process can then be Markov for either $\alpha=1$ or $0<\alpha<1$.

If wind direction or terrain history also affects the next judgment but is missing from the state, the current position alone may not be Markov. Setting $\alpha=1$ does not repair that missing information.

The apparent similarity is only algebraic. At $\alpha=1$, the previous iterate receives zero weight. Markovianity is a probabilistic property of the state representation.
