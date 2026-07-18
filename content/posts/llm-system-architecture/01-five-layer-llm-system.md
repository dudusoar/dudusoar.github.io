---
title: "Separate Schemas, Prompts, Tools, Workflows, and Memory in an LLM System"
date: 2026-07-17
draft: false
weight: 1
hiddenInHomeList: true
description: "Why an LLM decision system needs five separable layers rather than one increasingly large prompt."
tags: ["LLM systems", "agent architecture", "workflows", "auditability"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/posts/llm-system-architecture/) · Part 1 of 11

A small LLM prototype can often be built with one prompt. Put the current state, a few examples, the output format, and an instruction into a single block of text, then see whether the model returns a plausible answer.

That is enough for a smoke test. It is not enough for a system that must be reproduced, audited, or trusted to affect an external process.

Once the prototype becomes a real decision system, the important questions change:

- What information did the model actually see?
- Which versions of the prompt, tools, and memory were used?
- Did the output satisfy a machine-checkable contract?
- Why did the verifier accept or reject it?
- Which retry or fallback path ran after a failure?
- Can the same decision be replayed and ablated?

At that point, stop treating the system as a large prompt. Decompose it into **schemas, prompts, tools, workflows, and memory**.

## Why the Five Layers Must Be Separate

Each pair of mixed responsibilities creates a distinct failure mode.

| Responsibilities mixed together | What becomes difficult to verify |
|---|---|
| Schema and prompt | Whether the output contract changed or the wording merely changed |
| Tool and workflow | Whether a failure came from the call, its parameters, the retry policy, or the budget |
| Memory and live prompt | Whether historical information leaked across data splits or was actually used |
| Model decision and verifier | Whether the model bypassed deterministic feasibility checks or repair logic |
| Run loop and checkpointing | Whether a failed step can be restored, replayed, and diagnosed |

Separation does more than make the repository look tidy. It gives every kind of change an owner, a version, a validation rule, and a failure record.

## The Five-Layer Architecture

### Schema

Schemas define the structural contracts for observations, candidates, actions, memory records, tool calls, and audit events.

A schema turns an informal agreement into a contract that code can check. It defines required fields, legal values, field origins, and representations for invalid states.

### Prompt

The prompt translates the current task and the information the model is allowed to use into a readable decision context.

It explains the task, the action boundary, the visible facts, the relevant history or retrieved experience, the requested justification, and the output contract. Deterministic validation, retry, and execution logic belong elsewhere.

### Tool

Tools expose typed and restricted capabilities. They may retrieve information, compute a deterministic decomposition, inspect a candidate set, or call an authorized verifier.

A tool must not silently expand the model's authority. If an observation interface already returns the preferred action, the tool, not the model, made the decision.

### Memory

Memory is a traceable external evidence layer with provenance, applicability conditions, versions, and visibility rules.

Do not insert historical experience into the live prompt as an untracked paragraph. The workflow retrieves a specific memory version, exposes an authorized view, and records whether the model cited or used it.

### Workflow

The workflow assembles the other four layers. It selects component versions, connects inputs and outputs, controls retries and fallbacks, writes checkpoints, and records every validation and execution step.

The central relationship is:

```text
components are reusable;
the workflow is the assembly and audit surface.
```

Without this role, a system can be split into many files and still remain a black box. The workflow is what makes the connections observable.

## How Separation Limits Model Authority

The five layers make it possible to define a narrow and explicit role for the model.

- The model submits an action allowed by the action schema rather than directly mutating the full system state.
- Tools expose authorized information and deterministic computations rather than unrestricted backend access.
- A verifier and deterministic executor retain authority over legality, feasibility, repair, and execution.
- Memory remains external evidence with provenance instead of becoming invisible background knowledge in the prompt.
- The workflow decides when memory and tools are visible and how failures are handled.

New methods can then replace an evidence adapter, a memory strategy, or an action adapter without copying an entire runtime.

## How Separation Improves Evaluation

A useful run record contains more than the final outcome. At minimum, it answers these questions:

- Did the input pass schema validation?
- Which prompt, tool, workflow, and memory versions were used?
- Which memories were retrieved and exposed?
- Did the model produce a legal action object?
- Did the verifier accept it?
- Was a retry or fallback triggered, and why?
- Was enough intermediate state saved to replay the decision?

This makes precise conditions possible:

```text
no memory
memory exposed but not used
tool failure with fallback
schema error with retry
verifier-rejected action
```

Those conditions distinguish failures that otherwise collapse into a single statement such as “the model performed poorly.” A memory may never be retrieved. It may be shown but ignored, change the proposed action, or change an action that the verifier later rejects. Measure these system behaviors separately.

## Workflow Is More Than Orchestration

The five components alone do not make the architecture auditable. The workflow must serve as both the assembly surface and the audit surface.

Component reuse controls engineering cost. Workflow traces protect the meaning of an experiment and the reliability of a production decision. Without the trace, a modular codebase can still be an opaque system.

Prompt sophistication does not make an LLM decision system trustworthy. Trust depends on whether each decision can be validated, replayed, and attributed to the component that actually changed it.
