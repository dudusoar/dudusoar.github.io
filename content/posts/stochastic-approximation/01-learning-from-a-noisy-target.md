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

Imagine searching for a river at night. Let $w_k$ denote your actual position after step $k$. The riverbank has a fixed true location $w^*$, but you cannot see or use it directly. You can only listen to the water and form a location judgment, $\text{target}_k$.

![A traveler repeatedly follows noisy river-location judgments and converges toward the riverbank.](/images/stochastic-approximation-forest-river.png)

## The Actual Update Uses Only the Noisy Target

Wind, leaves, echoes, and terrain can shift this estimate away from the true location:

$$
\text{target}_k=w^*+\eta_k,
$$

where:

$$
\eta_k=\text{target}_k-w^*
$$

is the location error caused by the current judgment. This equation belongs to the analyst's view: the traveler observes $\text{target}_k$, not $w^*$ or $\eta_k$ separately.

The traveler can execute:

$$
w_{k+1}=w_k+\alpha_k(\text{target}_k-w_k).
$$

This update uses only the current position, the latest inferred river location, and the chosen movement fraction. The difficult part is now visible: every step must follow a target that may be wrong.

## The Step Size Is a Movement Fraction

You should not completely trust one sound-based judgment. The coefficient $\alpha_k$ is:

> The fraction of the vector from your current position to the latest inferred river location that you actually walk.

With $\alpha_k=1$, you move directly to $\text{target}_k$. With $0<\alpha_k<1$, you move only partway and leave room for later judgments to correct the route.

Stochastic approximation allows this fraction to change over time:

$$
\alpha\longrightarrow\alpha_k.
$$

## Read the Update as a Weighted Position

The same expression can be written as:

$$
w_{k+1}=(1-\alpha_k)w_k+\alpha_k\text{target}_k.
$$

The new physical position is a weighted combination of the current position and the latest inferred river location.

## A Concrete Step

Use a one-dimensional east-west coordinate. Suppose you are at $w_k=0$ meters, the latest sound suggests $\text{target}_k=120$ meters, and $\alpha_k=0.25$. Then:

$$
w_{k+1}=0+0.25(120-0)=30\text{ meters}.
$$

You can complete this action without knowing the true riverbank. If an outside observer knows that $w^*=100$ meters, that observer can also say that the current judgment error was $\eta_k=20$ meters. The true location enters the analysis, not the traveler's calculation.

This leaves the central question for the rest of the series:

> Under what conditions does $w_k$ converge to the unobserved target $w^*$?
