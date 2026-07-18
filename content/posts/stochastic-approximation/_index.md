---
title: "Stochastic Approximation from First Principles"
date: 2026-07-17
description: "A 22-part series on why noisy iterative updates can converge, from error recursions and step-size conditions to the Robbins–Monro conditions and Dvoretzky's theorem."
layout: "series"
weight: 2
math: true
series_groups:
  - title: "Problem Modeling and Error Analysis"
    description: "Start from a hidden noisy target, define the model error, and identify what convergence must mean."
    start: 1
    end: 3
  - title: "Step-Size Constraints, Memory, and Noise"
    description: "Develop the role of the step size, compare memoryless and history-preserving updates, and state the assumptions that make noise averaging possible."
    start: 4
    end: 11
  - title: "The Robbins–Monro Conditions"
    description: "Derive the two complementary requirements that keep learning alive while making accumulated noise finite."
    start: 12
    end: 14
  - title: "Dvoretzky Convergence and Its Two Proof Routes"
    description: "Move from moment calculations to pathwise convergence through the energy argument, then compare what the two proof routes establish."
    start: 15
    end: 22
aliases:
  - /series/stochastic-approximation-from-first-principles/
  - /tutorials/stochastic-approximation-noisy-iteration/
---

Stochastic approximation asks a simple question: if every observation is noisy, can repeated correction still reach the true target?

This series follows that question one knowledge card at a time. It begins with a hidden target and a noisy observation, derives the error recursion, studies how the step size balances correction against noise, and ends with the Robbins–Monro conditions and two routes to Dvoretzky's convergence result.

The running example is a traveler trying to reach a river hidden in a forest. The traveler's actual position is $w_k$. At step $k$, sound produces a noisy judgment $\text{target}_k$ of where the river lies, and the traveler walks a fraction $\alpha_k$ of the vector toward that judged location:

$$
w_{k+1}=w_k+\alpha_k(\text{target}_k-w_k).
$$

The true riverbank $w^*$ is fixed but unknown to the traveler. It belongs to the analyst's view of the journey and appears only when we decompose the judgment as $\text{target}_k=w^*+\eta_k$.

![A traveler repeatedly follows noisy river-location judgments and converges toward the riverbank.](/images/stochastic-approximation-forest-river.png)
