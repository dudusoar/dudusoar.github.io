---
title: "Share Only Modules Whose Meaning Survives a Method Change"
date: 2026-07-17
draft: false
weight: 9
hiddenInHomeList: true
description: "Share code across LLM methods only when its meaning, lifecycle, failure handling, and tests remain unchanged."
tags: ["LLM systems", "software architecture", "research engineering", "modularity"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/posts/llm-system-architecture/) · Part 9 of 11

Several LLM methods can share infrastructure. Share only the components whose meaning, timing, and tests remain unchanged.

Sending model requests, validating output structure, recording traces, and executing legal actions are often generic. The meaning of evidence, the semantics of an action, the way experience is learned, and the definition of success are usually method-specific.

Do not decide the boundary from code duplication alone. Ask whether sharing changes or conceals the meaning of the method.

## The Basic Question

When a second or third method appears in the same system, one choice repeats:

```text
Should this component be shared by every method,
or should it remain inside the current method?
```

The easiest mistake is to compare code shapes. Two files contain similar fields, functions, or steps, so they are merged. But a research or decision system must protect semantics, not only reduce repetition.

A better test is:

> If the research question, evidence, and action all change, does this component still express the same idea and accept the same tests?

- If yes, it belongs in a shared layer.
- If no, it belongs inside the method.
- If it is stable only within one family of methods, share it within that family rather than across the entire system.

## Keep the Shared Layer Focused on Mechanical Work

Shared infrastructure handles work whose meaning remains stable across methods:

- send a request to the model and receive a response;
- call a registered read-only tool;
- validate the response against a declared schema;
- record what the model saw and returned;
- handle timeout, retry, and predefined fallback behavior;
- pass an accepted action to a deterministic executor;
- save component versions and checkpoints.

These operations do not need to know why a particular piece of evidence matters or which action is preferable. They continue working unchanged when the method changes.

This is often called a shared runtime. The name matters less than the constraint: it must not contain a hidden position on the method being evaluated.

## The Method Layer Owns the Meaning

Method-specific code contains the choices that define the actual hypothesis or business logic:

- what a piece of evidence means and when it applies;
- which actions the model may choose and what those actions do;
- which historical outcomes become experience;
- how experience is retrieved and used;
- what the prompt asks the model to analyze;
- what counts as help, harm, or no effect;
- which baselines and comparisons are appropriate.

This layer can be treated as a research or task adapter. Its purpose is to keep one hypothesis within a boundary where it can be changed, compared, or removed without changing the runtime for every other method.

## Duplicate Code Does Not Imply Duplicate Meaning

Two methods may each contain a field named `risk_score`. In one method it may represent the risk of a delayed outcome; in another it may represent the value of escalating to an expensive process. The fields may have the same type and even similar calculations while expressing different concepts.

Premature sharing creates four common problems:

1. **Meaning is flattened.** Important differences are forced into one common interpretation.
2. **Changes contaminate other methods.** A shared modification made for one method alters another method's behavior.
3. **Results cannot be attributed.** The common layer already contains a method-specific judgment.
4. **Old assumptions become hard to remove.** A failed method leaves fields and rules inside infrastructure that every method uses.

In early research and system exploration, a small amount of duplication is often safer than an incorrect abstraction. Once semantics and lifecycle are stable, consolidation is usually cheaper than untangling a shared module that encodes several incompatible meanings.

## Share Interfaces Without Sharing Semantics

Different methods can use the same integration points while retaining their own internal meaning.

A shared runtime may ask each adapter:

```text
provide the current observation
provide the allowed tools
provide the legal action schema
provide the validation and execution result
```

Each method then supplies:

```text
which observations matter
how tool results should be interpreted
which actions are legal here
why an action might improve the outcome
how improvement should be evaluated
```

The shared layer provides stable slots. The method fills those slots with its own evidence and action semantics.

## Four Tests Before Promoting Code to the Shared Layer

| Question | Requirement |
|---|---|
| Is the meaning the same? | The component answers the same question, not merely one with a similar name |
| Is the lifecycle the same? | Creation, reading, modification, and expiration happen at the same times |
| Is failure handling the same? | Missing, invalid, timed-out, or rejected states receive the same treatment |
| Are the tests the same? | One test suite can protect the behavior without method-specific reinterpretation |

If any answer is no, keep the component method-specific or share it only inside a narrower family.

## Every Layer Has a Shared Shell and Method-Specific Meaning

| Component | Potentially shared shell | Usually method-specific meaning |
|---|---|---|
| Schema | Validation, versions, and error format | Evidence fields, action fields, and domain semantics |
| Prompt | Reading order and output requirements | Task, action explanation, and judgment criteria |
| Tool | Registration, invocation, timeout, and logging | Which metrics and scopes matter |
| Workflow | Call, validation, retry, logging, and execution order | How evidence enters judgment and when capabilities are used |
| Memory | Storage, versioning, provenance, and read-only access | Experience content, applicability, retrieval, and utilization |

Research engineering aims to make every experiment and system behavior interpretable, not to eliminate as much duplication as possible. A mature shared component continues to work when the method changes. If it repeatedly needs to know which method is active, it probably contains meaning that belongs in the adapter.
