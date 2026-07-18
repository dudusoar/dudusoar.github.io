---
title: "Square the Error to Turn Convergence into Energy Dissipation"
date: 2026-07-17
draft: false
weight: 16
hiddenInHomeList: true
description: "The Dvoretzky proof tracks squared error, shows that its positive drift is summable, and rules out a positive limiting energy."
tags: ["stochastic approximation", "Dvoretzky", "Lyapunov function", "martingale"]
categories: ["technical"]
showToc: true
math: true
---

> **Series:** [Stochastic Approximation from First Principles](/posts/stochastic-approximation/) · Part 16 of 22

The entry point to Dvoretzky's proof is not the signed error $\Delta_k$, but the squared error:

$$
h_k=\Delta_k^2.
$$

This transforms an error that can change direction into a nonnegative energy. The proof first shows that this energy converges, then uses persistent contraction to rule out any positive limit.

## Why Square the Error

Start from:

$$
\Delta_{k+1} =
(1-\alpha_k)\Delta_k
+
\beta_k\eta_k.
$$

Directly tracking $\Delta_k$ is difficult because it can be positive, negative, and repeatedly pushed across zero by noise.

The square has three useful properties.

First, it removes direction:

$$
h_k\ge0.
$$

Second, it preserves the target:

$$
h_k\to0
\quad\Longleftrightarrow\quad
\Delta_k\to0.
$$

Third, it creates an analyzable one-step energy change:

$$
h_{k+1}-h_k.
$$

In the river analogy, $\Delta_k$ identifies which side of the river you are on. The energy $h_k$ records only the squared distance to the river.

## Step 1: Expand the Energy Increment

By definition:

$$
\begin{aligned}
h_{k+1}
&=\Delta_{k+1}^2\\
&=\left[(1-\alpha_k)\Delta_k+\beta_k\eta_k\right]^2\\
&=(1-\alpha_k)^2\Delta_k^2\\
&\quad+2(1-\alpha_k)\beta_k\Delta_k\eta_k\\
&\quad+\beta_k^2\eta_k^2.
\end{aligned}
$$

Subtracting $h_k=\Delta_k^2$ gives:

$$
\begin{aligned}
h_{k+1}-h_k
&=\left[(1-\alpha_k)^2-1\right]\Delta_k^2\\
&\quad+2(1-\alpha_k)\beta_k\Delta_k\eta_k\\
&\quad+\beta_k^2\eta_k^2.
\end{aligned}
$$

Since:

$$
(1-\alpha_k)^2-1 =
-2\alpha_k+\alpha_k^2 =
-\alpha_k(2-\alpha_k),
$$

we obtain:

$$
\begin{aligned}
h_{k+1}-h_k
&=
-\alpha_k(2-\alpha_k)\Delta_k^2\\
&\quad+2(1-\alpha_k)\beta_k\Delta_k\eta_k\\
&\quad+\beta_k^2\eta_k^2.
\end{aligned}
$$

The first term dissipates energy. The other two come from the new disturbance.

## Step 2: Take Conditional Expectation

Condition on the available history $\mathcal{H}_k$:

$$
\begin{aligned}
\mathbb{E}[h_{k+1}-h_k\mid\mathcal{H}_k]
&=
-\alpha_k(2-\alpha_k)\Delta_k^2\\
&\quad+2(1-\alpha_k)\beta_k\Delta_k
\mathbb{E}[\eta_k\mid\mathcal{H}_k]\\
&\quad+\beta_k^2
\mathbb{E}[\eta_k^2\mid\mathcal{H}_k].
\end{aligned}
$$

Conditional unbiasedness:

$$
\mathbb{E}[\eta_k\mid\mathcal{H}_k]=0
$$

eliminates the cross term. The bounded conditional second moment:

$$
\mathbb{E}[\eta_k^2\mid\mathcal{H}_k]\le C
$$

then yields:

$$
\boxed{
\mathbb{E}[h_{k+1}-h_k\mid\mathcal{H}_k]
\le
-\alpha_k(2-\alpha_k)\Delta_k^2
+
C\beta_k^2
}
$$

The expected energy change is bounded by a negative contraction term plus a controlled positive noise term.

## Step 3: Bound the Total Positive Energy Injection

Dvoretzky's conditions include:

$$
\sum_k\beta_k^2<\infty.
$$

Therefore:

$$
\sum_k C\beta_k^2<\infty.
$$

The total positive contribution allowed by the noise bound is finite.

Because $h_k$ is nonnegative and the positive part of its conditional expected increments is summable, a quasi-martingale or supermartingale convergence theorem gives:

$$
h_k\to L
\quad\text{almost surely},
$$

for some $L\ge0$.

At this point, the energy is known to converge, but it may still appear possible that $L>0$.

## Step 4: Rule Out a Positive Limit

The same energy inequality gives:

$$
\sum_k\alpha_k\Delta_k^2<\infty.
$$

Equivalently:

$$
\sum_k\alpha_k h_k<\infty.
$$

The Robbins–Monro condition also requires:

$$
\sum_k\alpha_k=\infty.
$$

Suppose $L>0$. Since $h_k\to L$, for all sufficiently large $k$:

$$
h_k>\frac{L}{2}.
$$

Then:

$$
\sum_k\alpha_kh_k
\ge
\frac{L}{2}\sum_k\alpha_k =
\infty,
$$

which contradicts:

$$
\sum_k\alpha_kh_k<\infty.
$$

Therefore:

$$
L=0.
$$

Since $h_k=\Delta_k^2$:

$$
h_k\to0
\quad\Longrightarrow\quad
\Delta_k\to0
\quad\text{almost surely}.
$$

## The Proof Pattern

The argument has four steps:

1. Define the energy $h_k=\Delta_k^2$.
2. Expand the one-step increment $h_{k+1}-h_k$.
3. Use conditional expectation to separate contraction from noise.
4. Prove that the energy converges, then use infinite cumulative contraction to force its limit to zero.

The reusable idea is broader than this theorem:

> Instead of tracking a random state directly, construct a nonnegative energy, control its upward drift, and use persistent dissipation to exclude a positive limit.

Here, $\sum_k\beta_k^2<\infty$ bounds how much energy noise can inject, while $\sum_k\alpha_k=\infty$ says that any remaining error continues to experience contraction.
