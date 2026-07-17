---
title: "Separate Offline Memory Extraction from Online Action Execution"
date: 2026-07-17
draft: false
weight: 2
series: ["Building Auditable LLM Systems"]
description: "A clean LLM architecture separates the production of reusable experience from its read-only use during online decisions."
tags: ["LLM systems", "memory", "online decision making", "evaluation"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/series/building-auditable-llm-systems/) · Part 2 of 11

An LLM system that learns from historical experience and acts online has two fundamentally different jobs:

1. produce reusable experience from past evidence;
2. use authorized experience to make a current decision.

These jobs may reuse the same engineering layers, but they should not share the same information permissions or prompt responsibilities.

The clean boundary is simple: **offline processing produces memory; online control consumes it read-only**.

## Why Mixing Offline and Online Stages Is Dangerous

When extraction and execution are mixed, experimental boundaries become difficult to defend.

| Mixed behavior | Risk |
|---|---|
| Writing new memory during an online evaluation | Future or held-out information can leak into later decisions |
| Using an unfixed memory schema | Retrieval becomes an opaque text-similarity operation |
| Inserting all historical experience into every prompt | Exposure and actual use cannot be distinguished |
| Leaving the online action space undefined | The model may drift between incompatible kinds of decisions |
| Reusing one prompt for extraction and action | Learning, retrieval, and execution responsibilities become inseparable |

The offline/online split is therefore an information and causal boundary, not just a directory structure.

## The Overall Architecture

```text
offline:
  historical scenarios / teacher evidence / replay / counterfactuals
  -> memory extraction workflow
  -> structured, versioned memory bank

online:
  current decision snapshot
  -> retrieve relevant memory
  -> expose an authorized view
  -> choose a legal action or call an allowed tool
  -> validate, verify, and execute
```

The online stage must not write the outcome of a held-out run back into a memory bank that remains available during the same evaluation.

## Offline Memory Extraction

The offline stage does not directly act on the current environment. Its question is:

> What should be extracted from historical evidence, and in what structure should it be stored?

A complete offline design must specify:

- **Sources:** historical cases, teacher comparisons, failure traces, replay, or bounded counterfactuals;
- **Content:** patterns, lessons, warnings, applicability conditions, and possible action implications;
- **Structure:** typed records, provenance, confidence, source split, and validation state;
- **Leakage controls:** which data partitions are permitted to contribute memory;
- **Auditability:** how every memory record maps back to its source artifact and extraction version.

Using the five-layer architecture, the offline side becomes:

```text
offline schema:
  memory record / provenance / applicability / extraction audit

offline prompt:
  extract a pattern, lesson, warning, or action implication from evidence

offline tools:
  load evidence, compare alternatives, inspect replay, trace a failure boundary

offline workflow:
  extract -> validate -> deduplicate -> checkpoint -> freeze a memory version

offline memory:
  structured, versioned, and split-aware
```

The result should not be a folder of natural-language summaries. It should be a validated memory asset whose origin and allowed use are explicit.

## Online Action Execution

The online stage asks a different question:

> How is relevant memory retrieved, what information is exposed, what tools are available, and what actions are legal now?

It must define:

- how memory is matched to the current state;
- whether a memory item is a recommendation, warning, gate, or context;
- which read-only tools the model may call;
- which bounded actions the model may propose;
- how schema validation, verification, retry, fallback, and execution are ordered.

The online side becomes:

```text
online schema:
  decision snapshot / retrieved memory / tool call / action / audit record

online prompt:
  current context + selected memory + legal action instructions

online tools:
  retrieve memory, inspect current evidence, verify a proposed action

online workflow:
  snapshot -> retrieval -> prompt -> tool or action -> validation -> verification -> execution

online memory:
  read-only retrieved evidence plus a utilization audit
```

The output of an online decision is not only an action. It is a trace containing retrieval, exposure, model response, validation, verification, fallback, effective action, and outcome.

## What the Two Sides May Share

Offline and online workflows can share generic infrastructure:

- schema validation;
- checkpointing;
- restricted APIs;
- artifact logging;
- version tracking;
- workflow auditing.

They should not share a mutable state or use one prompt for different responsibilities. The offline side produces and validates experience. The online side retrieves an authorized version and acts within a bounded action space.

Sharing infrastructure is useful. Sharing information permissions is dangerous.

## Evaluate Memory Quality and Controller Quality Separately

Offline and online failures should be tested independently.

Offline comparisons might include:

```text
no memory bank
old schema vs. new schema
correct vs. shuffled memory
train-only memory vs. an explicit leakage check
```

Online comparisons might include:

```text
no retrieval
retrieval without utilization reporting
retrieval with evidence citation
tools disabled
verifier-only or fallback-only conditions
restricted vs. expanded action spaces
```

Memory use should also be measured as a sequence rather than a binary flag:

```text
memory retrieved
memory exposed
memory cited
memory changed the action
memory improved the outcome
```

None of these stages implies the next. Retrieval does not prove exposure; exposure does not prove use; use does not prove action change; action change does not prove improvement.

## Two Independent Causal Chains

The deepest value of the offline/online split is diagnostic. It turns “memory did not help” into two causal chains that can fail independently:

- Was the experience valid, well structured, and applicable?
- Was it retrieved, understood, converted into an action, accepted, and executed?

Only when these stages are separate can a system locate the real failure rather than treating memory as a mysterious block of text added to a prompt.
