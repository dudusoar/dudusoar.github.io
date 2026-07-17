---
title: "The Action Space Is the Anchor of LLM System Design"
date: 2026-07-17
draft: false
weight: 7
series: ["Building Auditable LLM Systems"]
description: "Define what an LLM is allowed to change before designing its schemas, prompts, tools, workflows, and memory."
tags: ["LLM systems", "action spaces", "guardrails", "feedback"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/series/building-auditable-llm-systems/) · Part 7 of 11

The action space is the anchor of an LLM decision system.

Before designing prompts, tools, memory, or workflow logic, the system should answer a simpler question: **What is the model actually allowed to change?**

Once that boundary is fixed, the rest of the architecture can be derived from it:

```text
What may the model change?
    -> What must it know to choose that action?
    -> How can the system verify that the action follows from that evidence?
    -> How is the model prevented from taking other actions?
    -> Who validates and executes the proposal?
    -> How are consequences returned as feedback?
```

Schemas, prompts, tools, workflows, and memory all serve this chain from information to action and consequence.

## Define the Complete Action Contract

An action cannot be defined by a label such as `approve`, `defer`, or `escalate` alone. A complete action contract should specify:

| Question | What must be fixed |
|---|---|
| What changes? | The object, field, resource, or backend arm affected |
| When is it legal? | Decision point, preconditions, action mask, and information boundary |
| What are the parameters? | Legal enums, identifiers, ranges, budgets, and validity period |
| What does the action mean? | Deterministic backend semantics rather than a natural-language implication |
| Who executes it? | The model, a verifier, or a deterministic backend |
| What happens on failure? | Invalid-output, timeout, rejection, retry, and fallback behavior |
| What happens under uncertainty? | Abstain, defer, request evidence, or another pre-authorized exit |
| How is the consequence measured? | Immediate state change, delayed outcome, cost, and failure boundary |

An explicit uncertainty exit matters. If a system forces the model to choose a positive action with insufficient evidence, the model is likely to fill the evidence gap with a fluent justification. Whether it may abstain or request more evidence should be decided by the contract, not invented during inference.

## Derive Every Component from the Action Space

| Component | Question it must answer about the action |
|---|---|
| Schema | Which actions and parameters are legal? Which evidence, rationale, expected consequence, and error states are required? |
| Prompt | What do actions mean? What is prohibited? What uncertainty exits exist? |
| Tool | Which facts and mechanism evidence are needed to distinguish the legal actions? |
| Memory | Under what conditions and rationale was an action taken, and what happened afterward? |
| Workflow | How does the system move from observation and justification to verification, execution, and feedback? |

This ordering also controls scope. If a prompt paragraph, field, tool, or memory item cannot identify which legal action it supports or which consequence it helps evaluate, it usually does not belong in the online decision interface.

## Use a Closed Action Set

Bounded action is not achieved by adding “do not exceed your authority” to the prompt. The execution interface must accept only predefined actions.

```text
raw model response
    -> structured proposed action
    -> schema validation
    -> action mask and permission check
    -> verifier
    -> accepted action or deterministic fallback
    -> effective backend action
```

A robust implementation has several properties:

- legal actions use a closed enum or bounded parameters;
- only structured action fields enter the execution interface;
- rationale text cannot change state;
- tools remain read-only and cannot bypass the action contract;
- unknown IDs, invalid parameters, and missing preconditions are rejected;
- a verifier and deterministic backend retain execution authority;
- proposed action, verifier result, fallback action, and effective action are stored separately.

The model may propose an action. It cannot gain new authority by inventing a field or embedding a command in its explanation.

## Require a Traceable Justification Chain

A structurally legal action may still be unsupported or based on fabricated evidence. Every decision should therefore preserve:

```text
information
    -> analysis
    -> rationale
    -> proposed action
```

| Layer | Question | Minimum requirement |
|---|---|---|
| Information | What did the model actually see? | References to visible facts, tool results, or memory with provenance |
| Analysis | What does that evidence mean here? | Risks, constraints, trade-offs, and uncertainty without turning hypotheses into facts |
| Rationale | Why does the analysis support this action? | Connection to the objective and rejection of major alternatives |
| Action | What should the system execute? | A unique, legal, fully parameterized object from the action contract |

A minimal record might be:

```yaml
evidence_refs: [...]
analysis:
  decision_factors: [...]
  uncertainty: ...
rationale:
  selected_action_reason: ...
  alternatives_rejected: [...]
proposed_action:
  type: ...
  parameters: ...
expected_consequence: ...
```

The evidence snapshot, analysis, rationale, and proposal should be frozen together. Later outcomes may be appended but should not rewrite the original decision.

## Reconnect Actions to Consequences

A system that learns from feedback needs more than a final score. It must know whether the proposed action was executed, what changed immediately, and which later outcomes can reasonably be attributed to it.

```text
proposed action
    -> verifier result
    -> effective action
    -> immediate consequence
    -> delayed outcome
    -> attributed feedback
```

These states should not be collapsed:

- If a proposal is rejected, the later outcome is not the consequence of that proposal.
- If fallback is used, the learning target is the effective action while the failed proposal remains recorded.
- Immediate consequences describe direct state changes; delayed outcomes may depend on later events and decisions.
- Co-occurrence of an action and an outcome does not establish causality.

When attribution is uncertain, the record should say so:

```yaml
decision_context: ...
evidence_refs: [...]
analysis_and_rationale: ...
proposed_action: ...
expected_consequence: ...
verifier_result: ...
effective_action: ...
observed_consequence: ...
counterfactual_ref: ...
attribution_status: direct | supported | correlated | unresolved
expectation_gap: ...
```

## A Practical Design Order

An action-centered workflow can be designed in this order:

```text
1. Define legal actions, semantics, parameters, and uncertainty exits.
2. Define permissions, preconditions, verifier, backend, and fallback.
3. Define expected consequences and evaluation rules.
4. Derive the observation, tools, and facts needed for the decision.
5. Design the evidence, rationale, and action output contract.
6. Record proposed and effective actions with their consequences.
7. Assemble and version the entire chain in the workflow.
```

The action space determines where the model is useful. Starting with it turns every later design question into a concrete test: Is this information necessary? Is this tool making the decision? Is this rationale supported? Did the experience change an effective action? Did the action cause the observed outcome?
