---
title: "Treat the Prompt as a Decision Interface, Not a State Dump"
date: 2026-07-17
draft: false
weight: 5
hiddenInHomeList: true
description: "A prompt follows the order of an actual decision and keeps facts, memory, tools, actions, and runtime logic in separate layers."
tags: ["LLM systems", "prompt design", "decision interfaces", "evaluation"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/posts/llm-system-architecture/) · Part 5 of 11

The prompt is the model's decision interface, not a place to concatenate everything the system knows.

A well-designed prompt follows the order of the decision. It explains the task, the action boundary, the current facts, relevant history or external experience, the requested justification, and the output contract. Keep content with different sources and responsibilities in distinct blocks.

This structure makes it possible to know what the model actually saw, why it made a judgment, and whether two methods were compared under the same prompt contract.

## Organize the Prompt by Decision Order

When a model reads a prompt for the first time, it needs to understand the problem before it sees internal version identifiers, audit fields, tool metadata, or a large raw state table.

Use this reading order:

```text
task context
    -> scope of control and action semantics
    -> currently visible facts
    -> action history from the current run
    -> authorized external experience
    -> requested judgment and justification
    -> output contract
```

This mirrors the actual decision process:

1. What am I trying to do?
2. What am I allowed to do?
3. What is true now?
4. What has already happened in this run?
5. What prior experience may I use?
6. Why should I choose one action over another?
7. In what structure must I return the answer?

Prompts organized by artifact-generation order often do the opposite. They begin with internal metadata, then append raw state, then mix policy rules, history, and output fields. That order may be convenient for code assembly, but it creates a poor decision interface.

## Keep Each Layer Focused on Its Own Content

| Content | Proper source | What should not be mixed into it |
|---|---|---|
| Task, role, and action boundary | Stable task layer | Case-specific facts and debug fields |
| Current state and candidates | Observation schema or read-only tool | Recommendations and policy rules |
| Actions already taken in this run | Same-run action history | Cross-split experience and future outcomes |
| External experience | Retrieved memory or evidence layer | Current facts and hidden commands |
| Legal actions and return fields | Action schema and output contract | Free-form conventions that change between runs |
| Verification, retry, and fallback | Workflow and runtime | Execution logic disguised as prompt advice |
| Debugging and complete audit data | Artifacts and logs | Fields irrelevant to the current judgment |

The prompt describes legal actions and the required return format. Deterministic validation and runtime logic remain outside the model.

## Return Facts from Observation Tools, Not Policy

An observation tool contaminates the prompt when it returns candidate rankings, preferred actions, or decision hints. Once the tool embeds a deterministic policy, a correct model answer may simply repeat a hidden recommendation rather than demonstrate model reasoning.

Declare this boundary for every prompt-visible observation tool:

```text
returns_action_recommendations = false
```

If a deterministic procedure can decide the action, implement and evaluate it as a baseline or policy in its own right. Do not hide it inside an observation interface and attribute the decision to the model.

## Keep the System Prompt Short and Stable

Keep the stable role, task, and highest-level boundaries in the system prompt. Deliver dynamic state, candidates, memory, evidence, and output fields through named and versioned payloads.

This prevents two common problems:

- every case receives a slightly different copy of a long natural-language instruction;
- a field change simultaneously alters the task definition, information permission, and output format.

Different methods can share a common reading skeleton while supplying their own action semantics, observation adapters, and evidence layers. What is shared is the structure, not the research or business meaning.

## Expose the Minimum Decision-Relevant View

Store complete state packets, raw artifacts, and audit records outside the prompt. Give the model a compact view of the facts needed for the current decision.

Repeated facts are especially dangerous. If the same value appears in a raw packet, a tool output, a table, and a natural-language summary, the prompt grows while creating opportunities for inconsistency.

A prompt budget is therefore an information-priority policy:

1. Preserve the task and action boundary.
2. Preserve facts needed to distinguish legal actions.
3. Preserve relevant same-run history and retrieved experience.
4. Preserve a concise justification requirement and output contract.
5. Remove duplicated, debugging, compatibility, and offline-only fields.

## Prove Which Prompt Actually Ran

A prompt file existing in a repository does not prove that a live policy consumed it.

For every important run, preserve:

- the actual system prompt and payload sent to the model;
- a prompt variant, version, or hash;
- the observation, memory, and evidence actually exposed;
- the raw response and parsed action;
- the verifier result;
- a matched comparison when a prompt layer changes.

Runtime artifacts, not source-code presence, establish which prompt contract affected the decision.

## Prompt Layers Are Experimental Variables

Clear layering makes controlled comparisons possible. Keep the task, action semantics, observation, and output contract fixed between no-memory and memory-enabled conditions. Change only the retrieved evidence layer.

When several layers change together, it becomes impossible to tell whether a result came from wording, additional information, tool hints, a larger action space, or actual model capability.

A boundary-conscious decision interface does not improve by growing into a longer policy document. Every block must answer three questions:

- Why is this information provided by this component?
- Why does the model need it for the current action?
- Which experimental variable changes if it is removed?

When prompt structure can be versioned, replaced, and ablated independently, it becomes a real engineering component rather than scattered natural-language configuration.
