---
title: "Stochastic Approximation from First Principles"
date: 2026-07-17
description: "A 22-part series on why noisy iterative updates can converge, from error recursions and step-size conditions to the Robbins–Monro conditions and Dvoretzky's theorem."
layout: "series"
weight: 2
aliases:
  - /series/stochastic-approximation-from-first-principles/
  - /tutorials/stochastic-approximation-noisy-iteration/
---

Stochastic approximation asks a simple question: if every observation is noisy, can repeated correction still reach the true target?

This series follows that question one knowledge card at a time. It begins with a hidden target and a noisy observation, derives the error recursion, studies how the step size balances correction against noise, and ends with the Robbins–Monro conditions and two routes to Dvoretzky's convergence result.
