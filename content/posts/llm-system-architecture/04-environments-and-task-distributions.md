---
title: "Separate Plausible Environments from LLM Task Distributions"
date: 2026-07-17
draft: false
description: "Reliable evaluation needs one layer for plausible executable environments and another for meaningful LLM task distributions."
tags: ["LLM systems", "evaluation", "simulation", "task distributions"]
categories: ["technical"]
showToc: true
math: false
---

Scenario design for an LLM decision system should be split into two layers.

The first layer generates worlds that satisfy the physical, operational, and lifecycle constraints of the domain. The second layer organizes those worlds into named task families that define what the model should learn, where it should be tested, and which claims the evaluation can support.

These layers answer different questions:

| Layer | Responsibility | Core question |
|---|---|---|
| Environment layer | Generate plausible, constraint-consistent, executable worlds | Does the scenario obey the domain's state, resource, timing, and lifecycle rules? |
| Task-distribution layer | Organize meaningful pressure families and held-out tasks | Does the scenario expose a specific decision difficulty and test a capability with a defined role? |

The environment layer provides a world that can be trusted. The task-distribution layer provides a problem that can be interpreted.

## Why One Layer Is Not Enough

With only an environment generator, the result may be a collection of plausible random instances. These instances can be useful for testing a platform, but they may not explain why memory is needed, when a bounded action can improve a baseline, or which mechanism creates an opportunity.

With only a hand-designed task distribution, the model may perform well on carefully constructed toy cases that violate realistic constraints or lifecycle semantics.

A stable design therefore looks like:

```text
environment layer:
  plausible world generation
  feasibility, lifecycle, resource, timing, and observability constraints

task-distribution layer:
  named scenario families
  pressure sources
  memory or tool-use opportunities
  held-out evaluation tasks
```

The first layer protects external validity. The second protects mechanism-level interpretability.

## The Environment Contract

An environment contract should make at least the following properties reproducible:

- the topology or state space in which actions occur;
- the arrival and release of observable events;
- resource, capacity, timing, and feasibility constraints;
- the lifecycle of entities and decisions;
- decision points and terminal conditions;
- the visibility boundary shared by controllers and baselines.

These rules belong to the environment rather than to a particular LLM method. A task family should not temporarily override domain constraints simply to create a favorable example.

## The Task-Distribution Contract

The task-distribution layer should define:

- which operational pressures or failure modes matter;
- which kind of historical experience or tool query could help;
- which actions are legal for the online controller;
- where a baseline is expected to fail and why;
- which outcomes would count as evidence of improvement;
- how training, validation, and held-out cases are separated.

It is not merely a list of case IDs. It is a research and evaluation distribution:

```text
task distribution
  = plausible environment constraints
  + named pressure families
  + train / validation / held-out split
  + expected capability opportunities
  + supported claims and failure modes
```

A case registry can track the identity, provenance, runs, and usage of individual cases. The task-distribution layer explains why those cases belong together and which question they test.

## Implications for Offline Experience

Offline experience should not be extracted indiscriminately from a pool of semantically undefined random cases. It should be tied to task families with stable applicability conditions.

A memory record may therefore need descriptors such as:

- scenario family;
- pressure source;
- constraint status;
- temporal pattern;
- spatial or structural shift;
- bottleneck type;
- expected role of the memory.

These fields allow retrieval to match the current decision by task semantics and domain conditions rather than by text similarity alone.

## Implications for Held-Out Evaluation

Held-out evaluation should also be sampled from defined task families. A useful suite often includes:

- sanity cases where a baseline should already succeed;
- boundary cases that are difficult for every method;
- cases where memory or tool use has a specific expected role;
- diagnostic cases where wrong or shuffled memory should not help;
- cases that distinguish different action spaces or permission levels.

This supports a stronger conclusion than “the model performed better on random instances.” It allows an evaluator to ask whether the model improved in named conditions where a capability had a clear purpose.

## Connecting Credible Worlds to Credible Claims

The task-distribution layer sits between environment construction, experience extraction, online action, and evaluation. It explains why a collection of executable cases is relevant to a particular capability claim.

The environment layer answers: **Can this world be believed?**

The task-distribution layer answers: **Does this task test what we claim it tests?**

Without the first, a result may not transfer beyond a toy setup. Without the second, an average performance number may have no mechanism-level meaning. Reliable LLM evaluation needs both.
