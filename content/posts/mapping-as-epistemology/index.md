---
title: "We Understand the World by Building Maps"
date: 2026-03-30
draft: false
tags: ["epistemology", "knowledge", "philosophy", "research"]
categories: ["Essay"]
description: "Why two people can look at the same facts and reach completely different conclusions — and what that tells us about the nature of knowledge."
summary: "Knowledge is more than a collection of facts. It includes mapping rules that turn observations into conclusions. Understanding means building better maps, knowing their limits, and separating representation-dependent conclusions from stable structure."
showToc: true
---

Why do two people, looking at the same facts, reach completely different conclusions?

The difference need not come from dishonesty or intelligence. Two people may read the same data and the same report, or live through the same event, yet form completely different interpretations.

The real question isn't what they saw — it's what rules they used to process what they saw.

## Knowledge Is More Than Facts

We tend to think of knowledge as a collection of facts: the boiling point of water under standard conditions, Newton's second law, or the date of a historical event. But facts are inert. A fact by itself cannot tell you what follows in a new situation.

Useful knowledge is a **mapping rule**: given an input, it tells you what the corresponding output is.

A doctor's knowledge is not simply that a drug treats a disease. It includes the rule that connects a patient's condition to when that treatment is appropriate. An engineer's knowledge is not a pile of formulas; it includes the judgment that connects a class of structural problems to a suitable model.

For this essay, we can treat useful knowledge as a mapping from an input space to an output space. To understand such a mapping is to know its domain, the conclusions it can produce, and the rule that connects the two.

## Understanding the World Means Building Maps

If knowledge is a mapping rule, then what does it mean to understand the world?

It means continually building and revising maps.

Human understanding of the world is rarely direct. We cannot perceive atoms with unaided senses, see gravity itself, or observe another person's inner state. Instead, we establish relationships among observable phenomena and use them to infer what we cannot see.

Newton expressed gravity as an operational relationship: given the masses of two objects and the distance between them, calculate the force they exert on each other. That map made planetary orbits, projectile trajectories, and falling objects predictable within its domain.

Darwin connected environmental pressure and heritable variation to differential survival and reproduction. That map gave us a way to explain how the diversity of life changes over time.

Many scientific advances replace one map with another. The old map fails in specific cases; the new one covers a wider domain or gives more precise predictions within the same domain.

## The Same Phenomenon Can Have Multiple Maps

The same phenomenon can support several useful maps. More than one can produce correct predictions, provided that each stays within its domain.

Is light a wave or a particle? A wave description predicts interference and diffraction, while a particle description explains quantized interactions such as the photoelectric effect. Each captures behavior that the other description alone does not fully express.

This does not make truth relative. Different maps represent the same phenomenon at different resolutions and expose different layers of structure.

This distinction has a practical implication. When two people understand the same event differently, asking only “who is right?” keeps the argument at the output layer. A better question is which map each person is using, which assumptions it contains, and where its domain ends.

## Maps Lose Information

A map is useful partly because it leaves something out. Its limits come from what it discards, what it cannot reverse, and what it never observes.

The first limit is **information loss**. Not every map loses information: an invertible map preserves enough structure to recover its input. A compressive or many-to-one map does not. For a linear transformation, the rank–nullity theorem separates input directions preserved in the output from directions collapsed into the kernel. The theorem applies to linear maps, but it illustrates the broader design question: what did the representation preserve, and what did it erase?

A good mapping consciously discards unimportant information. A bad mapping unconsciously discards critical information.

The second limit is **irreversibility**. Many mappings are many-to-one: you can compute the output from the input, but you cannot uniquely recover the input from the output. Several causes may produce the same effect. Even perfect observation of the output may therefore be insufficient to identify its cause.

This is a common difficulty in scientific research. We observe a result and want to recover its mechanism, but the reverse map may not be unique.

The third limit is **unobservability**. Some variables never enter the observation space. A map cannot recover them from the data without additional assumptions or measurements.

## A Better Map Makes Hard Problems Simple

Since mappings can be chosen, there are better and worse ones.

One useful kind of map exposes the structure of a problem by turning coupled quantities into independent ones.

Diagonalization provides a clear example. When a matrix is diagonalizable, changing to a basis of eigenvectors removes the cross-coupling in its representation. Each direction scales independently, turning a coupled transformation into a collection of one-dimensional operations.

The problem itself hasn't changed. But with a different mapping, it becomes solvable.

The Fourier transform is another example. Convolution in the time domain is computationally expensive. Switch to the frequency domain, and convolution becomes pointwise multiplication. Same information, different representation, completely different computational difficulty.

This pattern recurs across fields. A problem may require less computation once we find a map that exposes its natural structure.

## Invariants Separate Structure from Representation

If the same phenomenon supports multiple maps, which properties belong to the phenomenon rather than to one representation?

Look for quantities that remain unchanged under the relevant class of transformations.

In linear algebra, the same linear transformation has different matrix representations under a change of basis, but its eigenvalues, trace, and determinant remain unchanged. These invariants describe the operator rather than the chosen coordinate system.

Physics applies the same idea by separating physical predictions from arbitrary coordinate choices. What counts as invariant depends on which transformations the theory permits.

This gives us a useful criterion. If a conclusion disappears under a valid change of representation, it is probably an artifact of that representation. A conclusion that survives the relevant transformations is more likely to describe stable structure.

---

Back to the original question: why do two people, looking at the same facts, reach different conclusions?

Because they're using different mappings to process the same input. Their disagreement isn't about the facts — it's about the rules.

This is not a discouraging conclusion. When a disagreement seems irreconcilable, ask which maps we are each using, where their limits lie, and whether another map can accommodate what both sides observe.

Understanding the world is the ongoing process of building, testing, and replacing maps. There is no final map, only better approximations.
