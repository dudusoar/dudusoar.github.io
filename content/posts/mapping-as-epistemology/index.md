---
title: "We Understand the World by Building Maps"
date: 2026-03-30
draft: false
tags: ["epistemology", "knowledge", "philosophy", "research"]
categories: ["Essay"]
description: "Why two people can look at the same facts and reach completely different conclusions — and what that tells us about the nature of knowledge."
summary: "Knowledge isn't a collection of facts. It's a set of mapping rules — transformations from input to output. Understanding the world means building better maps, knowing their limits, and finding what stays invariant across all of them."
showToc: true
---

Why do two people, looking at the same facts, reach completely different conclusions?

Not because one is lying. Not because of any difference in intelligence. They read the same data, the same report, lived through the same event. And yet their understanding diverges completely.

The real question isn't what they saw — it's what rules they used to process what they saw.

## Knowledge Is Not Facts, It's Rules

We tend to think of knowledge as a collection of facts: water boils at 100°C, Newton's second law, the year some historical event happened. But this view has a fundamental problem — facts are inert. A fact by itself can't tell you anything new.

Useful knowledge is a **mapping rule**: given an input, it tells you what the corresponding output is.

A doctor's knowledge isn't the fact that "this drug cures disease." It's the rule: "when a patient presents these symptoms, this drug is effective." An engineer's knowledge isn't a pile of formulas — it's the judgment of "when facing this class of structural problem, model it this way."

More precisely: knowledge is a mapping from an input space to an output space. To understand something means you've grasped the domain (when it applies), the range (what conclusions it yields), and the rule itself (how to get from input to output).

## Understanding the World Means Building Maps

If knowledge is a mapping rule, then what does it mean to understand the world?

It means building new maps, continuously.

Human understanding of the world has never been direct. We can't directly perceive atoms, directly see gravity, directly observe another person's inner state. What we can do is establish correspondences between observable phenomena, then use those correspondences to infer what we can't see.

Newton didn't "discover" gravity — gravity was always there. What he did was build a mapping: from the masses of objects and the distance between them, to the force they exert on each other. That mapping let us predict planetary orbits, the trajectory of cannonballs, the fall of an apple.

Darwin didn't "discover" evolution — species were always changing. What he did was build a mapping: from environmental pressure and heritable variation, to which species survive and which disappear. That mapping let us understand where the diversity of life comes from.

Every scientific revolution is, at its core, a replacement of one mapping with another. The old mapping failed in certain cases; the new one covers a wider range, or gives more precise predictions within the same range.

## The Same Phenomenon Can Have Multiple Maps

Here's the counterintuitive part: for the same phenomenon, multiple different mappings can coexist — and all of them can be "correct."

Is light a wave or a particle? This question troubled physicists for centuries. The answer is: it depends on what you're measuring. The mapping that describes interference and diffraction treats light as a wave. The mapping that describes the photoelectric effect treats light as a particle. Both give correct predictions within their respective domains.

This isn't saying truth is relative. It's saying that different mappings observe the same phenomenon at different resolutions — they capture different layers of structure.

This insight has a direct practical implication: when two people have different understandings of the same thing, the question is rarely "who's right." It's "which mapping are they each using?" Arguing about who's right is fighting at the output layer. The real disagreement lies in whether the underlying mapping functions are consistent.

## Maps Lose Information

But mappings aren't omnipotent. Every mapping has its limits.

The first limit is **information loss**. Any mapping is a form of compression — it simplifies complex input into manageable output. In that process, information is inevitably discarded. Linear algebra has a theorem that makes this precise: the information a transformation preserves plus the information it loses equals the total information in the input. This isn't just a mathematical result — it's a universal principle. Dimensionality reduction is irreversible. Compression has a cost.

A good mapping consciously discards unimportant information. A bad mapping unconsciously discards critical information.

The second limit is **irreversibility**. Many mappings are one-directional: you can infer the output from the input, but you can't uniquely recover the input from the output. Multiple different causes can produce the same effect. This means that even if you perfectly observe the output, you cannot reliably reverse-engineer the true input.

This is a fundamental difficulty in scientific research. What we observe is always the result. What we want to understand is the mechanism. But the mapping from result to mechanism is often irreversible.

The third limit is **unobservability**. Some variables simply aren't in your observation space. Your mapping is compressed from the start — certain critical information will never appear in your input at all.

## A Better Map Makes Hard Problems Simple

Since mappings can be chosen, there are better and worse ones.

A good mapping has one characteristic: it makes the structure of the problem clear, turning what was coupled into something independent.

Diagonalization in linear algebra is a perfect example. A complex matrix transformation, in ordinary coordinates, has all directions coupled together — hard to analyze. But switch to the coordinate system formed by eigenvectors, and all coupling disappears. Each direction scales independently. A complex system of simultaneous equations becomes a set of independent one-dimensional problems.

The problem itself hasn't changed. But with a different mapping, it becomes solvable.

The Fourier transform is another example. Convolution in the time domain is computationally expensive. Switch to the frequency domain, and convolution becomes pointwise multiplication. Same information, different representation, completely different computational difficulty.

This pattern recurs across fields: the key to solving a problem is often not more computational power, but finding a mapping that makes the problem naturally simple.

## What Stays Invariant Is What's Real

Final insight: if the same phenomenon can have multiple mappings, what is truly invariant?

The answer: quantities that remain unchanged across all mappings.

In linear algebra, a matrix can have different representations in different coordinate systems, but its eigenvalues, trace, and determinant are the same in every coordinate system. These invariants describe not the coordinate system, but the intrinsic properties of the transformation itself.

One of the core principles of physics is that physical laws don't depend on the choice of reference frame. Mass, charge, spin are invariants; coordinates are human choices.

This gives us a criterion: if a conclusion depends on a particular mapping, it's probably not fundamental — it's an artifact of the representation. A truly deep insight should hold across multiple mappings.

---

Back to the original question: why do two people, looking at the same facts, reach different conclusions?

Because they're using different mappings to process the same input. Their disagreement isn't about the facts — it's about the rules.

This isn't a discouraging conclusion. Quite the opposite. It means that when you encounter an irreconcilable disagreement, the most valuable question isn't "who's right." It's: "what mapping are each of us using, where are the limits of those mappings, and is there a better mapping that can accommodate what we're both seeing?"

Understanding the world is this process of continuously building, testing, and replacing maps. No endpoint — only better approximations.
