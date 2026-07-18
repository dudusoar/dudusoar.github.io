---
title: "Separate Facts from Model Judgment in LLM Schemas"
date: 2026-07-17
draft: false
weight: 3
hiddenInHomeList: true
description: "A schema preserves the boundary between computed facts, model judgments, explicit rationale, and external feedback."
tags: ["LLM systems", "schema design", "reasoning", "auditability"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/posts/llm-system-architecture/) · Part 3 of 11

An LLM schema does more than list fields. It defines the boundary between facts, model judgment, and feedback.

Two principles are especially important:

1. Label whether each value comes from deterministic computation or model inference.
2. Store every model judgment with the explicit rationale produced for that decision.

The first principle protects the factual boundary. The second preserves the model's decision-time account of its judgment.

## Principle 1: Distinguish Computed Fields from Model Inference

Give every schema field a clear producer.

| Field type | What it describes | Typical content | How it can be checked |
|---|---|---|---|
| Computed fact | What happened or what the system knows | IDs, time, state, cost, constraints, tool results, verifier results, execution outcomes | Unit tests, recomputation, schema validation, artifact reconciliation |
| Model inference | How the model interprets facts | Hypotheses, risks, applicability judgments, proposed actions, uncertainty, rationale | Evidence references, consistency checks, repeated tests, human audit |

If stable code or an external artifact can reconstruct a field, do not ask the model to regenerate it for convenience. The model may read a cost, a feasibility result, or a tool output, but it must not overwrite those values.

This rule applies across the system:

- An observation schema provides facts before asking the model to interpret risk.
- A decision schema fixes candidates and constraints before asking the model to choose.
- A tool schema records inputs and outputs before the model explains how the result matters.
- A memory schema reconstructs an episode before asking the model to extract a lesson.
- An evaluation schema computes outcomes before asking the model to interpret them.

Make field origin part of the schema contract rather than an assumption hidden in code or prompt text.

## Principle 2: Preserve the Model-Provided Rationale

A final label or action tells us what the model selected. It does not tell us:

- which evidence the model considered;
- how it interpreted that evidence;
- which factors affected the decision;
- why one action was selected over alternatives;
- what uncertainty remained.

Store each model judgment with an explicit, decision-time rationale.

To make that rationale useful rather than merely verbose, four constraints help.

### Bind the rationale to evidence

Require the explanation to cite concrete `evidence_refs` that point to fields or tool results the model actually saw. An explanation without evidence anchors cannot be checked.

### Freeze the rationale with the decision

Save the factual snapshot, rationale, and judgment together. Append verifier results, human review, and execution outcomes later, but never rewrite the original rationale. Otherwise the record becomes a post-hoc explanation.

### Keep raw justification and structured fields together

Preserve the original model-provided explanation while also extracting fields such as `decision_factors`, `alternatives_considered`, and `uncertainty`. Structured summaries support search and comparison, but they must not silently replace the original response.

### Do not confuse rationale with ground truth

A rationale is the model's explicit account of a particular decision. It is not proof of a hidden internal reasoning process, and it does not replace a verifier or an observed outcome. It tells us how the model presents its interpretation; external feedback tells us whether the interpretation was useful.

A minimal structure might be:

```yaml
computed:
  observation: ...
  candidates: ...
  constraints: ...

model_inference:
  judgment: ...
  rationale:
    raw: ...
    evidence_refs: [...]
    decision_factors: [...]
    alternatives_considered: [...]
    uncertainty: ...

computed_feedback:
  verifier_result: ...
  execution_outcome: ...
```

## Preserve the Complete Decision Scene

The schema records a decision trajectory, not just a final output:

```text
what the model saw
    -> how it interpreted the evidence
    -> why it made the judgment
    -> what it proposed
    -> how the external system responded
```

This trajectory creates richer learning material than an `action + outcome` pair. It allows later analysis to distinguish cases such as:

- a useful interpretation that led to a useful action;
- an incorrect interpretation that caused a failure;
- a reasonable rationale paired with the wrong action;
- a valid proposal rejected by the verifier;
- a correctly identified risk that never changed the action.

The natural unit for later learning becomes:

```text
input + rationale + decision + external feedback
```

That unit can support the extraction of reusable decision patterns, failure modes, and applicability conditions.

## Both Principles Must Hold Together

Separating field origins without preserving a rationale still leaves model-generated labels opaque. Preserving a rationale without a factual boundary turns the explanation into unverifiable prose.

Together, the two principles create a traceable chain:

```text
computed facts
    -> model judgment + explicit rationale
    -> bounded decision
    -> verifier and execution outcome
    -> comparison and feedback
```

Schema design does not ask the model to fill every field. It preserves a decision scene that can be reconstructed later: facts supplied by the system, judgment supplied by the model, the rationale frozen with that judgment, and external feedback appended afterward.
