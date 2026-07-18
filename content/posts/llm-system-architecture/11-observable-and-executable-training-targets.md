---
title: "A Training Target Must Be Both Observable and Executable"
date: 2026-07-17
draft: false
weight: 11
hiddenInHomeList: true
description: "A strong teacher result is a valid target only when the model can observe its basis and execute the same action."
tags: ["LLM systems", "training data", "teacher labels", "action spaces"]
categories: ["technical"]
showToc: true
math: false
---

> **Series:** [Building Auditable LLM Systems](/posts/llm-system-architecture/) · Part 11 of 11

A stronger planner or teacher producing a better result does not mean its choice can be used directly as an LLM training target.

A result is eligible for training only when it passes two gates:

1. The model can observe the information on which the result depends.
2. The model is authorized and able to execute the corresponding action.

Otherwise the result can expose an information gap, an action-space gap, or a hindsight upper bound. It should not be presented as an answer the model ought to have learned.

## Training Defines a Question and an Answer

Every training example implies:

```text
the question visible to the model
    -> the action the model should produce
```

If the answer depends on information absent from the question, or requires an action outside the model's authority, the example is not merely difficult. It is invalid for the current learning contract.

A strong teacher result should therefore pass information compatibility and action compatibility before its quality is considered.

## Gate 1: Could the Model See the Same Basis?

The question is not whether the teacher and model used the same complete case. It is:

> Why did the teacher choose this action at this decision point, and was that decisive evidence present in the model's actual input?

The following results are not direct training targets:

- the teacher used future events, a complete episode, or hindsight outcomes;
- the teacher decided after a state transition while the model saw the earlier state;
- the teacher used detailed constraints or plans that were compressed away in the prompt;
- the teacher read information through a hidden interface unavailable to the model.

These results may prove that additional information has value. They do not prove that the model should make the same decision from its current input.

## Gate 2: Can the Model Execute the Same Action?

Even under equal information, a teacher may have a larger action space.

Suppose a model can select one candidate or defer, while the teacher can globally reorganize several existing decisions. The teacher's result cannot be reduced automatically to one of the model's local labels.

Action compatibility requires:

- the target exists in the model's closed action set;
- the action is legal under the current action mask;
- the parameters, objects, and timing can be expressed by the interface;
- a global teacher plan is not mislabeled as one local model choice;
- after verification and execution, the model action produces the same kind of state change as the target.

If these conditions fail, the result identifies an action-space gap rather than a classification error.

## The Four Possible Outcomes

| Same information basis? | Action executable? | Proper use |
|---|---|---|
| Yes | Yes | Candidate training target, subject to further quality checks |
| Yes | No | Evidence of an action-space gap |
| No | Yes | Evidence of an information gap or hindsight advantage |
| No | No | Upper-bound or diagnostic evidence only |

The last three categories are not useless. Repeated information gaps may justify adding a legitimate observable signal. Repeated action gaps may justify redesigning the action contract. A result that fails both gates can still quantify the value of a stronger system.

What should not happen is silently mapping those results to the nearest legal label simply to increase the training-set size.

## A Concrete Example

At one decision point, a model sees the currently available requests and resources. It may choose candidate A, candidate B, or wait.

A teacher with access to the complete future knows that an urgent event will arrive two minutes later. It chooses B now to preserve A for that future event.

The choice may be clearly better in hindsight, but it is not a valid target for the current model:

- the model cannot see the future event;
- any explanation for preserving A would require inventing evidence absent from the input;
- a reasonable choice based on current information may be incorrectly labeled as wrong.

The target becomes learnable only if the teacher is restricted to the same visible information, or if a legitimate prediction of future risk is added to the model's authorized input.

## Separate Input, Target, and Diagnostics

A training record may store many fields, but their roles differ.

| Content | Purpose | May enter the model input? |
|---|---|---|
| Decision-time visible state | The actual question | Yes |
| Legal action set | The choices available | Yes |
| Training target | The answer used by the learning process | No |
| Teacher source and result | Provenance of the answer | No; diagnostic only |
| Information and action compatibility checks | Eligibility gate | No; quality-control only |
| Hindsight outcome or complete episode | Evaluation and diagnosis | No for the original online decision |

If answer provenance, hindsight results, or compatibility judgments leak into the input, high training accuracy does not demonstrate online decision ability.

## Passing the Two Gates Is Only Eligibility

Equal information and executable action establish that a target does not violate the learning contract. They do not establish that it is a good target.

Further checks should ask:

- Is the teacher actually better than a simple rule or current policy?
- Are labels stable across similar states rather than sensitive to random seeds?
- Are training and validation strictly separated?
- Can the model outperform a baseline using only a few obvious features?
- Does reproducing the target improve online outcomes after real execution?

The two gates are the first qualification step, not a complete theory of data quality.

## A Stronger Teacher Is Not Automatically a Better Teacher

It is tempting to assume that every step of a globally better solution is a correct local answer. But an online model learns bounded actions under bounded information. It is not learning to imitate a system that knows more and can do more.

A teacher becomes useful for supervision only after its advantage is expressed through evidence the model can observe and an action the model can execute. Until then, it is a valuable diagnostic or upper bound—not a label.
