---
title: "We Understand the World by Building Maps"
date: 2026-03-30
draft: false
tags: ["epistemology", "knowledge", "philosophy", "research"]
categories: ["Essay"]
description: "Why the same event becomes different internal inputs — and why scientific theories are maps of observable phenomena rather than reality itself."
summary: "People do not simply apply different rules to identical inputs. Attention, experience, and representation shape the inputs themselves. Science makes maps shared and testable, but those maps remain bounded by instruments, scale, and domain."
showToc: true
---

Why do two people, looking at the same facts, reach completely different conclusions?

The difference need not come from dishonesty or intelligence. Two people may read the same data and the same report, or live through the same event, yet form completely different interpretations.

Even the phrase “the same facts” hides a complication. The external event may be the same, but by the time it becomes an input to thought, it has already passed through a personal map.

## The Same Event Does Not Produce the Same Input

Attention determines which details enter the foreground. Memory supplies analogies and expectations. Language provides the categories used to describe what happened. Goals and values determine which differences matter. Each person filters and organizes the event before deliberate reasoning begins.

A personal map is built from accumulated experience. It does not wait until after observation to interpret a finished input; it helps produce the input itself. It selects, compresses, labels, and orders what happened into a representation the person can use.

Two people can therefore face the same event without reasoning from the same internal representation. Their disagreement may come from different inference rules, but it may begin earlier: in what each person noticed, omitted, grouped together, or treated as meaningful.

This is why arguing only about the final conclusion rarely resolves a deep disagreement. The conclusions sit at the end of two different processing pipelines.

## Knowledge Is More Than Facts

We tend to think of knowledge as a collection of facts: the boiling point of water under standard conditions, Newton's second law, or the date of a historical event. But facts are inert. A fact by itself cannot tell you what follows in a new situation.

Useful knowledge is a **mapping rule**: given an input, it tells you what the corresponding output is.

A doctor's knowledge is not simply that a drug treats a disease. It includes the rule that connects a patient's condition to when that treatment is appropriate. An engineer's knowledge is not a pile of formulas; it includes the judgment that connects a class of structural problems to a suitable model.

For this essay, we can treat useful knowledge as a mapping from an input space to an output space. To understand such a mapping is to know its domain, the conclusions it can produce, and the rule that connects the two.

In human reasoning, that map includes more than the final inference rule. It also includes the representation that turns a complex event into an input the rule can process.

## Science Builds Shared Maps

Personal maps are often implicit and private. Scientific knowledge applies the same map-building process at a collective level.

Science does not remove the gap between reality and understanding. It makes the map explicit enough for other people to inspect, reproduce, test, and revise. Researchers specify what they observed, how they represented it, and which rules connect those observations to explanations or predictions.

Human access to the world remains indirect. We cannot perceive atoms with unaided senses, see gravity itself, or observe another person's inner state. We establish relationships among observable phenomena and use them to infer what we cannot see.

Newton expressed gravity as an operational relationship: given the masses of two objects and the distance between them, calculate the force they exert on each other. That map made planetary orbits, projectile trajectories, and falling objects predictable within its domain.

Darwin connected environmental pressure and heritable variation to differential survival and reproduction. That map gave us a way to explain how the diversity of life changes over time.

Many scientific advances replace one map with another. The old map fails in specific cases; the new one covers a wider domain or gives more precise predictions within the same domain.

## The Same Phenomenon Can Have Multiple Maps

The same phenomenon can support several useful maps. More than one can produce correct predictions, provided that each stays within its domain.

Is light a wave or a particle? A wave description predicts interference and diffraction, while a particle description explains quantized interactions such as the photoelectric effect. Each captures behavior that the other description alone does not fully express.

This does not make truth relative. Different maps represent the same phenomenon at different resolutions and expose different layers of structure.

The coexistence of several useful maps leads to a deeper point. Even a rigorous, predictive map is not the phenomenon itself.

## Science Is a Map, Not the Territory

A scientific theory is a structured way to organize observations and connect conditions to predictions. It can be extraordinarily accurate without being identical to the world it describes.

Observation is itself bounded by instruments, resolution, and scale. An instrument determines which variables can enter the record. Its resolution determines which differences remain visible and which collapse together. The chosen scale determines which patterns appear stable enough to model.

Classical mechanics, for example, represents a system through quantities such as position, momentum, and force, then uses differential equations to map a present state to a future trajectory. At ordinary scales and speeds, this map predicts the world extremely well.

At quantum scales, the classical map no longer accounts for all observed behavior. A quantum state cannot generally be replaced by a definite classical trajectory with the same predictive meaning. Observed quantum phenomena required a different state representation and a different mapping between state and outcome.

Calculus itself did not fail. Differential calculus formalizes local change and local linear approximation, and quantum mechanics also relies on differential equations. What failed was the classical mapping between those mathematical variables and the physical world at that scale. The mathematical tool survived; its interpretation and role inside the map changed.

This does not make science arbitrary. Scientific maps are constrained by reproducible observations, predictive performance, and comparison with alternatives. But success within a domain does not turn a map into the territory. It tells us how well a particular system of observation and reasoning lets us understand and act on phenomena at a particular scale.

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

Because the same event entered two different personal maps. Each person attended to, represented, and processed it differently.

This is not a discouraging conclusion. When a disagreement seems irreconcilable, ask what each person observed, how each represented it, which rules each applied, and where those maps stop working.

Science is the disciplined version of the same process: build maps, expose their assumptions, test them against observations, and replace them when their domain ends. There is no final map, only better approximations.
