---
title: "Fix Fact Ownership and Evidence Provenance in LLM Systems"
date: 2026-07-17
draft: false
weight: 8
series: ["Building Auditable LLM Systems"]
description: "Every fact, interpretation, proposal, and outcome in an LLM system needs a clear owner and a traceable evidence lineage."
tags: ["LLM systems", "provenance", "auditability", "memory"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/series/building-auditable-llm-systems/) · Part 8 of 11

Every fact, interpretation, and decision in an LLM system needs a clear owner.

An artifact records what happened. A model may interpret evidence but should not overwrite it. A validator decides whether derived content is suitable for a versioned asset. A controller may propose an action, while a verifier and backend decide what is actually executed.

Any derived information must preserve the lineage from source facts to final use. Being summarized by a model, stored in memory, or inserted into a prompt does not grant information greater factual authority.

## Ownership Means Authority to Treat Something as True

Ownership is not about which module stores a file. It is about who may generate, validate, modify, and rely on a class of information.

For example, a model may suggest that an increase in a metric is related to a particular mechanism. It cannot therefore rewrite the metric value or claim that the mechanism has been proven. Memory may preserve the interpretation for future retrieval, but storage does not turn a hypothesis into a fact.

At minimum, distinguish:

```text
source facts: what actually happened
derived interpretations: what those facts may mean
decisions and consequences: what the system proposed, executed, and later observed
```

These objects can be connected. They should never overwrite one another.

## Each Layer Owns Only Its Own Judgment

| Layer | What it may decide | What it may not decide |
|---|---|---|
| Environment or artifact | State, data split, provenance, algorithm results, and outcomes | Why those facts matter or which action should be taken |
| Tool | Read authorized sources and perform deterministic computation or tracing | Recommend actions or produce unsupported mechanism claims |
| Model abstraction | Propose interpretations, lessons, warnings, and uncertainty within the evidence | Override source facts or claim unverified causality |
| Compiler or validator | Decide whether fields are supported and suitable for a versioned asset | Invent missing facts or choose an action for the controller |
| Memory and retrieval | Store sourced experience and return an authorized view | Rewrite source artifacts or decide which action is legal |
| Prompt and controller | Combine visible evidence and propose a bounded action | Modify facts or bypass the action contract |
| Verifier and backend | Decide legality and feasibility, then produce the effective action | Rewrite what the model saw or its original rationale |
| Audit log | Append records of transformation, exposure, use, and execution | Replace failed or inconvenient history with a clean narrative |

The purpose of these boundaries is not to create more modules. It is to stop authority from drifting between them.

## Define an Ownership Contract

Marking a field as `computed` or `model_generated` is useful but incomplete. A reusable object should answer:

```yaml
object_type: ...
producer: ...
source_refs: [...]
validator: ...
mutability: immutable | append_only | versioned
visibility_scope: ...
authorized_consumers: [...]
derived_from: [...]
can_override_source: false
version: ...
```

The most important fields are:

- `producer`: who created the object;
- `source_refs` and `derived_from`: which evidence supports it;
- `validator`: who can approve its structure and evidence;
- `mutability`: whether it is immutable, append-only, or versioned;
- `visibility_scope`: which decisions and data splits may see it;
- `can_override_source: false`: a derived interpretation cannot replace its source.

A schema defines field-level origin inside an object. An ownership contract protects authority as the object moves across artifacts, memory, prompts, and workflows.

## Derived Assets Inherit Provenance, Not Authority

A complete evidence lineage might look like:

```text
immutable source artifact
    -> deterministic evidence view
    -> bounded model abstraction
    -> compiler or validator
    -> versioned memory asset
    -> authorized retrieval view
    -> model rationale + proposed action
    -> verifier + effective action
    -> observed outcome + append-only audit
```

Every step may add information, but it must not silently change the meaning of the previous step.

- An evidence view may filter and compute but should not pretend to be the raw source.
- A model abstraction may interpret but should not pretend to be deterministic evidence.
- A memory asset may organize experience but should retain source references.
- Retrieval may rank and expose evidence but should not turn ranking into an action recommendation.
- A controller may propose an action but should not label it as the effective action.
- An outcome may add feedback but should not be rewritten as information available before the decision.

Provenance is therefore more than a path. It records transformations, versions, producers, validators, and the exact view used at decision time.

## Artifacts Are Snapshots; Memory Is a Controlled Derivative

An artifact preserves a reviewable decision scene or execution result. It may contain deterministic facts, model output, and external feedback, but every part should remain clearly labeled by origin.

Memory is a versioned derivative compiled from historical evidence. It should retain:

```text
source provenance
evidence fields
model abstraction
validation status
applicability and visibility contract
```

A lesson or warning stored in memory remains an interpretation based on evidence. It is not automatically true for a future case. Online retrieval should expose only the version authorized by the current split and visibility contract.

## Correct by Appending, Not by Rewriting History

An auditable system should correct itself by adding new records or versions:

- Freeze the model's original analysis, rationale, and proposal at decision time.
- Append verifier rejection, fallback, and effective action afterward.
- Append outcome and attribution after execution.
- When a memory record is wrong, preserve it with a deprecation reason and create a new version.
- When a source artifact is corrected, preserve the replacement relationship.
- Never feed a held-out outcome back into the same evaluation as retrievable experience.

This is how the system can answer what the model knew then, why it acted, what was executed, and what became known only later.

## Provenance Enables Layer-by-Layer Attribution

A final result should be traceable through the following questions:

- Where did the source facts come from?
- Which deterministic or model-generated transformations were applied?
- Which content passed validation?
- Which version was exposed online?
- What evidence did the model cite?
- What action did it propose?
- What did the verifier accept and the backend execute?
- What was later observed, and how strong is the attribution?

Without ownership and provenance, all failures collapse into “the model was wrong.” With them, a failure can be located in source data, computation, model interpretation, memory compilation, retrieval, action conversion, verification, fallback, execution, or outcome attribution.

The most dangerous drift in an LLM system is not a single incorrect field. It is an interpretation copied through enough layers that its source disappears and every component begins treating it as fact. Fixed ownership prevents that drift and gives memory, action, and feedback a trustworthy foundation.
