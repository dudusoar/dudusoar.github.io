---
title: "A Prompt Is a Decision Interface, Not a Dump of System State"
date: 2026-07-17
draft: false
description: "Prompts should follow the order of an actual decision and keep facts, memory, tools, actions, and runtime logic in separate layers."
tags: ["LLM systems", "prompt design", "decision interfaces", "evaluation"]
categories: ["technical"]
showToc: true
math: false
---

A prompt is not a place to concatenate everything the system knows. It is the model's decision interface.

A well-designed prompt follows the order in which a decision must be made. It explains the task, the action boundary, the current facts, relevant history or external experience, the requested justification, and the output contract. Content with different sources and responsibilities should not be mixed into one undifferentiated block.

This structure makes it possible to know what the model actually saw, why it made a judgment, and whether two methods were compared under the same prompt contract.

## Organize the Prompt by Decision Order

When a model reads a prompt for the first time, it needs to understand the problem before it sees internal version identifiers, audit fields, tool metadata, or a large raw state table.

A useful reading order is:

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

## Each Layer Should Carry Only Its Own Content

| Content | Proper source | What should not be mixed into it |
|---|---|---|
| Task, role, and action boundary | Stable task layer | Case-specific facts and debug fields |
| Current state and candidates | Observation schema or read-only tool | Recommendations and policy rules |
| Actions already taken in this run | Same-run action history | Cross-split experience and future outcomes |
| External experience | Retrieved memory or evidence layer | Current facts and hidden commands |
| Legal actions and return fields | Action schema and output contract | Free-form conventions that change between runs |
| Verification, retry, and fallback | Workflow and runtime | Execution logic disguised as prompt advice |
| Debugging and complete audit data | Artifacts and logs | Fields irrelevant to the current judgment |

The prompt may describe legal actions and the required return format. It should not ask the model to perform deterministic validation or to reproduce runtime logic in natural language.

## Observation Tools Should Return Facts, Not Policy

One of the most subtle prompt contaminations occurs when an observation tool returns candidate rankings, preferred actions, or decision hints.

If the tool has already embedded a deterministic policy, a correct model answer no longer demonstrates model reasoning. The model may simply be repeating a hidden recommendation.

A prompt-visible observation tool should be explicit:

```text
returns_action_recommendations = false
```

If a deterministic procedure can already decide the action, it should be implemented and evaluated as a baseline or policy in its own right. It should not be hidden inside an observation interface and attributed to the model.

## Keep the System Prompt Short and Stable

The system prompt should contain the stable role, task, and highest-level boundaries. Dynamic state, candidates, memory, evidence, and output fields should arrive through named and versioned payloads.

This prevents two common problems:

- every case receives a slightly different copy of a long natural-language instruction;
- a field change simultaneously alters the task definition, information permission, and output format.

Different methods can share a common reading skeleton while supplying their own action semantics, observation adapters, and evidence layers. What is shared is the structure, not the research or business meaning.

## Expose the Minimum Decision-Relevant View

Complete state packets, raw artifacts, and audit records should be stored outside the prompt. The model should receive a compact view containing the facts needed for the current decision.

Repeated facts are especially dangerous. If the same value appears in a raw packet, a tool output, a table, and a natural-language summary, the prompt grows while creating opportunities for inconsistency.

A prompt budget is therefore an information-priority policy:

1. Preserve the task and action boundary.
2. Preserve facts needed to distinguish legal actions.
3. Preserve relevant same-run history and retrieved experience.
4. Preserve a concise justification requirement and output contract.
5. Remove duplicated, debugging, compatibility, and offline-only fields.

## Prove Which Prompt Actually Ran

A prompt file existing in a repository does not prove that a live policy consumed it.

Every important run should preserve:

- the actual system prompt and payload sent to the model;
- a prompt variant, version, or hash;
- the observation, memory, and evidence actually exposed;
- the raw response and parsed action;
- the verifier result;
- a matched comparison when a prompt layer changes.

Runtime artifacts, not source-code presence, establish which prompt contract affected the decision.

## Prompt Layers Are Experimental Variables

Clear layering makes controlled comparisons possible. A no-memory condition and a memory-enabled condition should share the task, action semantics, observation, and output contract. Only the retrieved evidence layer should change.

When several layers change together, it becomes impossible to tell whether a result came from wording, additional information, tool hints, a larger action space, or actual model capability.

A good prompt is not a longer and more sophisticated policy document. It is a boundary-conscious decision interface. Every block should answer three questions:

- Why is this information provided by this component?
- Why does the model need it for the current action?
- Which experimental variable changes if it is removed?

When prompt structure can be versioned, replaced, and ablated independently, it becomes a real engineering component rather than scattered natural-language configuration.
