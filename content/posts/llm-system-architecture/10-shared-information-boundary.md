---
title: "Every Decision Point Needs a Shared Information Boundary"
date: 2026-07-17
draft: false
weight: 10
hiddenInHomeList: true
description: "Fair online comparison requires every method to decide from the same semantic snapshot and the same boundary on future information."
tags: ["LLM systems", "online evaluation", "information boundaries", "fair comparison"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/posts/llm-system-architecture/) · Part 10 of 11

An online evaluation is valid only when every decision point begins from a shared boundary on visible information.

An LLM, a deterministic rule, and an online planner may use different data formats and computations. They must still base their decisions on semantically equivalent current state, observed history, and future-information boundaries.

A method that sees more information may remain useful as a hindsight upper bound. It is no longer a fair online comparison and cannot by itself prove that the LLM made the wrong decision.

## Fair Comparison Means Answering the Same Question

In a dynamic environment, the world changes continuously. New events arrive, actions complete, resources move, and plans are updated. It is not enough to say that two methods ran on the same complete case. They must face the same state at every decision point.

The common question is:

```text
the same decision point
    -> the same currently visible state and history
    -> the same boundary on future information
    -> separate analysis and action by each method
```

If any part differs, the action difference also contains an information difference. It cannot be attributed solely to model or method capability.

## Three Common Forms of Information Mismatch

| Mismatch | What happened | Why it matters |
|---|---|---|
| Different decision points | One method decides before an event and another after it | The state and legal actions have already changed |
| Different current state | One method sees detailed structure while another receives only a lossy summary | The stronger action may depend on details never shown to the other method |
| Different future information | One method sees future events or a complete episode | The other method is asked to imitate a decision based on unavailable knowledge |

None of these problems can be fixed by asking the LLM to “reason more carefully.” Information missing from the input cannot be recovered by instruction.

## Equivalent Information Does Not Require Identical Formatting

An LLM may read text or JSON. A planner may read a structured object. A rule may inspect a few variables. The representation can differ as long as the semantic scope is equivalent.

Problems arise when:

- one method sees the full remaining plan while another sees only an average;
- one method decides after a new event while another prompt was generated before it;
- a tool can query hidden backend truth despite the declared visibility boundary;
- memory contains outcomes that occur later in the current held-out episode.

An audit should therefore preserve two records:

1. the common state that every method was allowed to use;
2. the actual view delivered to each method.

Only then can an evaluator detect whether compression, omitted fields, or tool access changed the information permission.

## Tools and Memory Must Obey the Same Boundary

A tool is not a back door around prompt visibility. It may return only facts determined by the current observable state and past history. Even if the backend knows the complete future, the online model should not receive it.

Memory may contain experience extracted from a training set. It must not contain the future of the current validation or test episode. Each memory record should retain provenance and applicability conditions so that historical knowledge can be distinguished from leakage.

## A Strong Planner Can Play Two Different Roles

| Role | Information allowed | Question answered |
|---|---|---|
| Fair online baseline | The same current information and history as the LLM | What can a traditional or stronger method do under the same information? |
| Hindsight upper bound | A complete episode or additional global information | How much improvement is possible if the future is known? |

The hindsight upper bound is valuable. It can reveal headroom and help locate poor decisions. It cannot show what an online model should have known at the time.

Calling both roles a “baseline” hides the distinction between a capability gap and an information gap.

## Information Mismatch Creates Unlearnable Tasks

Suppose the model receives the same current state in two examples. A teacher with future knowledge chooses action A in the first and action B in the second because different events will occur later.

From the model's perspective, identical inputs have conflicting labels. The model can only learn the majority answer, guess, or invent a reason that is absent from the current evidence.

This failure cannot be solved by a larger model or a better prompt. The task itself is not learnable from the authorized information.

## Attribute Failure in the Correct Order

```text
1. Were the decision points the same?
2. Was the visible information semantically equivalent?
3. Were the legal actions and execution permissions the same?
4. If all three were equal, did the methods still behave differently?
```

Only the fourth difference can be interpreted as a reasoning, policy, or model-capability difference. Failures in the first three expose a protocol problem.

## Minimum Audit Record

Every comparison should make it possible to reconstruct:

- the decision point and its position relative to events;
- which events, state changes, and earlier actions were visible;
- which fields or summaries each method received;
- which tools were called and which snapshot produced their results;
- which memory items were retrieved and whether they touched the current future;
- whether any method used a complete episode or hindsight outcome;
- which actions were legal at that point.

The unit of a dynamic comparison is not the complete case. It is the visible information at each decision point. Until that boundary is fixed, prompts, tools, memory, training labels, and outcome comparisons do not have stable meaning.
