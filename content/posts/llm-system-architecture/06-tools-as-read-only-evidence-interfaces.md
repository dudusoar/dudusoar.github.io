---
title: "LLM Tools Should Be Read-Only Interfaces to Facts and Evidence"
date: 2026-07-17
draft: false
weight: 6
hiddenInHomeList: true
description: "Tools should expose structured facts, deterministic calculations, and bounded evidence without making decisions on the model's behalf."
tags: ["LLM systems", "tool use", "evidence", "agent architecture"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/posts/llm-system-architecture/) · Part 6 of 11

In an LLM–algorithm system, a tool group should be a read-only interface to environment state, algorithm outputs, and mechanism evidence.

Tools retrieve information and perform deterministic computation. They should not generate natural-language conclusions, recommend actions, or execute state changes. The model combines structured evidence into an interpretation and a bounded proposal; a verifier and deterministic backend retain authority over legality and execution.

## A Tool Is Closer to a Query API Than an Autonomous Agent

The role of a tool is to make information that already exists in an environment or algorithm accessible, verifiable, and citable.

```text
environment or algorithm
    -> read-only query and deterministic computation
    -> structured facts and mechanism evidence
    -> model interpretation and bounded decision
    -> verifier and backend execution
```

Every prompt-visible tool should make two properties explicit:

```yaml
read_only: true
returns_action_recommendations: false
```

Read-only does not mean that a tool can only return a stored field. It may aggregate, decompose, trace, or run a bounded replay. It simply must not modify state or convert its calculation into a policy recommendation.

## Three Types of Queries

| Query type | Question answered | Typical output | Evidence strength |
|---|---|---|---|
| Direct fact query | What is true now? | Current state, candidates, constraints, algorithm result, objective value | Descriptive evidence |
| Deterministic derived query | How was this value formed? | Metric decomposition, event trace, lifecycle, triggered constraints | Accounting relation or mechanism clue |
| Bounded counterfactual query | What changes if one authorized variable changes? | Matched replay, alternative result, local what-if difference | Stronger causal evidence when the contract holds |

Every query must obey the visibility boundary of the current decision. A backend may know future events or held-out outcomes, but the online model must not receive them merely because a tool can technically access them.

## Provide Mechanism Evidence, Not Mechanism Conclusions

Explaining a number requires two different responsibilities.

The tool should reveal how the number was constructed, which events contributed to it, and which controlled comparisons are available. The model may then explain why that evidence matters for the current task.

For example, a metric query might return:

```yaml
metric_id: total_cost
value: 128.4
decomposition_type: accounting
components:
  processing_cost: 91.2
  waiting_cost: 17.6
  failure_penalty: 19.6
provenance:
  run_id: ...
  decision_point: ...
  formula_version: ...
mechanism_status: resolved
```

The components explain how the total is added up. They do not automatically prove why a policy caused those values.

It is useful to distinguish:

1. **Accounting decomposition:** how a metric is composed.
2. **Event trace:** how state and events evolved over time.
3. **Bounded counterfactual:** what changed when one authorized variable changed while the remaining contract was held fixed.

Only the third supports a stronger causal interpretation. When evidence is insufficient, the tool should return a state such as `mechanism_status: unresolved` instead of filling the gap with a plausible story.

## Use a Metric Registry, Not a Library of Conclusions

A versioned metric registry can define how values are obtained and decomposed:

```yaml
metric_id: failure_penalty
unit: cost
formula_version: v1
source_fields: [...]
decomposer: ...
trace_hook: ...
visibility_scope: current_decision
supported_counterfactuals: [...]
```

The registry should specify where the value comes from, how it is computed, when it is visible, and which decompositions are valid. It should not contain statements such as “a high value means choose action A.” Those statements are policy, not metric definition.

## Give the Model a Compact Tool Contract

The model needs to know which tools exist, when they are useful, and what their limits are. The prompt should therefore include a compact, structured tool contract rather than a long manual.

```yaml
tool_name: explain_metric
purpose: Return a metric value, deterministic decomposition, and provenance
inputs:
  metric_id: string
  scope_id: string
outputs:
  value: number
  components: array
  provenance: object
  mechanism_status: enum[resolved, partial, unresolved]
read_only: true
returns_action_recommendations: false
visibility_scope: current_decision
limitations:
  - accounting decomposition does not establish causality
```

Expose only the tools relevant to the current task. Large tool collections can provide discovery queries such as `list_available_tools`, `list_available_metrics`, or `describe_metric` so the model can inspect capabilities on demand.

## Prefer a Small Summary with On-Demand Drill-Down

The workflow should not insert every metric, decomposition, and trace into every prompt. The default context can contain:

- a small set of essential facts;
- the names and purposes of available tools or metrics;
- the call budget and visibility boundary.

When the model finds an anomaly, it can drill down:

```text
explain_metric
    -> trace_entity or trace_event
    -> compare_bounded_counterfactual, when authorized
```

If live calls are unavailable, the workflow may precompute a small set of diagnostics using a versioned selection rule. It should record what was available, what was selected, and why, so preprocessing does not silently make the decision for the model.

## What Tools Must Not Do

A read-only evidence tool should not:

- return a preferred action or candidate ranking;
- modify environment, memory, or backend state;
- replace the verifier's legality check;
- execute retry, fallback, checkpoint, or action logic;
- expose future events or held-out labels;
- package a natural-language mechanism claim as a deterministic fact;
- invent a conclusion when evidence is unresolved.

If a deterministic tool can independently choose the action, it should be implemented and evaluated as a deterministic policy. Its decision should not be attributed to the LLM.

The value of a tool is not that it helps the model sound more intelligent. It makes the environment and algorithm queryable, citable, and verifiable. Once a tool begins to embed policy, LLM–algorithm collaboration collapses into a deterministic program making the decision while the model explains it afterward.
