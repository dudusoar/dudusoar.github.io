---
title: "Establish Fact Ownership and Evidence Provenance in LLM Systems"
date: 2026-07-17
draft: false
weight: 8
hiddenInHomeList: true
description: "Every fact, interpretation, proposal, and outcome in an LLM system needs a clear owner and a traceable evidence lineage."
tags: ["LLM systems", "provenance", "auditability", "memory"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/posts/llm-system-architecture/) · Part 8 of 11

Every fact, interpretation, and decision in an LLM system needs a clear owner.

An artifact records what happened. A model may interpret evidence but cannot overwrite it. A validator determines whether derived content is suitable for a versioned asset. A controller proposes an action; a verifier and backend determine what is actually executed.

Any derived information must preserve the lineage from source facts to final use. Being summarized by a model, stored in memory, or inserted into a prompt does not grant information greater factual authority.

## Ownership Means Authority to Treat Something as True

Ownership defines who may generate, validate, modify, and rely on a class of information—not which module stores a file.

For example, a model may suggest that an increase in a metric is related to a particular mechanism. It cannot therefore rewrite the metric value or claim that the mechanism has been proven. Memory may preserve the interpretation for future retrieval, but storage does not turn a hypothesis into a fact.

At minimum, distinguish:

```text
source facts: what actually happened
derived interpretations: what those facts may mean
decisions and consequences: what the system proposed, executed, and later observed
```

Connect these objects without allowing one to overwrite another.

## Each Layer Owns Only Its Own Judgment

| Layer | What it owns | What it does not own |
|---|---|---|
| Environment or artifact | State, data split, provenance, algorithm results, and outcomes | Why those facts matter or which action should be taken |
| Tool | Read authorized sources and perform deterministic computation or tracing | Recommend actions or produce unsupported mechanism claims |
| Model abstraction | Propose interpretations, lessons, warnings, and uncertainty within the evidence | Override source facts or claim unverified causality |
| Compiler or validator | Decide whether fields are supported and suitable for a versioned asset | Invent missing facts or choose an action for the controller |
| Memory and retrieval | Store sourced experience and return an authorized view | Rewrite source artifacts or decide which action is legal |
| Prompt and controller | Combine visible evidence and propose a bounded action | Modify facts or bypass the action contract |
| Verifier and backend | Decide legality and feasibility, then produce the effective action | Rewrite what the model saw or its original rationale |
| Audit log | Append records of transformation, exposure, use, and execution | Replace failed or inconvenient history with a clean narrative |

These boundaries prevent authority from drifting between layers; the number of modules is secondary.

## Define an Ownership Contract

Labels such as `computed` and `model_generated` are useful, but they do not fully specify ownership. A reusable object answers:

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

Each step may add information, but it must preserve the meaning of the previous step.

- An evidence view may filter and compute, but it remains distinct from the raw source.
- A model abstraction may interpret, but it remains distinct from deterministic evidence.
- A memory asset may organize experience while retaining source references.
- Retrieval may rank and expose evidence without turning the ranking into an action recommendation.
- A controller may propose an action, but only the verifier and backend produce the effective action.
- An outcome adds feedback without becoming information that was available before the decision.

Provenance is therefore more than a path. It records transformations, versions, producers, validators, and the exact view used at decision time.

## Artifacts Are Snapshots; Memory Is a Controlled Derivative

An artifact preserves a reviewable decision scene or execution result. It may contain deterministic facts, model output, and external feedback; label each part clearly by origin.

Memory is a versioned derivative compiled from historical evidence. It retains:

```text
source provenance
evidence fields
model abstraction
validation status
applicability and visibility contract
```

A lesson or warning stored in memory remains an interpretation based on evidence. It is not automatically true for a future case. Online retrieval exposes only the version authorized by the current split and visibility contract.

## Correct by Appending, Not by Rewriting History

An auditable system corrects itself by adding new records or versions:

- Freeze the model's original analysis, rationale, and proposal at decision time.
- Append verifier rejection, fallback, and effective action afterward.
- Append outcome and attribution after execution.
- When a memory record is wrong, preserve it with a deprecation reason and create a new version.
- When a source artifact is corrected, preserve the replacement relationship.
- Never feed a held-out outcome back into the same evaluation as retrievable experience.

This is how the system can answer what the model knew then, why it acted, what was executed, and what became known only later.

## Provenance Enables Layer-by-Layer Attribution

Trace a final result through the following questions:

- Where did the source facts come from?
- Which deterministic or model-generated transformations were applied?
- Which content passed validation?
- Which version was exposed online?
- What evidence did the model cite?
- What action did it propose?
- What did the verifier accept and the backend execute?
- What was later observed, and how strong is the attribution?

Without ownership and provenance, all failures collapse into “the model was wrong.” With them, a failure can be located at a specific stage: source data, computation, model interpretation, memory compilation, retrieval, action conversion, verification, fallback, execution, or outcome attribution.

The most dangerous drift in an LLM system is not a single incorrect field. It is an interpretation copied through enough layers that its source disappears and every component begins treating it as fact. Explicit ownership prevents that drift and gives memory, action, and feedback a trustworthy foundation.
