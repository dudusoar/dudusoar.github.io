---
title: "Paper Release: Reviewing the Reviewer"
date: 2026-03-23
draft: false
tags: ["paper", "LLM", "graph reasoning", "knowledge graph", "Amazon"]
categories: ["Research"]
description: "Our paper on graph-enhanced LLM reasoning for e-commerce appeal adjudication is now on arXiv, submitted to KDD 2026."
summary: "Our paper on using conflict-aware graph reasoning to ground LLM decisions in verifiable actions is now on arXiv. We achieved 96.3% alignment with human experts in production — up from 70.8% with LLMs alone."
showToc: false
---

Our paper **"Reviewing the Reviewer: Graph-Enhanced LLMs for E-commerce Appeal Adjudication"** is now available on arXiv.

**arXiv**: [2603.19267](https://arxiv.org/abs/2603.19267)

This work was done during my Applied Scientist internship at Amazon (Summer 2025).

---

## The Problem

In e-commerce, seller appeals go through a two-tier review process: a **Maker** makes the initial decision, and a **Checker** audits it. Sometimes the Checker overturns the Maker — and these overturn events encode exactly *why* the first decision was wrong.

The challenge: **information asymmetry**. The Checker often had access to verification tools and cross-case precedents that the Maker never used. A standard LLM reading the same case file will make the same mistakes — it doesn't know what it doesn't know, and will hallucinate a confident answer where the right answer is "I need more information."

## What We Did

We introduced the **Evidence-Action-Factor-Decision (EAFD)** schema — a structured representation that inserts *verification actions* between raw evidence and final decisions. The key insight: grounding LLM reasoning in verifiable operations (rather than unconstrained text generation) prevents hallucination at the architectural level.

On top of this, we built a **conflict-aware graph reasoning framework** that:
- Constructs EAFD graphs from historical Maker-Checker disagreements
- Aggregates them into a retrievable knowledge base
- Performs top-down deductive reasoning for new cases
- Knows when to **Request More Information** instead of forcing a premature decision

## Results

| System | Alignment |
|--------|-----------|
| LLM-only baseline | 70.8% |
| + Action modeling (EAFD) | 87.5% |
| + Knowledge graph retrieval | 95.8% |
| **Production deployment** | **96.3%** |

The jump from 70.8% to 87.5% comes entirely from introducing the Action layer — before any retrieval. This confirms that information asymmetry, not model capability, was the core bottleneck.

## Why It Matters

The EAFD framework isn't specific to e-commerce. Any domain with hierarchical human review generates the same correction signals — legal appeals, medical second opinions, financial compliance. The same principle applies: **learn from the gap between the first reviewer and the second**.

For the full technical deep-dive, check out the [publication page](/publications/amazon-rj/).

---

*Yuchen Du, Ashley Li, Zixi Huang. Submitted to KDD 2026, Applied Data Science Track.*
