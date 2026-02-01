## 0. DBS Metadata (Machine-Read)

```yaml
odp_compiler_contract:
  id: "ode.opsdeskecommerce"
  version: "0.1.0"
  sha256: "1942733633010E1FF15132F8362950D58687724D154172F3A85D55B9B8821EDD"
```

# MASTER DBS — CANONICAL (LOCKED STRUCTURE)

## Authority Statement
This document defines the sole and authoritative meaning of “DBS” for this project and all future work derived from it.
All prior DBS definitions, frameworks, or interpretations are deprecated and invalid.
This document, when complete, is sufficient to build the complete application with zero external clarification.

---

## 1. Purpose & Authority

**Section 11 Supremacy (Hard Lock):**
- Section 11 ("Engine Pipeline") is the authoritative definition of engine behavior.
- If any other DBS section conflicts with Section 11, the other section is wrong and MUST be patched to match Section 11.
- No exceptions. No interpretation outside written text.

### 1.1 Product Purpose (Authoritative)

OpsDesk Ecommerce is a deterministic, operator-grade system that converts raw inventory inputs (photos, documents, spreadsheets) into marketplace-ready, defensible outputs through evidence-based processing and explicit operator decisions.

The system exists to:
- reduce ambiguity in resale and inventory workflows
- surface evidence clearly and calmly
- prevent silent assumptions, guesses, or overrides
- scale from single-operator use to commercial volume without changing behavior

The system does not exist to:
- speculate
- persuade
- recommend actions beyond explicit evidence
- hide uncertainty
- “help” by inventing data

Accuracy, auditability, and repeatability take precedence over speed or convenience.

---

### 1.2 Intended User (Locked)

The primary user is a single professional operator responsible for inventory intake, review, pricing decisions, and downstream export or publishing.

Multi-user collaboration, roles, and permissions are out of scope unless explicitly added in a future DBS version.

---

### 1.3 Scope Boundaries (Hard)

The system’s responsibility ends at producing validated, reviewable, exportable inventory records and preserving evidence and decision context.

The system is not responsible for marketplace account management, financial reconciliation, tax reporting, fulfillment, or customer communication.

---

### 1.4 Authority Hierarchy (Locked)

1. DBS (this document)
2. Canonical Example Packs
3. Verification & Enforcement Gates
4. Derived artifacts
5. Implementation code
6. Documentation or verbal explanations

---

### 1.5 Source-of-Truth Rule

The engine is the source of truth for derived data.
The operator is the source of truth for editable decisions.
The UI is a constrained surface.
The DBS defines what is allowed to exist at all.

---

### 1.6 Commercial-Grade Definition

Commercial-grade means deterministic behavior, explainable outputs, explicit failure on ambiguity, and auditability.
It does not mean automation, guessing, or AI recommendations.

---

### 1.7 Enforcement Clause

Any behavior contradicting this section is a DBS violation regardless of intent.

---

---

## 2. Single-Sentence Contract

### 3. Glossary & Defined Terms

**Purpose (Hard):** Define terms so the DBS cannot be “interpreted” differently by different implementers.

- **DBS:** Deterministic Blueprint Spec; sole authority. If behavior is not specified, it is **not allowed** (see Section 17).
- **Stage:** A pipeline step named in Section 11; stages occur in a fixed order.
- **Evidence:** An artifact used to justify identity/pricing decisions; must be preserved and referenceable.
- **Paid Provider:** Any provider that consumes paid quota/credits; MUST be blocked by preflight/sufficiency rules.
- **Block-but-preserve:** If blocked, computation halts but prior outputs remain intact; no silent continuation.

OpsDesk Ecommerce converts raw inventory inputs into marketplace-ready outputs using deterministic, evidence-based processing and explicit operator decisions, and it never invents truth when evidence is weak or missing.

---

## 3. Glossary & Defined Terms (LOCKED)

All terms defined in this section are authoritative.
Any term used elsewhere in the DBS that is not defined here is invalid.

---

**DBS (Deterministic Blueprint Spec)**  
The authoritative specification that defines all allowed system behavior, structure, data, and UI.  
Type: System Artifact

**Operator**  
The human user responsible for reviewing evidence and making explicit decisions within the system.  
Type: Actor

**Raw Inventory Input**  
Any unprocessed file supplied to the system, including images, documents, or spreadsheets.  
Type: Input Artifact

**Evidence**  
Externally sourced or derived information used to support identity, pricing, or readiness decisions.  
Type: Data Artifact

**Derived Data**  
Any data value produced by the engine through deterministic processing rather than direct operator input.  
Type: Data (Derived)

**Editable Decision**  
A data value explicitly set or confirmed by the operator.  
Type: Operator Action

**Marketplace-Ready Output**  
A validated inventory record that satisfies all required invariants and is eligible for export or publishing.  
Type: System State

**Deterministic**  
Producing identical outputs from identical inputs under identical DBS rules.  
Type: System Property

**Weak Evidence**  
Evidence that fails to meet required confidence or agreement thresholds defined elsewhere in the DBS.  
Type: Condition

**Invented Truth**  
Any system-generated value not directly supported by evidence or explicit operator input.  
Type: Forbidden Behavior

---

## 4. Global Invariants (LOCKED)

Global invariants define rules that must always hold across all system layers.
If any invariant conflicts with another section, the invariant wins unless explicitly overridden in the DBS.

---

### 4. Global Invariants

- Deterministic: same inputs + same caches => same outputs.
- Truth-over-output: weak evidence => block/needs_review, not fabricated values.
- No silent mutation: changes require recorded decisions.
- UI/Engine separation: UI MUST present/organize; must not change truth or compute pricing.

### 4.1 Determinism
1. Given identical Raw Inventory Inputs and identical DBS version, the system must produce identical Derived Data and identical system decisions.
2. Non-deterministic behavior is forbidden unless explicitly declared and gated.

---

### 4.2 Truth & Evidence
3. The system must never produce Invented Truth.
4. Any non-operator value presented as factual must be supported by Evidence or be clearly labeled as Derived Data.
5. Evidence must be preserved and remain inspectable wherever it influences readiness or output.

---

### 4.3 Operator Authority
6. The operator is the final authority for all Editable Decisions.
7. The system MUST NOT override an operator’s Editable Decision without explicit operator action and a recorded reason.

---

### 4.4 Derived vs Editable
8. Derived Data must be non-editable by default.
9. Any field that is editable must be explicitly declared editable in the DBS; otherwise it is derived and locked.

---

### 4.5 Block-but-Preserve State
10. When the system encounters Weak Evidence or any unmet requirement, it must:
    - preserve all computed intermediate state
    - mark the relevant record as blocked / needs review
    - prevent it from being considered a Marketplace-Ready Output
11. The system must not fill gaps to unblock a record.
12. The system MUST allow navigation and review of blocked items, but must block export or publish eligibility until requirements are satisfied by evidence and/or operator decisions.

---

### 4.6 Safety Against Silent Drift
13. Silent changes to meaning are forbidden, including:
    - silent schema expansion
    - silent defaults that change outcomes
    - silent reinterpretation of evidence
14. Any behavior change that affects outputs must require a DBS version change and updated gates.

---

### 4.7 UI / Engine Boundary
15. UI must not fabricate or transform truth; it MUST only display Derived Data, display Evidence, and collect Editable Decisions as defined by the DBS.
16. Engine must not rely on UI for truth derivation; UI is a surface, not a brain.

---

### 4.8 Auditability
17. For any Marketplace-Ready Output, the system must be able to show:
    - what evidence supported the outcome
    - what the operator decided
    - what DBS version governed the behavior

---

## 5. Non-Goals & Forbidden Behaviors (LOCKED)

This section defines explicit non-goals and forbidden behaviors.
Any behavior listed here is forbidden even if implied elsewhere.

---

### 5. Non-Goals & Forbidden Behaviors

- No AI pricing or AI-driven value adjustments.
- No weighting/blending/decay/smoothing that changes SOLD-derived pricing.
- No triage-based query pack changes (“cheap mode”).
- No inventing identity, comps, or condition when evidence is weak.

### 5.1 Non-Goals (Explicit)
1. The system is not designed to perform the operator’s judgment.
2. The system is not designed to maximize automation at the expense of correctness or auditability.
3. The system is not designed to provide recommendations, coaching, or persuasive guidance.
4. The system is not designed to always produce an answer; block-but-preserve is the correct response to insufficient support.

---

### 5.2 Forbidden Behavior Classes (Global)

**Truth violations**
5. Inventing values, identities, prices, or conclusions not supported by Evidence or explicit operator decision.
6. Presenting inferred or guessed values as factual.

**Silent overrides**
7. Overriding operator decisions without explicit operator action and recorded reason.
8. Changing derived outputs via hidden heuristics or defaults.

**Ambiguity hiding**
9. Masking Weak Evidence by filling gaps or smoothing outputs.
10. Automatically unblocking a record without new Evidence or operator action.

**UI deception**
11. UI designs that imply certainty when evidence is weak.
12. UI-side transformations that change the meaning of engine outputs.

---

### 5.3 Engine Freeze (Hard Lock)
13. No pipeline stage MUST be added, removed, reordered, merged, split, or bypassed unless the DBS is changed and versioned.
14. No stage MUST silently alter upstream or downstream truth ownership.
15. No engine output schema MUST gain or lose keys, change meaning, or change defaulting behavior unless the DBS is changed and versioned.
16. No new export columns or output fields MUST be created outside DBS-governed schema changes.
17. No temporary debug logic, flags, or shortcuts MUST exist in production behavior unless explicitly defined in the DBS.

---

### 5.4 Forbidden “Evolving” Patterns
18. Refactors that change observable behavior are forbidden without a DBS change.
19. Best-practice substitutions are forbidden if they change output shape, ordering, readiness logic, or evidence handling.
20. Any implementation behavior not explicitly allowed by the DBS is forbidden.

---

### 5.5 Enforcement
21. Any violation of this section constitutes a hard DBS failure regardless of intent.
22. Passing tests is insufficient; gates must explicitly enforce these constraints.

---

## 6. Degrees of Freedom Register (LOCKED)

Global rule:
Any behavior, choice, or variation not explicitly listed in this register is forbidden by default.

This register enumerates the only areas where discretion is allowed.

---

### 6. Degrees of Freedom Register

- Operator MUST approve/reject/export and record decisions.
- UI presentation choices are allowed only when explicitly specified in Section 12, and MUST NOT alter truth.
- Engine has **no** discretion: if a rule is written, follow it; if not written, do not do it.

### 6.1 Operator Degrees of Freedom (Allowed)

| Area | Allowed Freedom | Constraints |
|---|---|---|
| Editable Decisions | Operator MUST set or confirm values explicitly declared editable in a numbered DBS section | Must be explicit, auditable, and never auto-filled |
| Review Actions | Operator MUST mark items as reviewed, blocked, or approved | Must not change Derived Data |
| Evidence Selection | Operator MUST choose which Evidence to rely on when multiple valid sources exist | Choice must be explicit and preserved |

No other operator freedoms are allowed.

---

### 6.2 Engine Degrees of Freedom (None)

The engine has no discretionary freedom.

- Pipeline stages are fixed
- Stage order is fixed
- Stage responsibilities are fixed
- Output schemas are fixed
- Defaults are fixed
- Thresholds are fixed

Any change to engine behavior requires a DBS version change.

---

### 6.3 UI Degrees of Freedom (Extremely Limited)

Allowed:
- Choice of implementation language or framework
- Internal component structure that produces identical DOM, layout, pixels, and interactions

Forbidden:
- Layout reinterpretation
- Responsive behavior MUST be fully defined in this DBS; undefined responsive behavior is forbidden.
- Visual approximation
- UX improvements
- Conditional UI logic not specified in the DBS

UI freedom exists only to reproduce the DBS-defined UI exactly.

---

### 6.4 Performance Degrees of Freedom (Constrained)

Allowed:
- Internal optimizations that do not:
  - change outputs
  - change timing semantics
  - change ordering
  - introduce race conditions
- Performance budgets MUST be defined in this DBS; undefined performance budgets are forbidden.

Forbidden:
- Caching that changes truth freshness
- Skipping stages for speed
- Parallelization that affects determinism

---

### 6.5 Tooling & Infrastructure Degrees of Freedom (Isolated)

Allowed:
- Choice of build tools, CI systems, and infrastructure providers
- Logging and diagnostics tooling (read-only)

Forbidden:
- Tooling that alters runtime behavior
- Environment-specific logic paths
- Feature flags affecting outputs

---

### 6.6 Explicit Prohibitions

The following are not degrees of freedom:
- Reasonable assumptions
- Industry best practices
- Minor refactors
- Temporary hacks
- Developer discretion

---

### 6.7 Enforcement

- Any behavior not explicitly listed above is forbidden.
- Violations are hard DBS failures regardless of intent.
- Passing tests is insufficient without conformance to this register.

---

## 7. Authority Conflict Resolution Rules (LOCKED)

This section defines the deterministic process for resolving any apparent conflicts within the DBS.
Interpretation is forbidden.

---

### 7. Authority Conflict Resolution Rules

- Conflicts are resolved by the precedence order in Section 7.x.
- **Hard rule:** Section 11 defines engine behavior; conflicting text elsewhere MUST be patched to match Section 11.
- No “best effort” interpretation outside written text.

### 7.1 Conflict Resolution Principle

**Section 11 Supremacy (Hard Lock):**
- Section 11 ("Engine Pipeline") is the authoritative definition of engine behavior.
- If any other DBS section conflicts with Section 11, the other section is wrong and MUST be patched to match Section 11.
- No exceptions. No interpretation outside written text.

If any DBS content appears to conflict, the conflict must be resolved deterministically using the rules below.
Human judgment, intent, or interpretation is not permitted.

---

### 7.2 Precedence Order (Highest → Lowest)

1. Non-Goals & Forbidden Behaviors (Section 5)
2. Global Invariants (Section 4)
3. Degrees of Freedom Register (Section 6)
4. Canonical Example Packs (Section 13)
5. Behavior Catalog (Positive + Negative Tests) (Section 9)
6. Data Reality (Schemas + Invariants) (Section 8)
7. Engine Pipeline (Stage Contracts) (Section 11)
8. UI & Pixel Blueprint (Section 12)
9. Change Control & Versioning (Section 18)

---

### 7.3 Specific Tie-Breakers

If ambiguity remains after applying precedence:

A. Stricter wins: “must” overrides “MUST”; “forbidden” overrides “allowed”; “block” overrides “continue”.  
B. Explicit beats implicit: Named fields, stages, rules, or pixels override general prose.  
C. Example beats description: Canonical example outcomes override conflicting narrative claims.  
D. Fail-closed default: If uncertainty remains, apply the Missing Spec Rule (Section 17). Until Section 17 is locked, default to block-but-preserve.  
E. No silent healing: Conflicts must be resolved by DBS change, not code adaptation.

---

### 7.4 How Conflicts Are Fixed
Conflicts MUST only be resolved by:
- Updating the DBS
- Bumping the DBS version per Section 18
- Updating gates per Section 14
- Updating Canonical Example Packs when applicable

---

### 7.5 Enforcement
- Any implementation relying on interpretation instead of this process is a DBS violation.
- Any gate that passes contradictory behavior is invalid and must be corrected.

---

## 8. Data Reality (Schemas + Invariants) (LOCKED)

Canonical Storage Model: JSON-first, item-centric.

---

### 8. Data Reality

This section defines canonical JSON shape, required keys, and invariants.
Subsections 8.x are authoritative and MUST be consistent with Sections 10–11.

### 8.1 Canonical File Layout (Authoritative)
- Canonical item record path: results/<item_id>.json
- Canonical item identifier: <item_id> is stable and immutable once created.
- Non-canonical derived artifacts (exports, thumbnails, caches) must be reproducible from canonical JSON and/or raw inputs.

---

### 8.2 Canonical JSON Rules (Canonicalization)
1. UTF-8 encoding, LF newlines, no BOM.
2. Keys must be written in stable order as defined by this DBS (field order is authoritative).
3. Arrays must be deterministically ordered where ordering is meaningful; otherwise sorting keys must be defined by the DBS.
4. Floating values must be rounded deterministically per DBS rules.
5. Timestamps must be ISO-8601 with timezone (Z) and only appear in explicitly allowed metadata fields.
6. No additional keys are permitted anywhere unless the DBS version changes.

---

### 8.3 Core Entities (Authoritative)
Top-level keys in order (and no others):
1. meta
2. inputs
3. stage
4. evidence
5. decisions
6. status
7. export

Any missing required top-level key is invalid.

---

## 8.4 Schemas

### 8.4.1 meta (Required)
Field order:
- dbs_version (string, required)
- item_id (string, required)
- created_at (string ISO-8601 Z, required)
- updated_at (string ISO-8601 Z, required)
- engine_version (string, required)
- provenance (object, required)

provenance field order:
- source_run_id (string, required)
- source_batch_id (string, optional)
- replay_mode (enum: live | replay, required)
- notes (string, optional)

Invariants:
- meta.item_id equals filename <item_id>.
- updated_at >= created_at.
- dbs_version matches the DBS lock.
- engine_version is informational but required.

Forbidden:
- Missing provenance.
- Non-ISO timestamps.

---

### 8.4.2 inputs (Required)
Field order:
- primary_inputs (array, required, min 1)
- aux_inputs (array, optional)
- input_manifest_hash (string, required)

Each input record field order:
- input_id (string, required)
- type (enum: image | pdf | csv | xlsx | zip | other, required)
- filename (string, required)
- bytes (integer, required)
- sha256 (string, required)
- uri (string, required)
- mime (string, optional)

Invariants:
- sha256 is lowercase hex length 64.
- bytes > 0.
- input_manifest_hash is deterministic over ordered inputs + sha256.

Forbidden:
- Duplicate input_id.
- Duplicate sha256 within primary_inputs unless explicitly allowed.

---

### 8.4.3 stage (Required)
Field order:
- pipeline_id (string, required)
- pipeline_order (array of stage names, required)
- outputs (object keyed by stage name, required)

Rules:
- pipeline_order is authoritative.
- No stage outside pipeline_order MUST appear in outputs.

Each stage output field order:
- status (enum: not_run | ok | blocked | error, required)
- started_at (string ISO-8601 Z, optional)
- ended_at (string ISO-8601 Z, optional)
- runtime_ms (integer, optional)
- data (object, optional)
- errors (array of strings, optional)

Invariants:
- status=ok requires data.
- status=error requires non-empty errors.
- status=blocked MUST include data (block-but-preserve).
- runtime_ms >= 0.

Forbidden:
- Silent success with missing data.
- Unknown stage keys.

---

### 8.4.4 evidence (Required)
Field order:
- sources (array, required)
- selected (object, required)

Evidence source field order:
- evidence_id (string, required)
- kind (enum: image_signal | search_result | listing | sold_comp | retail_offer | manual_note, required)
- origin (enum: engine | operator, required)
- ref (string, required)
- url (string, optional)
- title (string, optional)
- price (number, optional)
- currency (string, optional)
- timestamp (string ISO-8601 Z, optional)
- raw (object, optional)

selected field order:
- identity_evidence_ids (array, required)
- pricing_evidence_ids (array, required)

Invariants:
- selected IDs must reference existing evidence_id values.

Forbidden:
- Selecting non-existent evidence.
- Evidence kinds outside enum.

---

### 8.4.5 decisions (Required)

**Schema Additions Required by Section 10 (Hard):**

- Decisions MUST support deterministic recording of lifecycle transitions.

A canonical transition decision record MUST exist (one per transition event):

- `decision_type` (REQUIRED): `LIFECYCLE_TRANSITION`
- `from_state` (REQUIRED): string enum (see `status.lifecycle_state`)
- `to_state` (REQUIRED): string enum (see `status.lifecycle_state`)
- `reason_token` (REQUIRED): string (canonical token)
- `at` (REQUIRED): ISO-8601 UTC timestamp (`YYYY-MM-DDTHH:MM:SSZ`)
Notes:
- Replays MUST NOT rewrite historical transition events.
- Any operator-driven “unblock”, “re-open”, “approve”, “reject”, or “archive” MUST produce a transition decision event.

Field order:
- operator_actions (array, required)

Action field order:
- action_id (string, required)
- at (string ISO-8601 Z, required)
- actor (enum: operator, required)
- type (enum: set_field | select_evidence | mark_reviewed | mark_blocked | mark_approved, required) | lifecycle_transition
When `type = lifecycle_transition` (REQUIRED fields):
- from_state (string enum; see `status.lifecycle_state`, required)
- to_state (string enum; see `status.lifecycle_state`, required)
- reason_token (string, required)

- target (string, required)
- value (object|string|number|boolean|null, optional)
- reason (string, optional)

Invariants:
- actor is always operator.
- Any editable change must be represented here.

Forbidden:
- Silent mutation.

---

### 8.4.6 status (Required)

**Schema Additions Required by Section 10 (Hard):**

- `lifecycle_state` (REQUIRED)
  - Type: string (enum)
  - Allowed values:
    - `NEW`
    - `PREFLIGHT_BLOCKED`
    - `VISION_INSUFFICIENT`
    - `EVIDENCE_IN_PROGRESS`
    - `PRICED_PENDING_REVIEW`
    - `READY_GREEN`
    - `APPROVED_FOR_EXPORT`
    - `EXPORTED`
    - `REJECTED`
    - `ARCHIVED`
  - Semantics:
    - MUST obey Section 10 transition rules.
    - Blocked states MUST preserve evidence (block-but-preserve).

Field order:
- needs_review (boolean, required)
- blocked (boolean, required)
- block_reason (string, optional)
- marketplace_ready (boolean, required)
- readiness_reasons (array of strings, required)

Invariants:
- blocked=true ⇒ marketplace_ready=false.
- needs_review=true ⇒ marketplace_ready=false.
- marketplace_ready=true ⇒ blocked=false AND needs_review=false.
- readiness_reasons non-empty when marketplace_ready=false.

Forbidden:
- marketplace_ready true while blocked or needs_review true.

---

### 8.4.7 export (Required)
Field order:
- export_profile (string, required)
- fields (object, required)
- warnings (array of strings, required)

Invariants:
- Export fields must be derivable from canonical JSON and operator decisions.

Forbidden:
- Export adding new truth.

---

### 8.5 Cross-Schema Invariants
1. No unknown top-level keys.
2. No unknown keys at any level unless explicitly allowed.
3. Block-but-preserve applies across schemas.
4. Canonical truth must remain stable under replay.

---

## 9. Behavior Catalog (Positive + Negative Tests) (LOCKED)

This section defines authoritative must-pass and must-fail behaviors.
Any implementation that does not conform is invalid.

---

### 9. Behavior Catalog

This section contains testable behavioral statements.
Positive tests MUST pass; negative tests MUST fail.
Subsections 9.x are authoritative and MUST be consistent with Sections 10–11.

### 9.1 Test Case Format (Authoritative)
Each test case must include:
- ID
- Name
- Setup / Inputs
- Action
- Expected Result
- Forbidden Result
- Notes (optional)

All tests are evaluated against canonical item JSON (Section 8) and global invariants (Section 4).

---

## 9.2 Positive Tests (Must Pass)

### P-001 — Minimal Valid Item Record (Schema Pass)
Setup: One valid primary input with sha256, bytes, and uri.
Action: Create canonical item JSON.
Expected:
- Exactly these top-level keys exist:
  meta, inputs, stage, evidence, decisions, status, export
Forbidden:
- Missing required keys
- Unknown top-level keys

---

### P-002 — Block-but-Preserve on Weak Evidence
Setup: Evidence exists but insufficient for readiness.
Action: Evaluate readiness.
Expected:
- status.needs_review=true OR status.blocked=true
- status.marketplace_ready=false
- Partial stage data preserved
- status.readiness_reasons non-empty
Forbidden:
- Auto-filling gaps to reach ready state

---

### P-003 — Marketplace Ready Requires Clean Status
Setup: All required evidence and operator decisions exist.
Action: Mark ready.
Expected:
- marketplace_ready=true
- blocked=false
- needs_review=false
Forbidden:
- marketplace_ready=true while blocked or needs_review true

---

### P-004 — Operator Decision is Recorded
Setup: Operator selects evidence or sets a field.
Action: Apply decision.
Expected:
- New entry appended to decisions.operator_actions
- Correct type, target, and timestamp
Forbidden:
- Operator-visible change without decision record

---

### P-005 — Evidence Selection References Valid IDs

### P-006 — Vision Sufficiency FAIL Blocks Paid Providers

**Given**
- An item enters the pipeline and reaches `vision_signals`.
- `vision_signals.sufficiency.verdict = FAIL`
- `status.vision_sufficiency = FAIL`

**When**
- The system proceeds to any stage that would normally call external paid providers.

**Then**
- No paid provider calls are permitted.
- `provider_call_counts` MUST remain `0` for all paid providers.
- The reason token MUST include: `vision_insufficient_for_paid_calls`
- The pipeline halts deterministically (no “partial paid search”).

### P-007 — Vision Sufficiency PASS Permits Paid Providers Only Under Explicit Promotion Rule

**Given**
- `vision_signals.sufficiency.verdict = PASS`
- `status.vision_sufficiency = PASS`

**When**
- The system is deciding whether paid providers are allowed.

**Then**
- Paid providers MUST be used ONLY if at least one sufficiency basis is true:
  - Hard ID present (UPC / SKU / ASIN / MPN), OR
  - Brand + Model token sufficiency, OR
  - OCR rescue sufficiency
- The promotion basis MUST be recorded deterministically (no silent inference).
- If none are true, the verdict MUST be FAIL (and P-011 applies).

### P-008 — Query Pack Invariant Across Triage (Green/Yellow/Red)

**Given**
- Three items that are identical except for final triage classification (Green, Yellow, Red).

**When**
- The engine executes the search/evidence acquisition query pack.

**Then**
- The query pack definition (count, structure, and ordering) MUST be identical across Green/Yellow/Red.
- No “cheap mode,” “reduced pack,” or triage-based query variance is permitted.
- Cost controls MUST occur before search (via sufficiency gating), not by mutating the query pack.

### P-009 — SOLD-Only Pricing Invariants (No Blending/Weighting/Decay)

**Given**
- An item with sufficient SOLD comps inside the required time window.

**When**
- The engine computes pricing outputs.

**Then**
- Pricing MUST be derived from SOLD comps only.
- The SOLD comp window MUST be 365 days.
- No freshness decay, weighting, blending, smoothing, or model-based adjustment MUST modify the computed SOLD-based values.
- Any retail reference, if present, MUST be labeled as reference-only and MUST NOT change SOLD-derived values.

### P-010 — Proof Packet Required for Yellow/Red + AI QA Read-Only

**Given**
- An item whose final triage is Yellow or Red.

**When**
- The engine finalizes outputs (`proof_packet` stage).

**Then**
- A proof packet MUST exist and include:
  - Review Summary payload
  - Evidence Drawer payload (show-your-work)
- AI QA MUST run ONLY for Yellow/Red and MUST be read-only:
  - It MUST add notes/flags only
  - It MUST NOT alter identity, comps, inclusion/exclusion, or pricing values

Setup: Multiple evidence sources exist.
Action: Populate selected evidence arrays.
Expected:
- All selected IDs reference existing evidence_id values
Forbidden:
- Selecting non-existent evidence IDs

---

## 9.3 Negative Tests (Must Fail)

### N-001 — Unknown Top-Level Key
Setup: Add extra top-level key.
Action: Validate.
Expected: Hard fail.
Forbidden: Silent acceptance.

---

### N-002 — Missing Required Top-Level Key
Setup: Remove a required section.
Action: Validate.
Expected: Hard fail.
Forbidden: Auto-defaulting missing data.

---

### N-003 — Stage Output Outside Pipeline Order
Setup: stage.outputs contains undeclared stage.
Action: Validate.
Expected: Hard fail.
Forbidden: Ignoring unknown stage.

---

### N-004 — Status Contradiction
Setup:
- marketplace_ready=true AND
- blocked=true OR needs_review=true
Action: Validate.
Expected: Hard fail.
Forbidden: Silent boolean correction.

---

### N-005 — Silent Mutation
Setup: Editable value changes without decision entry.
Action: Validate.
Expected: Hard fail.
Forbidden: Allowing mutation without audit trail.

---

### N-006 — Invented Truth

### N-007 — Paid Provider Called When Vision Sufficiency FAIL (Forbidden)

**Given**
- `vision_signals.sufficiency.verdict = FAIL`

**When**
- Any paid provider call is attempted.

**Then**
- This is a hard failure:
  - `provider_call_counts` would become non-zero (forbidden)
  - The system violates the cost-control invariants and MUST be rejected.

### N-008 — Query Pack Varies by Triage (Forbidden)

**Given**
- Two items identical in all evidence and identity signals but with different triage labels.

**When**
- The engine runs evidence acquisition/search.

**Then**
- If the query pack differs (count, structure, order, or providers) between Green/Yellow/Red, the behavior MUST FAIL.
- Triage MUST NOT change the query pack; only pre-search sufficiency MUST block paid calls.

### N-009 — Retail Reference Changes SOLD-Based Pricing (Forbidden)

**Given**
- SOLD comps exist and produce a SOLD-based pricing band.

**When**
- A retail reference band is present.

**Then**
- If retail influences SOLD-based price values (blending, smoothing, “suggested band,” or adjustment), the behavior MUST FAIL.
- Retail is reference-only and MUST produce notes/triage signals only.

### N-010 — AI QA Mutates Truth (Forbidden)

**Given**
- AI QA runs for a Yellow/Red item.

**When**
- AI QA changes any of:
  - identity resolution
  - comp inclusion/exclusion
  - pricing values
  - stage outputs outside notes/flags

**Then**
- The behavior MUST FAIL as “invented truth / silent mutation.”

Setup: Export or status uses value not traceable to evidence or decision.
Action: Validate traceability.
Expected: Hard fail + blocked.
Forbidden: Guessing or best-effort values.

---

### 9.4 Enforcement
- All tests must be enforced by gates (Section 14).
- Passing unit tests alone is insufficient.
- Any violation is a DBS failure.
---
---

## 10. State & Time

### 10.1 Canonical Item Lifecycle State Machine (Hard)

This section defines the canonical lifecycle for a single item record. UI MUST present alternate views, but MUST NOT invent new states or transitions.

**State field:**
- `status.lifecycle_state` MUST be one of the enumerated states below.

**Canonical states (total order for reasoning; not a UI order):**
1) `NEW` — created/ingested; no stages executed yet.
2) `PREFLIGHT_BLOCKED` — preflight/viability gate blocked further execution (block-but-preserve).
3) `VISION_INSUFFICIENT` — vision sufficiency FAIL; paid providers blocked; pipeline halts (block-but-preserve).
4) `EVIDENCE_IN_PROGRESS` — pipeline running past sufficiency PASS and acquiring evidence.
5) `PRICED_PENDING_REVIEW` — pricing computed but item requires human review (Yellow/Red).
6) `READY_GREEN` — Green triage; marketplace-ready (no required review).
7) `APPROVED_FOR_EXPORT` — operator approved listing/export fields.
8) `EXPORTED` — export artifact produced (idempotent; repeat export allowed).
9) `REJECTED` — operator rejects item from export/listing (keep evidence; block-but-preserve).
10) `ARCHIVED` — finalized/closed; no further computation except reprint/export from existing truth.

**Block-but-preserve rule (Hard):**
- When a state is blocked (`PREFLIGHT_BLOCKED`, `VISION_INSUFFICIENT`, `REJECTED`), the system MUST:
  - preserve all prior evidence and decisions
  - forbid continuation without an explicit operator action that changes inputs or applies an override, and that action MUST be recorded

### 10.2 Allowed Transitions (Hard)

Transitions are deterministic and MUST be recorded in `decisions` with a reason token and timestamp.

Allowed transitions:

- `NEW -> PREFLIGHT_BLOCKED` (preflight gate blocks)
- `NEW -> EVIDENCE_IN_PROGRESS` (preflight passes)

- `EVIDENCE_IN_PROGRESS -> VISION_INSUFFICIENT` (vision sufficiency FAIL)
- `EVIDENCE_IN_PROGRESS -> PRICED_PENDING_REVIEW` (pricing exists AND triage is Yellow/Red)
- `EVIDENCE_IN_PROGRESS -> READY_GREEN` (pricing exists AND triage is Green)

- `VISION_INSUFFICIENT -> EVIDENCE_IN_PROGRESS` ONLY if operator provides new/clearer inputs or an explicit override that changes sufficiency inputs (must be logged)

- `PRICED_PENDING_REVIEW -> APPROVED_FOR_EXPORT` (operator approves)
- `PRICED_PENDING_REVIEW -> REJECTED` (operator rejects)
- `PRICED_PENDING_REVIEW -> EVIDENCE_IN_PROGRESS` ONLY if operator triggers re-run due to corrected identity/evidence inputs (must be logged)

- `READY_GREEN -> APPROVED_FOR_EXPORT` (operator approves) OR `READY_GREEN -> EXPORTED` (auto-export permitted only if explicitly enabled as a degree of freedom; default is manual approve)
- `READY_GREEN -> REJECTED` (operator rejects)

- `APPROVED_FOR_EXPORT -> EXPORTED` (export produced)
- `EXPORTED -> EXPORTED` (idempotent re-export allowed; must not change truth)

- Any non-ARCHIVED -> `ARCHIVED` only by explicit operator action.

Forbidden transitions (examples; must fail):
- Any blocked state -> paid-provider execution without a recorded state change
- `EXPORTED -> EVIDENCE_IN_PROGRESS` without explicit “re-open” operator action and full audit trail

### 10.3 Relationship to Triage & Proof Packet (Hard)

- `status.triage` (Green/Yellow/Red) is a classification output and MUST be consistent with `status.lifecycle_state`:
  - If triage = Green, lifecycle_state MUST be `READY_GREEN`.
  - If triage = Yellow/Red, lifecycle_state MUST be `PRICED_PENDING_REVIEW`.
- Proof packet MUST exist when triage = Yellow/Red AND lifecycle_state is `PRICED_PENDING_REVIEW`.
- AI QA is permitted only when triage = Yellow/Red and MUST be read-only (Section 11).

### 10.4 Time Semantics (Minimal Hard Rules)

- All recorded timestamps MUST be ISO-8601 UTC (`YYYY-MM-DDTHH:MM:SSZ`).
- Replays MUST NOT rewrite historical timestamps; they MUST add new events only when operator action occurs.

## 11. Engine Pipeline

This section is the authoritative engine contract.
No stage MUST be added/removed/reordered/merged/split/bypassed without a DBS change + version bump + gate updates.

The engine is multi-source, but deterministic:
- Multiple sources MUST propose candidate values
- The engine resolves winners via deterministic scoring + tie-breakers
- AI MUST ONLY extract/classify signals; AI MUST NOT select truth winners and MUST NOT set final values by preference

Pricing is pure-market math:
- Price outputs are derived from filtered SOLD comps only
- Confidence/reliability NEVER changes computed price values
- Confidence/reliability ONLY controls visibility/eligibility/blocking and messaging

---

### 11.1 Pipeline Identity

**pipeline_id**: OPEV100_PREMIUM_ENGINE
**pipeline_order (authoritative):**
1) ingest
2) preflight
3) vision_signals
4) identity_candidates
5) identity_resolve
6) taxonomy_aspects
7) evidence_acquire
8) harvest_normalize
9) comp_filter_score
10) pricing_math
11) listing_compose
12) proof_packet
13) finalize_status_export

No other stages are permitted.

---

### 11.2 Allowed External Providers (Hard-Locked)

The following providers are the ONLY allowed external sources for this DBS version.

**Vision/OCR (signals only)**
- OpenAI Vision (signals-only extraction)
- Google Cloud Vision OCR (text-only extraction)

**Sold comps (valuation backbone)**
- SerpAPI eBay Sold/Completed (primary sold comps evidence)

**Active listings (market pressure / competition context)**
- eBay Browse API (secondary context; never used as sold valuation evidence)

**Retail references (ceiling + identity support only; used cautiously)**
- Google Custom Search JSON API (primary retail reference)

**Barcode / GTIN verification (identity hardening)**
- GS1 (official) where available (Tier 1 authority)
- BarcodeLookup as fallback coverage (Tier 1/2 authority depending on field availability)

**Forbidden**
- Scraping without an explicitly listed provider
- Any AI arbitration to choose final truth
- Any AI pricing or AI-derived pricing adjustments

---

### 11.3 Canonical Internal Evidence Model (Truth Graph)

For each field F (brand/model/UPC/category/condition/price inputs), the engine constructs:
- Candidate Set: candidates[F] = list of candidate objects
- Winner: resolved[F] = single selected value (or unresolved)

Each candidate object MUST include:
- value
- field_name
- source_provider (one of Section 11.2)
- source_tier (Tier 1/2/3 per Section 11.9)
- evidence_id (must exist in evidence.sources)
- source_confidence (provider-native numeric if available; else null)
- support_score (deterministic score computed by rubric)
- reason_codes[] (deterministic)
- observed_at (ISO-8601 Z, allowed)
- raw_ref (pointer to raw payload stored/hashed)

Resolver chooses winners deterministically using:
- Source tier order (Tier 1 > Tier 2 > Tier 3) - descriptive only; MUST NOT weight scoring or pricing values.
- Agreement count across independent sources
- Match strength (UPC exact > MPN exact > model tokens > fuzzy)
- Tie-breakers (defined in Section 11.10)

Freshness is informational only:
- Freshness metrics MUST only produce warnings/notes/triage signals.
- Freshness MUST NOT influence candidate scoring, comp inclusion/exclusion, or any pricing computation.

AI MUST populate candidates, but MUST NOT set resolved winners.

---

### 11.4 Stage Contracts

#### 11.4.1 ingest
Inputs:
- Raw Inventory Inputs (images/pdf/csv/xlsx/zip)
Outputs:
- inputs.primary_inputs populated with sha256/bytes/mime/uri
- meta created with created_at/updated_at, dbs_version, engine_version
Rules:
- Deterministic hashing and ordered manifest only
- No external calls

#### 11.4.2 preflight
Purpose:
- Weed out low-viability items before paid calls
Outputs:
- stage.outputs.preflight.status = ok|blocked
- stage.outputs.preflight.data includes:
  - verdict: green|yellow|red
  - reasons[]
  - preflight_score (0-100)

Rules:
- Preflight verdicts are operational cost-control signals ONLY. They do not change truth, identity winners, or computed price values.
- Operator chooses a run_mode BEFORE any paid calls (record in decisions):
  - RUN_GREEN_ONLY (run only green; skip yellow+red)
  - RUN_GREEN_YELLOW (run green+yellow; skip red)
  - RUN_ALL (run green+yellow+red)

- Yellow and Red are treated identically for execution eligibility:
  - They run ONLY if run_mode permits (or explicit per-item override is recorded in decisions).
  - They MUST be marked needs_review=true by default (severity differs, behavior does not).

- Cost control (query pack size; DBS-defined):
  - Green: full query pack
  - Yellow: full query pack
  - Red: full query pack
  - Note: query pack size is NOT reduced by preflight verdict; preflight only affects run/skip recommendations and review severity.

- Recommendation messaging (UI/notes only; not execution):
  - Yellow: "Proceed with caution" default
  - Red: "Recommend skip paid calls" default

#### 11.4.3 vision_signals (signals only)
External calls:
- OpenAI Vision (signals extraction only)
- Google Cloud Vision OCR (text extraction only)
Outputs:
- candidates created for identity fields:
  - brand_tokens, model_tokens, upc_candidates, mpn_candidates
  - ocr_text_snippets
Rules:
- No resolved winners here
- Must preserve raw outputs with raw_ref pointers
- Must emit reason_codes for each candidate

##### 11.4.3.x Vision Sufficiency Gate (Hard Lock)

Purpose:
- Prevent paid downstream calls when vision/OCR signals are too weak to produce reliable identity/evidence.
- Allow full pipeline execution ONLY when minimum deterministic signal sufficiency is met.

Engine MUST compute and emit:
- stage.outputs.vision_signals.sufficiency.verdict = PASS|FAIL
- stage.outputs.vision_signals.sufficiency.reasons[] (deterministic reason codes)
- status.vision_sufficiency = PASS|FAIL (must match stage output)

Deterministic PASS rules:
PASS if ANY of the following is true:

A) Hard ID (format-validated)
- At least one UPC/EAN candidate passes deterministic validation rules:
  - numeric-only after normalization
  - length in {12,13,14} as applicable
  - checksum / check-digit valid when applicable

B) Brand + Model token sufficiency
- brand_tokens contains >= 1 "strong" brand token
- model_tokens contains >= 2 distinct alphanumeric model tokens
- model tokens must include at least one token with both letters+digits OR a token length >= 5 (to avoid junk)

C) OCR rescue sufficiency
- OCR text contains a UPC/EAN-like string that passes validation (A)
  OR
- OCR text yields brand_tokens >= 1 AND model_tokens >= 2 as in (B)

Otherwise FAIL.

FAIL behavior (hard, cost-control):
If verdict == FAIL:
- The pipeline MUST NOT execute ANY paid/external calls after vision_signals.
- The following providers MUST NOT be called (provider_call_counts MUST remain 0 for these):
  - SerpAPI eBay Sold/Completed
  - Google Custom Search JSON API
  - GS1
  - BarcodeLookup
  - eBay Browse API
- evidence_acquire MUST be skipped/blocked-but-preserve with readiness_reason = "vision_insufficient_for_paid_calls"
- identity_resolve external lookups MUST be skipped/blocked-but-preserve (no GS1/BarcodeLookup) and identity left unresolved/ambiguous as applicable
- status.needs_review MUST be set true
- status.marketplace_ready MUST be set false

PASS behavior (execution eligibility):
If verdict == PASS:
- The item MUST proceed to identity_candidates / identity_resolve / evidence_acquire as normal (subject to preflight run_mode).
- Preflight verdict (green/yellow/red) does NOT change query pack size.
- Preflight verdict MUST still be used for skip recommendations and review severity, but not call-volume reduction.

Promotion rule (explicit):
- A preflight RED item with vision_sufficiency PASS is eligible to run the full pipeline when run_mode permits.
- A preflight RED item with vision_sufficiency FAIL MUST NOT trigger paid calls (FAIL behavior above).

Hard invariants:
- No AI judgment MUST override PASS/FAIL.
- PASS/FAIL must be reproducible from stored raw_ref signals (no hidden state).
- This gate is a cost-control gate only; it does not set truth winners or prices.

#### 11.4.4 identity_candidates
Purpose:
- Consolidate and validate token/ID candidates deterministically
Outputs:
- candidates for:
  - UPC, EAN, MPN, Brand, Model, Variant
Rules:
- Validate UPC/EAN patterns deterministically (length/check digit rules where applicable)
- Normalize whitespace/case deterministically
- Preserve multiple candidates; do not discard unless invalid format

#### 11.4.5 identity_resolve
Purpose:
- Resolve identity winners deterministically (or leave unresolved)
External calls:
- GS1 lookup (where available)
- BarcodeLookup fallback
Outputs:
- resolved identity fields OR unresolved with needs_review
Rules:
- UPC verified by GS1/BarcodeLookup outranks OCR-only UPC
- If disagreement persists, do NOT invent truth; mark ambiguous
- Identity Collapse Rule enforced (Section 11.7)

#### 11.4.6 taxonomy_aspects
External calls:
- eBay Taxonomy API
Outputs:
- category leaf + required/recommended aspects
Rules:
- Taxonomy results are authoritative for category/aspects
- If identity unresolved, taxonomy stage MUST be blocked

#### 11.4.7 evidence_acquire
External calls:
- SerpAPI eBay Sold/Completed (sold comps)
- eBay Browse API (active listings context)
- Google Custom Search JSON (retail refs)
Outputs:
- evidence.sources appended (sold comps, actives, retail refs)
Rules:
- Costs must be recorded to cost ledger (Section 11.8)
- Evidence must include url/title/price/currency/timestamp when available
- Retail refs must be labeled as retail_offer and MUST NOT be treated as resale comps
- SOLD comps window: The engine MUST query SOLD/Completed comps over a 365-day lookback by default (window_days=365).
- SOLD eligibility: Only results that are explicitly SOLD (sold=true or equivalent) MUST be treated as SOLD comps.
  - Completed-but-not-sold results MUST be excluded with rule_id EXC_NOT_SOLD.
- Freshness metrics MUST be computed and recorded (but MUST NOT weight or modify computed pricing values):
  - comps_window_days (integer; MUST be 365)
  - comps_count_total (integer)
  - comps_count_included (integer)
  - pct_included_within_180_days (number 0-100)
  - oldest_included_comp_age_days (integer)
- Age of comps MUST only affect: warnings/notes/reliability gating; it MUST NOT adjust any price outputs.

#### 11.4.8 harvest_normalize
Purpose:
- Normalize evidence into consistent internal representation
Outputs:
- normalized sold_comp objects, listing objects, retail_offer objects
Rules:
- Preserve raw payload pointers
- Deterministic normalization only

#### 11.4.9 comp_filter_score
Purpose:
- Weed out bad comps deterministically and produce inclusion/exclusion log
Outputs:
- comp table with included/excluded flags
- exclusion_log entries with rule_id + reason

##### 11.4.9.x Condition Segmentation (Hard Lock)

Principle:
- Pricing math MUST only consume SOLD comps only from the SAME condition segment as the item.
- Cross-condition pricing is forbidden.
- This prevents PARTS/BROKEN/AS-IS comps from contaminating working-item valuation.

Authoritative condition segments (each comp must map to exactly one):
- new
- open_box
- used_working
- used_fair
- parts_not_working

Classification inputs (deterministic):
- marketplace condition field (when present)
- title keywords
- description keywords
- category flags
- supporting signals (never sole): price anomalies, return/for-repair cues

Hard exclusions (non-negotiable):
- If item.condition_segment != parts_not_working:
  - Exclude any comp classified as parts_not_working.
  - Rule ID: EXC_CONDITION_PARTS_MISMATCH
- If item.condition_segment == parts_not_working:
  - Exclude any comp classified as not parts_not_working.
  - Rule ID: EXC_CONDITION_WORKING_MISMATCH

Exclusion log requirements (mandatory for every excluded comp due to segmentation):
- evidence_id
- rule_id
- excluded_reason
- item_condition_segment
- comp_condition_segment

No overrides. No silent blending. No “close enough”.
If segmentation leaves insufficient comps, engine must block-but-preserve and mark needs_review.

##### 11.4.9.y Retail Sanity Guard (Retail-as-Guide Only)
Purpose:
- Retail references MUST be used as a sanity guard to detect absurd mismatches and reduce noisy comps.
- Retail references MUST NOT be treated as SOLD comps evidence.

Rules (hard):
- Retail sanity checks MUST NOT modify market_low/market_median/market_high outputs.
- Retail sanity checks MUST only affect comp exclusion (absurd-only) and warnings/notes.
- Default action is WARN, not EXCLUDE.

Prerequisites:
- Identity must be strong enough (identity_resolve not ambiguous) before retail sanity can exclude.
- Retail references must exist (retail_low/median/high computed).

Sanity thresholds (DBS-locked):
- WARN if sold_comp_price > retail_high * 1.50
  - Rule ID: WARN_RETAIL_SANITY_OVER_150PCT
- EXCLUDE only if sold_comp_price > retail_high * 3.00 AND identity_match_score is above minimum threshold
  - Rule ID: EXC_RETAIL_SANITY_ABSURD_OVER_300PCT

Exclusion log requirements:
- evidence_id
- rule_id
- excluded_reason
- retail_high
- comp_price
- identity_match_score

Notes:
- This is designed to catch wrong-item comps, scammy outliers, and obvious mismatches.
- Discontinued/collectible edge cases are handled by requiring strong identity + absurd threshold.

Hard exclusions (must exclude):
- parts/not working/broken/repair/as-is/untested (condition or keywords)
- lots/multipacks when item is single-unit
- accessories-only mismatch
- category mismatch beyond allowed thresholds
- identity mismatch below minimum score
Scored penalties (allowed, never silent):
- No weighting is used in v100. Penalties MUST only affect include/exclude and warnings/notes.
Rules:
- Every excluded comp MUST have:
  - rule_id
  - excluded_reason
  - evidence_id linkage
- No excluded comp MUST enter pricing_math

#### 11.4.10 pricing_math (pure market math)
Inputs:
- included sold comps only (sold_comp set P)
Outputs:
- market_low
- market_median
- market_high
- market_range = [low, high]
Rules:
- SOLD comps only (no actives, no retail) for computed pricing
- Retail reference stats (truth about retail offers; NOT resale):
  - If retail_offer evidence exists, compute retail_low/retail_median/retail_high and retail_range.
  - Label retail stats as: RETAIL_REFERENCE_NOT_RESALE.
  - Retail offer stats definition (DBS-locked v100):
    - included_retail_offers: de-duplicated, currency-normalized retail offers after validity filters.
    - retail_median = median(included_retail_offers)
    - retail_low = Q1 (25th percentile) of included_retail_offers
    - retail_high = Q3 (75th percentile) of included_retail_offers
    - IQR trimming (retail offers): engine MUST exclude offers outside [Q1 - 1.5*IQR, Q3 + 1.5*IQR] before computing final Q1/median/Q3.
    - NOTE: retail_low/high are NOT min/max.

- Deterministic eBay-style resale estimator (NOT sold comps):
  - Purpose: provide a best-effort resale estimate when SOLD comps are thin or missing, anchored to retail_median.
  - Prereqs:
    - retail_median exists
    - category is known (use taxonomy leaf → category family mapping; if unknown use misc)
    - condition_segment is known (Section 11.4.9.x)
  - Constants (DBS-locked v100):
    - CRR (Category Resale Ratio): electronics=0.45, tools=0.55, appliances=0.50, furniture=0.35, clothing=0.25, collectibles=0.70, media_games=0.60, misc=0.50
    - CF (Condition Factor): new=0.95, open_box=0.85, used_working=0.70, used_fair=0.55, parts_not_working=0.25
  - Compute estimator band:
    - est_ebay_mid  = retail_median * CRR(category) * CF(condition_segment)
    - est_ebay_low  = retail_low    * CRR(category) * CF(condition_segment) * 0.90
    - est_ebay_high = retail_high   * CRR(category) * CF(condition_segment) * 1.05
  - Label estimator outputs as: ESTIMATED_EBAY_FROM_RETAIL_NOT_SOLD.

- Suggested price policy (never invent):
  - If included_sold_comps >= 3:
    - market_low/market_median/market_high computed from SOLD comps only.
    - suggested_price_basis = SOLD_MARKET_MEDIAN
    - suggested_list_price derived ONLY from SOLD band per strategy.
    - Estimator MUST be computed for display, but MUST NOT influence suggested_list_price when comps >= 3.
  - If included_sold_comps in {1,2}:
    - Compute thin SOLD band from SOLD comps only; MUST set needs_review=true.
    - If an estimator/reference band exists, record it as RETAIL_REFERENCE only (labelled); DO NOT blend it into any SOLD-derived values.
      - 2 comps: w_sold=0.85, w_est=0.15
      - 1 comp: w_sold=0.70, w_est=0.30
      - suggested_band_low  = w_sold*thin_sold_low  + w_est*est_ebay_low
      - suggested_band_mid  = w_sold*thin_sold_mid  + w_est*est_ebay_mid
      - suggested_band_high = w_sold*thin_sold_high + w_est*est_ebay_high
      - suggested_price_basis = THINCOMPS_SOLD_ONLY
      - MUST include warning token: thin_comps_used_estimator_anchor
      - SOLD market_* outputs remain SOLD-only and unchanged.
    - If estimator band missing: suggested_price_basis = THIN_SOLD_ONLY (thin sold band only).
  - If included_sold_comps == 0 AND estimator exists:
    - suggested_price_basis = ESTIMATED_EBAY_FROM_RETAIL_NOT_SOLD
    - suggested_list_price derived from estimator band per strategy.
    - MUST set needs_review=true.
    - MUST include warning token: no_sold_comps_estimator_only
  - Else:
    - suggested_price_basis = NO_PRICE_BASIS
    - system MUST block-but-preserve, set needs_review=true, and record readiness_reason "no_price_basis"

- Strategy mapping (selects suggested_list_price from the ACTIVE band; does not alter SOLD market_*):
  - strategy enum: FAST_AVG | MARKET_FAIR | TOP_DOLLAR
  - FAST_AVG: choose low (or low-biased within band)
  - MARKET_FAIR: choose mid
  - TOP_DOLLAR: choose high (or high-biased within band)

- Robust stats: median, Q1, Q3, IQR trimming
- Confidence/reliability MUST NOT modify price values
- If insufficient comps after filtering => pricing stage MUST be blocked-but-preserve, emitting range only if DBS allows; otherwise mark needs_review

#### 11.4.11 listing_compose
Purpose:
- Compose eBay-style listing fields
Inputs:
- resolved identity, taxonomy aspects, pricing outputs, selected images
Outputs:
- listing_fields (title, aspects, condition, suggested price from policy layer, description bullets)
Rules:
- Recommended listing price is policy selection from market outputs (median/low/high) and NEVER alters market outputs
- Must not claim certainty; must carry warnings when needs_review or low reliability

#### 11.4.12 proof_packet
Purpose:
- Emit a compact, legally-defensible “receipt bundle” per item.
- Provide a clean default “Review Summary” payload for the initial UI view.
- Provide expanded “Show Your Work” payloads behind a drawer/side panel.
- Optionally run AI QA (read-only) ONLY when triage is Yellow or Red.

Outputs:
- proof_packet.review_summary (UI default view; MUST be present when any price basis exists)
- proof_packet.drawer (expanded evidence + math + exclusions; MUST be present when evidence exists)
- proof_packet.qa_audit (optional; only when triage != green)

##### 11.4.12.a Review Summary (UI Default View) (Hard Lock)
The initial review screen MUST be clean and must only show the fields below by default.

Required fields (exact intent; UI MUST choose layout):
1) Images
- input_thumbs[] (primary input thumbnails)
- reference_images[] (exactly 3; URLs + thumbnails only; see Section 11.4.9/11.4.7 sourcing rules)

2) Listing
- listing_title (final title string)
- listing_description_short (2–5 bullets max; if any bullet is not evidence-backed, it MUST be labeled as `UNVERIFIED`)

3) Prices (money block)
- suggested_list_price
- suggested_price_basis (enum; REQUIRED):
  - SOLD_MARKET_MEDIAN
  - THIN_SOLD_ONLY
  - THINCOMPS_SOLD_ONLY
  - ESTIMATED_EBAY_FROM_RETAIL_NOT_SOLD
  - NO_PRICE_BASIS
- resale_market_range (low/high) (sold-based when available; else null)
- retail_reference_range (low/median/high + range) (explicit label only; see below)

4) Flags / Notes
- badges[] (MAX 3 shown by default; more allowed in drawer)
- notes_short (single short sentence or two; human-readable)

5) Confidence / Triage
- overall_triage (enum): green | yellow | red
- confidence_chips (optional UI display; REQUIRED in data):
  - identity_confidence (0–100)
  - condition_confidence (0–100)
  - comps_confidence (0–100)
  - pricing_confidence (0–100)
  - listing_confidence (0–100)

Retail reference labeling requirement:
- Any retail stats MUST include label: RETAIL_REFERENCE_NOT_RESALE.
- Retail stats MUST NEVER be presented as sold comps evidence.

##### 11.4.12.b Drawer Payload (Show Your Work) (Hard Lock)
The UI MUST place these details behind a drawer/side panel. They MUST NOT clutter the default view.

Drawer tabs (recommended; data must exist even if UI is minimal):
- evidence_tab:
  - evidence_sources[] (urls, titles, timestamps, evidence_id)
  - evidence_tiers summary (Tier 1/2/3 dominance)
- comps_tab:
  - comps_table[] (included/excluded)
  - exclusion_log[] (rule_id, excluded_reason, evidence_id)
  - condition_segmentation audit fields (item segment, comp segment)
- pricing_tab:
  - pricing_math_summary (median, IQR trimming steps, included comp count)
  - thin_comps labels when applicable (THIN_COMPS_1 / THIN_COMPS_2)
  - retail_reference_stats (low/median/high) with RETAIL_REFERENCE_NOT_RESALE label
- cost_tab (MUST be hidden by default):
  - per-item cost ledger (provider calls + estimated cost + tier)
- qa_tab (only when qa_audit exists):
  - qa_flags[] (read-only contradictions/consistency warnings)

##### 11.4.12.c AI QA Consistency Check (Read-Only) (Hard Lock)
Goal:
- Catch contradictions like “brand says X but comps are clearly Y”, or “condition flags conflict with selected segment”.

Trigger:
- MUST run ONLY when overall_triage is yellow OR red.
- MUST NOT run when overall_triage is green.

Inputs:
- resolved fields (identity, condition_segment, category)
- comps_table summary (top included comps)
- pricing outputs (range, basis)
- retail reference stats (if present)
- listing fields (title/description/aspects)

Outputs:
- proof_packet.qa_audit:
  - qa_risk_level (low|med|high)
  - qa_flags[] (each with):
    - code
    - message (human-readable)
    - affected_fields[]
    - evidence_refs[] (evidence_ids or decision refs when applicable)

Hard constraints:
- QA MUST be read-only: it MUST NOT change any resolved winners, comps inclusion, or price values.
- QA MUST only add flags/notes and MUST only influence status via needs_review messaging.
- QA must not invent new facts; it can only point out inconsistencies or missing evidence.

Rules:
- All QA outputs must be stored with raw_ref pointers (like other stages).

#### 11.4.13 finalize_status_export

##### 11.4.13.a Overall Triage (Green/Yellow/Red) (Hard Lock)
The engine MUST compute and emit:
- status.overall_triage = green|yellow|red
- proof_packet.review_summary.overall_triage (must match status)

Deterministic triage rules:
RED if ANY of:
- Estimator-only WEAK (must be RED):
  - suggested_price_basis == ESTIMATED_EBAY_FROM_RETAIL_NOT_SOLD
  - AND (identity is unresolved OR identity is ambiguous OR condition_segment unknown OR category leaf unknown/misc OR included_retail_offers < 3)
- Identity unresolved OR Identity Collapse Rule triggered (Section 11.7)
- suggested_price_basis == NO_PRICE_BASIS
- Condition segment unknown OR condition segmentation cannot be applied safely
- included_sold_comps == 0 AND estimator is NOT available
  - (estimator requires retail_median + category + condition_segment)

YELLOW if ANY of:
- Estimator-only STRONG (allowed YELLOW):
  - suggested_price_basis == ESTIMATED_EBAY_FROM_RETAIL_NOT_SOLD
  - AND identity is resolved AND NOT ambiguous (no Identity Collapse Rule trigger)
  - AND condition_segment is known
  - AND taxonomy category leaf is known (not misc)
  - AND included_retail_offers >= 3
- included_sold_comps in {1,2} (thin comps) OR THIN_COMPS_1/THIN_COMPS_2 triggered
- Retail sanity guard warnings exist (11.4.9.y)
- Required taxonomy aspects missing for listing readiness
- Freshness metrics indicate weak recent coverage (note-only; never price-changing)

GREEN only if ALL of:
- Identity resolved with Tier 1/2 agreement
- included_sold_comps >= 3
- No hard warnings; only minor notes permitted

##### 11.4.13.b Confidence Chips (Hard Lock)
The engine MUST emit field-level confidence (0–100) for:
- identity_confidence
- condition_confidence
- comps_confidence
- pricing_confidence
- listing_confidence

Constraints:
- Confidence MUST affect visibility/eligibility/needs_review and QA trigger ONLY.
- Confidence MUST NOT alter computed price values.
Purpose:
- Set status flags and export fields without adding truth
Outputs:
- status.needs_review/blocked/marketplace_ready and reasons
- export.fields derived only from canonical JSON + operator decisions
Rules:
- Must enforce invariants from Section 4 and schema from Section 8
- No silent upgrade: existing items never change without explicit reprocess

---

### 11.5 Deterministic Resolver Rubric (High-Level)

Resolver scoring must be deterministic and documented.
At minimum:
- source_tier_rank
- agreement_count across independent sources
- match_strength hierarchy (UPC exact > MPN exact > model tokens > fuzzy)
- tie-breaker order (Section 11.10)

Freshness constraint:
- Freshness MUST NOT be used as a scoring signal or tie-breaker.
- Freshness MUST only generate warnings/notes/triage signals.

---

### 11.6 Comp Filtering Rule IDs (Minimum Set)

Required rule_ids (non-exhaustive; MUST be expanded only via DBS change):
- EXC_CONDITION_PARTS
- EXC_CONDITION_PARTS_MISMATCH
- EXC_CONDITION_WORKING_MISMATCH
- EXC_KEYWORD_PARTS
- EXC_LOT_MISMATCH
- EXC_CATEGORY_MISMATCH
- EXC_INCOMPLETE_ITEM
- EXC_MATCH_SCORE_LOW
- EXC_OUTLIER_IQR

Every exclusion MUST use one of these or a DBS-added rule_id.
---

### 11.7 Identity Collapse Rule (Hard)

If identity agreement falls below threshold X (defined by DBS version):
- status.needs_review=true
- status.marketplace_ready=false
- overall reliability score is capped (Section 11.9)
- “best price recommendation” MUST be suppressed or marked operator-confirm-required
- market pricing math MUST still compute if sold comps are identity-matched; otherwise blocked-but-preserve

No invented truth is permitted to bypass collapse.

---

### 11.8 Cost Controls (Hard)

**Per-item Cost Budget Ledger (Required)**
Ledger fields:
- provider_call_counts (by provider)
- estimated_cost_usd (by provider + total)
- cost_tier_reached: Low | Medium | High
- stop_reason (optional)

**Tiered Analysis (Fixed, DBS-defined)**
- Basic: preflight + minimal sold search
- Standard: full sold comps + active listings
- Max Confidence: full stack + barcode verification + retail refs

**Preflight gating**
- Operator chooses a run_mode BEFORE any paid calls (record in decisions):
  - RUN_GREEN_ONLY: run only green; skip yellow+red
  - RUN_GREEN_YELLOW: run green+yellow; skip red
  - RUN_ALL: run green+yellow+red
- Yellow and Red MUST run when run_mode permits; otherwise they are skipped (no hidden retries).
- Red MUST also be run via explicit per-item operator override even when run_mode would skip it (record in decisions).
- Query pack size is DBS-defined and is the SAME for green/yellow/red (preflight does not reduce call volume; it only drives recommendations + review severity).

### 11.9 Evidence Tiering (Authoritative)

- Tier 1: GS1, official manufacturer pages, verified UPC, barcode authority confirmations
- Tier 2: eBay structured fields, sold comps (sold_comp), active listings (listing)
- Tier 3: OCR text, retail pages, fuzzy matches

Outputs MUST disclose dominant evidence tiers and weakness signals.

---

### 11.10 Tie-Breakers (Deterministic)

If multiple candidates remain after scoring:
A) Higher source tier wins
B) More independent-source agreement wins
C) Stronger match hierarchy wins (UPC > MPN > model tokens > fuzzy)
D) If still tied: fail-closed to needs_review (no silent choice)

Note:
- Freshness MUST NOT be used as a tie-breaker. It is warnings/triage-only.

---

### 11.11 Replay Integrity Hash + No Silent Upgrade (Hard)

For each item run, compute and store a replay integrity hash over:
- ordered input manifest (sha256 list)
- ordered evidence_id list + their raw_ref hashes
- dbs_version
- pipeline_id + pipeline_order

Rule:
- Old items do not change silently.
- Reprocessing requires explicit operator action, a new run, and DBS version recorded.

---

---

---

### 11.X Expansion Projects (Non-Binding Backlog)

These are explicitly NOT part of this DBS version’s allowed provider set.
They MUST only be added via DBS change + version bump + gate updates.

**Expansion Provider: PriceCharting (price guide / category-specific reference)**
- Intended scope: video games, trading cards, coins, comics, and other supported collectible domains.
- Allowed role: reference guide only (similar to retail reference); never treated as SOLD comps evidence.
- Output impact (future DBS only): MUST add guide_low/guide_median/guide_high with explicit labeling.

**Expansion Provider: WorthPoint (collectibles historical reference)**
- Intended scope: antiques/collectibles where SOLD comps are thin.
- Allowed role: reference only; never treated as SOLD comps evidence unless a future DBS explicitly defines mapping and evidence requirements.

## 12. UI & Pixel Blueprint

### 12.1 UI Authority Boundary (Hard)

- UI MUST **present, group, sort, filter, and annotate**.
- UI MUST NOT compute pricing, invent evidence, mutate truth fields, or bypass paid-provider blocks.
- UI edits that change truth MUST be represented as `operator_actions` (Section 8.4.5), including lifecycle transitions.

### 12.2 Canonical Screens (v1)

The UI MUST support these canonical surfaces (routes/names MUST vary; behavior must not):

1) **Upload / Intake**
   - Accept assets (images/PDF/ZIP/CSV/XLSX per your existing canon).
   - Run preflight viability scoring (R/Y/G + reasons) without running paid providers.
   - Allow moving RED/YELLOW to Review triage without running the full pipeline.

2) **Review**
   - Shows proof packet Review Summary + Drawer evidence view (Section 11).
   - AI QA is read-only and only for Yellow/Red (Section 11).
   - Operator can: mark reviewed, select evidence, mark approved, mark blocked, and lifecycle transitions.

3) **Inventory**
   - Browse priced/approved items.
   - Bulk selection bar, search filter, kebab actions (client-side interactions only; truth changes via actions).

4) **Export**
   - Generates export artifacts from existing truth (read-only projection).
   - Repeat export allowed; must be idempotent.

### 12.3 Pixel Blueprint Status (Allowed Now)

UI blueprint work is allowed now even if `DBS_COMPLETE=0` is not yet set.
All pixel coordinates, spacing, tokens, and measurements in this section are authoritative and immutable.
Any change requires a DBS version bump.
- UI/Engine separation holds
  - truth mutation remains action-logged
  - no new forbidden behaviors are introduced

### 12.3.1 Deterministic Layout Maps (Pixel-Complete Law) (Hard)

**Purpose:** This subsection defines the single forcing representation that makes “pixel blueprint” unambiguous and compiler-safe under a non-guessing implementation.

**Definition of Pixel-Complete (Hard):**
A UI screen is “pixel-complete” iff, for every canonical breakpoint defined below, the DBS specifies a deterministic set of rectangles (x, y, w, h) for all canonical regions and components on that screen, plus deterministic z-order and overflow/scroll rules, such that no layout judgment is required.

#### 12.3.1.1 Canonical Breakpoints (Hard)

The pixel blueprint MUST be defined for these breakpoint IDs, with exact viewport widths:

- `bp_mobile`  = `390px` wide
- `bp_tablet`  = `834px` wide
- `bp_laptop`  = `1280px` wide
- `bp_desktop` = `1440px` wide

**Height rule (Hard):**
- Viewport height is **not** a layout determinant.
- Default rule: `page_scroll=true` for all canonical screens.
- If a Screen Canon sets `page_scroll=false`, it MUST define exactly one region rect with `scroll_y=true`.
- To define an internal scroll container, the region rect MUST set `scroll_y=true`; if no region rect has `scroll_y=true`, scrolling is owned by the page scroll owner.

#### 12.3.1.2 Coordinate System & Units (Hard)

- Units are CSS pixels (`px`) in an abstract coordinate plane.
- Origin `(0,0)` is the top-left of the viewport.
- `x` increases to the right; `y` increases downward.
- All coordinates and dimensions MUST be **integers**.
- Negative coordinates are forbidden.
- Subpixel values are forbidden.
- Rounding rule: if any computation would yield non-integer values, the spec is considered violated (no rounding allowed).

#### 12.3.1.3 Layout Map Schema (Hard)

The DBS MUST define a **Layout Map** per canonical screen, per breakpoint, using the following deterministic shape.

**LayoutMap object:**
- `screen_id` (string, required): stable identifier, e.g., `upload`, `review`, `inventory`, `export`
- `breakpoint_id` (enum, required): one of `bp_mobile|bp_tablet|bp_laptop|bp_desktop`
- `viewport_w_px` (int, required): must match the canonical breakpoint width above
- `regions` (array, required): list of region rectangles
- `components` (array, required): list of component rectangles
- `z_order` (array, required): ordered list of IDs front-to-back
- `rules` (object, required): deterministic overflow/scroll rules

**Rect object (for regions/components):**
- `id` (string, required): stable unique within screen+breakpoint
- `kind` (enum, required): `region|component`
- `x` (int, required)
- `y` (int, required)
- `w` (int, required)
- `h` (int, required)
- `parent_id` (string|null, required): null means root viewport; otherwise must reference a region ID
- `scroll_y` (bool, required): if true, this rect defines an internal vertical scroll container
- `clip` (bool, required): if true, child drawing is clipped to this rect bounds
- `hit_target` (bool, required): if true, rect is an interactive hit target (buttons/inputs)
- `notes` (string, required): clarifies intent; empty string permitted; MUST NOT introduce ambiguity

**Rules object:**
- `page_scroll` (bool, required): if true, page scroll exists
- `page_scroll_owner_id` (string, required): ID of rect that owns page scroll.
  - If `page_scroll=true`, `page_scroll_owner_id` MUST be `page_root`.
  - `page_root` MUST be a `region` rect with `parent_id=null`.
- `overflow_x_forbidden` (bool, required): must be true for all canonical screens unless explicitly exempted
- `min_gutter_px` (int, required): minimum left/right gutter; integer
- `safe_area_px` (object, required): `{top:int,right:int,bottom:int,left:int}` integers; default all 0 unless specified

#### 12.3.1.4 Determinism Invariants (Hard)

- Every canonical screen MUST have one LayoutMap per canonical breakpoint.
- IDs MUST be stable across breakpoints for the “same” logical region/component (e.g., `shell_sidebar`, `header_bar`, `upload_list`).
- All `w` and `h` MUST be `>= 1`.
- Sibling rectangles MUST NOT overlap unless explicitly permitted by a named rule in the screen canon.
- `z_order` MUST contain every region/component `id` exactly once.
- If `scroll_y=true` for a rect, that rect MUST have `clip=true`.
- Horizontal overflow MUST be forbidden:
  - `overflow_x_forbidden=true` is REQUIRED for all canonical screens in v1.
  - Any design requiring horizontal scroll is forbidden.
- The only allowed scrolling behaviors are:
  - page scroll, and/or
  - one internal vertical scroll region (e.g., a list pane) explicitly marked.

#### 12.3.1.5 Relationship to Tokens (Hard)

- Tokens define **appearance** (color/typography/radius/shadows), not placement.
- Layout Maps define **placement** (rectangles), not appearance.
- No token or component rule MUST override a rectangle’s x/y/w/h.

### 12.15 UI Tokens (LOCKED)

### 12.4 UI Token Rules (Hard)

- No inline styles in canonical UI.
- UI must use a token system (colors/spacing/typography) and consistent components.
- Any visual change that alters user interpretation of triage (Green/Yellow/Red) must be explicit and testable (e.g., labels, chips, reasons).

### 12.20 UI Tokens SHA Lock

UI_BLOCK_SHA256 = 556a6de215aea778a4c846e3536abf3408e127b9a37cda4e09d4f872cd1fe426
---
REVIEW_CANON_SHA256=01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
---
INVENTORY_CANON_SHA256=01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
---

### 12.5 Brand Assets (Master Logo Authority) (Hard)

**Single source of truth:** The master logo system is the vector spec package stored in-repo:

- `assets/brand/master_logo/OpsDesk_Complete_Vector_Spec_System_v1.zip`
- `SHA256=18c576d1d9ae8ef81f8e32183d847451318fa76bbd3067b0310937557b04edef`

**Authority rules (Hard):**
- The contents of this zip are the canonical authority for: mark, wordmark, lockups, stroke rules, and validation protocol.
- Any exported PNG/SVG/WEBP assets used by the UI are **derived artifacts** only.
- UI MUST NOT treat exported images as authoritative if they differ from the vector spec system.
- Any logo/brand change MUST be performed by updating the master zip and updating this SHA line (golden diff + lock update required).

**Allowed derived exports (Allowed):**
- `src/ui/static/brand/mark.*`
- `src/ui/static/brand/wordmark.*`
- `src/ui/static/brand/lockup.*`

(Exact filenames MUST vary, but the rule is: exports are derived; the master zip is authority.)

### 12.6 Upload / Intake Screen Canon (Hard)

**Core rule:** Each uploaded file is its **own distinct item record** at intake time.

- The Upload list MUST render **one row per file**.
- Default ordering MUST be **the original load order** (stable).
- The system MUST NOT auto-create groups, stacks, folders, collapsible sets, or “bundle rows”.

**Allowed similarity assistance (UI-only, non-mutating):**
- The UI MUST compute a “looks similar” hint based on **image likeness** (thumbnail similarity).
- This hint MUST be strictly **ornamental/assistive**:
  - it MUST NOT change underlying item identity
  - it MUST NOT reorder the base list
  - it MUST NOT collapse rows into a group container
- The hint MUST appear only as a badge (example: `Similar: SUG-003`) on each affected row.

**No other auto grouping is allowed.**  
If the UI can’t express it as a non-mutating badge, it’s forbidden.

### 12.7 Multi-image “Batching” (Simple, No Grouping) (Hard)

The Upload screen MUST support the common case: multiple photos of the same physical item.

**Rule:** batching is a **manual operator action**, never an automatic restructure.

- Every file remains its own row.
- The UI MUST show **Suggested Sets** (from likeness) as described in 12.6.
- The operator MUST accept a suggestion to create a set link using an operator action:
  - `operator_actions[].type = set_link`
  - includes: `set_id`, `member_item_ids[]`, `reason_token`, `at`
- Accepting a set link MUST NOT collapse the list; it only adds cross-links used in Review.

**Simplicity requirement:**
- One click to “Accept Suggested Set” (optional).
- One click to “Clear Suggested Set” (optional).
- No other set UI (no drag/drop, no nesting, no containers).

### 12.8 Controls + Minimal Instructions (Hard)

**Buttons must be minimal.** The Upload page MUST have:
- A primary **Manual Upload** button (file picker).
- Optional secondary: “Add more” (MUST be the same control as Manual Upload).
- Optional: “Remove selected” (only if selection exists; otherwise hidden).
- Optional: “Clear” (danger/confirm required).

No toolbars full of actions. No “button salad”.

**Instructions must be minimal and fun**, e.g. one short line near the top that points users:
- what to do (“Drop files here or click Upload”)
- what happens (“We’ll score photo viability first”)
- what to do next (“Then run pricing when ready”)

Keep it to ~1–2 short lines. Anything longer belongs in Help, not the page.

### 12.9 Sorting / Filtering (Allowed, Non-mutating) (Hard)

Sorting and filtering are allowed only under these constraints:

- Default view is the stable **load order**.
- Filters/sorts MUST NOT mutate underlying order or identity.
- Provide only common, simple toggles:
  - Filter by R/Y/G viability status
  - File type (image vs non-image)
  - “Show Suggested Similarity badges” on/off
  - Optional sort: status (R→Y→G) or name (A→Z)
- Any sort toggle MUST be clearly labeled as **view-only**.

### 12.10 Decorative System Derived from OpsDesk Logo Wiring (Ornamental Only) (Hard)

The UI “skin” MUST be derived from the OpsDesk logo system (Section 12.5).

**Ornamental-only rule:**
- Decorative wiring must never imply data connections or grouping.
- Decorations MUST NOT be interactive.
- Decorations MUST NOT encode state beyond purely aesthetic reuse of motifs.

**Canonical motifs (derived exports allowed; master zip remains authority):**
- **Wiring line**: used for thin section dividers (e.g., under headers).
- **Terminal node circle**: used as bullet markers (lists), small endpoints on dividers, or subtle corner accents.
- **Node + line micro-ornament**: MUST be used in empty states or as subtle separators.

**Usage rule (Hard):**
If there is a line under a header, it is a **wiring line** (not a generic HR).
If there are bullets, they are **terminal nodes** (not generic dots).

### 12.11 Apply Same Visual Scheme Across Review + Inventory (Hard)

The same brand-derived visual scheme from Upload MUST be applied consistently to:
- Review
- Inventory

This includes:
- background treatment
- typography scale
- divider motifs (wiring line)
- bullet motif (terminal node)
- overall “clean Shopify-grade” calm spacing

This does NOT force identical layouts; it forces the same visual language and tokens.

### 12.12 Brand Ornaments (LOCKED)

wiring_divider.svg SHA256=0ee74fed72d12c6f23dc3978c4eef4e4e08a8f9f461c6fcac1be71636ca5b1c3
terminal_bullet.svg SHA256=e61a94fff4edb4b831d90e3d0e016c0d5e9849c335426a28cc31f6aa152680d2

### 12.6A Upload Layout Grid (Hard)

The Upload screen is a single primary surface with three zones:

1) **Header strip**
- Left: OpsDesk wordmark
- Center: page title `Upload`
- Right: primary actions

2) **Drop zone**
- Large, obvious target area.
- Must include minimal/fun instruction line (Section 12.8).
- Accepts drop and click-to-upload (Manual Upload button triggers file picker).

3) **File list**
- One row per file (Section 12.6).
- Default list order is the original load order (stable).
- A compact sticky bulk bar MUST appear only when selection > 0 (see 12.6C).

### 12.6B Upload Row Anatomy (Hard)

Each file row MUST present these fields, in this order:

1) **Select control**
- Checkbox (unchecked by default).

2) **Thumbnail / file icon**
- For images: thumbnail preview.
- For non-images: icon with filetype label.

3) **Primary label**
- Filename (truncated with tooltip on hover).

4) **Secondary meta**
- Filetype (image/pdf/zip/csv/xlsx/other)
- Size (human readable)
- Optional: dimensions for images if cheaply available (non-blocking).

5) **Preflight viability chip**
- Shows one of: `PENDING`, `GREEN`, `YELLOW`, `RED`
- `PENDING` is allowed only while scoring is running.
- When `RED` or `YELLOW`, row MUST show at least one reason token (short).

6) **Similarity hint badge (optional)**
- If likeness suggests similarity to other uploads, show badge:
  - `Similar: SUG-###`
- Badge is non-interactive by default.
- Optional: clicking badge MUST filter to “show rows with this SUG id” (view-only).
- Badge MUST NOT reorder the list and MUST NOT collapse rows.

### 12.6C Selection + Bulk Actions (Hard)

Selection is optional but supported.

**Bulk bar visibility:**
- Bulk bar MUST appear only when `selected_count > 0`.
- Bulk bar MUST disappear when `selected_count == 0`.

**Bulk bar contents (minimal):**
- Left: `X selected`
- Middle: `Select all` (selects all currently visible rows in the view)
- Right: context actions (only show what is applicable)

**Context actions (Hard):**
- `Run` (primary):
  - enabled if any selected row is eligible for run (not `RED` blocked).
  - if selection includes `RED`, they are simply not run; the action must print a warning toast: `Some selected files are blocked (RED) and will not run.`

- `Send to Review` (secondary, contextual):
  - visible only if selection includes any `RED` or `YELLOW`
  - moves those selected items into Review triage WITHOUT running paid providers (Section 12.2).

No other bulk actions are allowed on Upload v1.

### 12.7A Suggested Sets UX (Hard, Non-grouping)

Suggested Sets exist only as a thin assist layer derived from likeness.

**Presentation:**
- Suggested Set appears as the `Similar: SUG-###` badge on relevant rows.
- The UI MUST additionally show a single compact banner above the list:
  - `We found similar photos. Review suggestions? [View]`
- The banner MUST NOT appear if there are no suggestions.

**View suggestions (optional modal/panel; Hard if implemented):**
- Shows each SUG id with a list of member rows (still rows, not a group).
- Provides exactly two actions per SUG id:
  1) `Accept set`
  2) `Dismiss`

**Accept set (Hard):**
- Creates operator action:
  - `operator_actions[].type = set_link`
  - `set_id = SUG-###`
  - `member_item_ids[]` = the file-row item ids
  - `reason_token = likeness_suggestion_accepted`
  - `at` timestamp
- Accepting set MUST NOT collapse the upload list or change base order.

**Dismiss (Hard):**
- Hides that suggestion from the UI for the current run/session view.
- Must not delete or mutate any evidence fields.

### 12.9A Filter/Sort UI Spec (Hard, View-only)

Filters and sorts are view-only.

**Filters (allowed):**
- Viability: All / Green / Yellow / Red / Pending
- File type: All / Images / Non-images
- Similarity badge: On/Off visibility toggle
- Optional: `Show only SUG-###` (only when a SUG badge is clicked)

**Sort (allowed, optional):**
- Default: `Load order`
- Optional: `Name (A–Z)`
- Optional: `Viability (R→Y→G→Pending)` but MUST NOT destroy load order; it is a view transform only.

The UI MUST always provide a one-click return to default `Load order`.

Each file row MUST present these fields, in this order:

1) **Select control**
- Checkbox (unchecked by default).

2) **Thumbnail / file icon**
- For images: thumbnail preview.
- For non-images: icon with filetype label.

3) **Primary label**
- Filename (truncated with tooltip on hover).

4) **Secondary meta**
- Filetype (image/pdf/zip/csv/xlsx/other)
- Size (human readable)
- Optional: dimensions for images if cheaply available (non-blocking).

5) **Preflight viability chip**
- Shows one of: `PENDING`, `GREEN`, `YELLOW`, `RED`
- `PENDING` is allowed only while scoring is running.
- When `RED` or `YELLOW`, row MUST show at least one reason token (short).

6) **Similarity hint badge (optional)**
- If likeness suggests similarity to other uploads, show badge:
  - `Similar: SUG-###`
- Badge is non-interactive by default.
- Optional: clicking badge MUST filter to “show rows with this SUG id” (view-only).
- Badge MUST NOT reorder the list and MUST NOT collapse rows.

Selection is optional but supported.

**Bulk bar visibility:**
- Bulk bar MUST appear only when `selected_count > 0`.
- Bulk bar MUST disappear when `selected_count == 0`.

**Bulk bar contents (minimal):**
- Left: `X selected`
- Middle: `Select all` (selects all currently visible rows in the view)
- Right: context actions (only show what is applicable)

**Context actions (Hard):**
- `Run` (primary):
  - enabled if any selected row is eligible for run (not `RED` blocked).
  - if selection includes `RED`, they are simply not run; the action must print a warning toast: `Some selected files are blocked (RED) and will not run.`

- `Send to Review` (secondary, contextual):
  - visible only if selection includes any `RED` or `YELLOW`
  - moves those selected items into Review triage WITHOUT running paid providers (Section 12.2).

No other bulk actions are allowed on Upload v1.

Suggested Sets exist only as a thin assist layer derived from likeness.

**Presentation:**
- Suggested Set appears as the `Similar: SUG-###` badge on relevant rows.
- The UI MUST additionally show a single compact banner above the list:
  - `We found similar photos. Review suggestions? [View]`
- The banner MUST NOT appear if there are no suggestions.

**View suggestions (optional modal/panel; Hard if implemented):**
- Shows each SUG id with a list of member rows (still rows, not a group).
- Provides exactly two actions per SUG id:
  1) `Accept set`
  2) `Dismiss`

**Accept set (Hard):**
- Creates operator action:
  - `operator_actions[].type = set_link`
  - `set_id = SUG-###`
  - `member_item_ids[]` = the file-row item ids
  - `reason_token = likeness_suggestion_accepted`
  - `at` timestamp
- Accepting set MUST NOT collapse the upload list or change base order.

**Dismiss (Hard):**
- Hides that suggestion from the UI for the current run/session view.
- Must not delete or mutate any evidence fields.

Filters and sorts are view-only.

**Filters (allowed):**
- Viability: All / Green / Yellow / Red / Pending
- File type: All / Images / Non-images
- Similarity badge: On/Off visibility toggle
- Optional: `Show only SUG-###` (only when a SUG badge is clicked)

**Sort (allowed, optional):**
- Default: `Load order`
- Optional: `Name (A–Z)`
- Optional: `Viability (R→Y→G→Pending)` but MUST NOT destroy load order; it is a view transform only.

The UI MUST always provide a one-click return to default `Load order`.

---

---

### 12.X.0 Canonical Vector Rebuild Rules (DBS-enforced)

**Purpose:** eliminate renderer drift. These rules are binding for any regenerated mark/wordmark outputs.

**Hard invariants (MUST):**
1) **Coordinate system / viewBox:** preserve the exact viewBox, origin, and aspect ratio from the spec. No “fit to artboard” rescaling.
2) **Stroke semantics:** explicitly set `stroke-linecap` and `stroke-linejoin` for every stroked path. Defaults are forbidden.
   - Canonical: `stroke-linecap="round"`, `stroke-linejoin="round"` unless the embedded spec explicitly overrides.
3) **Miter behavior:** if any joins use miter, `stroke-miterlimit` MUST be explicitly set (no implicit defaults).
4) **Fill rule:** explicitly set `fill-rule` (`nonzero` or `evenodd`) anywhere overlapping paths exist. Default inference forbidden.
5) **No fractional snapping drift:** when exporting to raster, use a deterministic scale and **pixel snapping rules** as specified by the embedded system (no editor auto-round).
6) **No hidden transforms:** prohibit group transforms that collapse differently across renderers. Prefer baked geometry.
7) **Colors are token-locked:** only DBS-defined brand tokens MUST be used (no “close enough” hex).
8) **Export set is deterministic:** approved outputs must be reproducible: SVG (source), PNG @ 1x/2x/4x, and monochrome variants if defined.
9) **Background:** transparent unless the spec explicitly defines a field/container shape.
10) **Normalization:** all regenerated SVG must be normalized (LF line endings, stable attribute order if the tool supports it).

**Authority note:** if any item above conflicts with the embedded spec text, the embedded spec wins.

### 12.X Brand: OpsDesk Complete Vector Spec System v1 (Embedded)
- Source asset: `assets/brand/master_logo/OpsDesk_Complete_Vector_Spec_System_v1.zip`
- SHA256 (zip): `18c576d1d9ae8ef81f8e32183d847451318fa76bbd3067b0310937557b04edef`
- Authority: This embedded spec is the canonical rebuild recipe for mark + wordmark.

#### 12.X.1 README

```text
OPS DESK — COMPLETE VECTOR SPEC SYSTEM (v1 LOCKED)

This package contains the full deterministic spec set required to recreate the OpsDesk logo system:
- ICON (OD + wiring) (canonical, mask-based)
- WORDMARK (OPS DESK typography)
- HORIZONTAL LOCKUP rules
- LIGHT/DARK variants
- PILL UI container variant
- VALIDATION protocol (Chromium-locked)

Start here:
- specs/components/ICON_VR1.md
- specs/components/WORDMARK_VR1.md
- specs/components/HORIZONTAL_LOCKUP_VR1.md
- specs/variants/COLOR_VARIANTS_VR1.md
- specs/variants/PILL_UI_CONTAINER_VR1.md
- validator/VALIDATION_PROTOCOL_VR1.md

For AI ingestion:
- OPS_DESK_COMPLETE_SPEC_SYSTEM.json
```

#### 12.X.2 HORIZONTAL_LOCKUP_VR1.md

# HORIZONTAL_LOCKUP_SPEC_VR1 (LOCKED)

## Dependencies
- ICON_VR1.md (icon)
- WORDMARK_VR1.md (wordmark)

## Alignment
- Vertical alignment: optical center of icon container ↔ optical center of wordmark glyphs
- Baseline alignment is NOT used (avoids renderer drift)

## Spacing Rule (Critical)
Horizontal gap between icon container right edge and the left edge of the “O” in OPS:
GAP = width of the “O” glyph in OPS (measured in the canonical font at the render size)

## Bounding Box
- Tight to icon + wordmark
- Transparent background

#### 12.X.3 ICON_VR1.md

# VECTOR_REBUILD_SPEC_ICON_VR1 (LOCKED)

## Scope
Icon mark only: OD container + negative-space OD cutout + wiring paths + nodes.

## Coordinate System
- Units: CSS pixels
- Origin: top-left
- Artboard: 512×512
- ViewBox: 0 0 512 512
- No transforms allowed

## Rendering Locks (CRITICAL)
Set explicitly on all stroked paths:
- stroke-linecap: round
- stroke-linejoin: round
- stroke-miterlimit: 2
- shape-rendering: geometricPrecision

## Colors (Canonical)
- CONTAINER: #1F2933
- WHITE:     #FFFFFF
- SIG_TEAL:  #3BC6C1
- SIG_GREEN: #7ACB7A
- SIG_BLUE:  #4A8FE7

## Container Geometry
- Rounded rect: x=32, y=96, w=448, h=320, rx=76, ry=76
- Fill: CONTAINER

## OD Cutout (MANDATORY MASK SUBTRACTION)
Method: SVG <mask> ONLY (white=keep, black=subtract). No evenodd tricks. No boolean ops.

### O ring cutout
- Outer circle: center=(188,256), r=92, mask fill=black
- Inner circle: center=(188,256), r=52, mask fill=white

### D cutout
Outer D path (mask fill=black):
M260 164 H328 C390 164 432 206 432 256 C432 306 390 348 328 348 H260 Z

Inner counter (mask fill=white):
M300 206 H330 C362 206 388 229 388 256 C388 283 362 306 330 306 H300 Z

## Wiring
- Stroke width: 14
- Only 90° turns, no curves

### Path A (SIG_TEAL)
Points: (88,232) → (144,232) → (144,248) → (212,248)

### Path B (SIG_GREEN)
Points: (92,300) → (144,300) → (144,280) → (210,280)

## Nodes (Ring nodes)
- Radius: 14
- Fill: CONTAINER
- Stroke width: 14
- Stroke color: matches path color

Node positions:
- (88,232) SIG_TEAL
- (212,248) SIG_TEAL
- (92,300) SIG_GREEN
- (210,280) SIG_GREEN

## Draw Order
1) Define mask  2) Draw masked container  3) Draw wiring paths  4) Draw nodes

## Forbidden
Curves/diagonals, gradients, filters, transforms, evenodd, editor boolean ops.

#### 12.X.4 WORDMARK_VR1.md

# WORDMARK_SPEC_VR1 (LOCKED)

## Text
OPS DESK (ALL CAPS)

## Canonical Font
Inter SemiBold (600)

Fallbacks (non-canonical; must flag):
- IBM Plex Sans SemiBold
- Manrope SemiBold

## Typography Locks
- Tracking: +4%
- Kerning: METRIC only (no optical overrides)
- Line height: 1.0
- No ligatures, no stylistic alternates
- No subpixel positioning

## Colors
- Light background wordmark: #1F2933
- Dark background wordmark:  #FFFFFF

#### 12.X.5 COLOR_VARIANTS_VR1.md

# COLOR_VARIANTS_VR1 (LOCKED)

## Light Variant
- Background: light/neutral
- Icon container: #1F2933
- Wordmark: #1F2933
- Wiring colors: unchanged

## Dark Variant
- Background: dark/charcoal
- Icon container: #1F2933 (never invert)
- Wordmark: #FFFFFF
- Wiring colors: unchanged

## Rule
Never recolor wiring for dark mode.

#### 12.X.6 PILL_UI_CONTAINER_VR1.md

# PILL_UI_CONTAINER_SPEC_VR1 (LOCKED)

## Dependencies
- ICON_VR1.md
- WORDMARK_VR1.md
- HORIZONTAL_LOCKUP_VR1.md

## Pill Geometry
- Shape: rounded rectangle pill
- Corner radius: 999px (fully pill)
- Height: icon container height × 1.6
- Width: content-driven (icon + wordmark + padding)

## Padding (scaled)
- Horizontal padding = icon container corner radius (76px at 1.0 scale)
- Vertical padding   = icon container corner radius ÷ 1.25 (≈60.8px at 1.0 scale)

## Background Styles (Allowed)

### Solid Dark
- Fill: #0F1720

### Glass (Preferred)
- Fill: rgba(15,23,32,0.72)
- Backdrop blur: 18px
- Border: 1px rgba(255,255,255,0.08)
- Shadow: 0 20px 40px rgba(0,0,0,0.45)

## Content Placement
- Icon left, wordmark right
- Use the GAP rule from HORIZONTAL_LOCKUP_VR1.md
- Vertically centered inside pill

#### 12.X.7 VALIDATION_PROTOCOL_VR1.md

# VALIDATION_PROTOCOL_VR1 (LOCKED)

## Why
“Pixel-perfect” requires a locked renderer. Otherwise you will chase anti-aliasing differences forever.

## Renderer Lock
- Renderer: Chromium (Playwright/headless Chrome)
- Output size: 512×512 for icon tests
- Background: transparent
- Comparison: pixel diff vs reference PNG

## Pass/Fail
- PASS if diff == 0 pixels (tolerance 0)
- AA edges are forbidden. If edge tolerance is required, it MUST be explicitly defined in this DBS as a numeric tolerance value and applied uniformly.

## Ground Truth
/reference/opsdesk_logo_reference.png

## 13. Canonical Example Packs

### 13.1 Principle (Hard)

Canonical Example Packs are small, deterministic datasets used to:
- validate DBS behavior (Section 9 tests)
- validate gates (Section 14)
- validate “golden diff” expectations (Section 15)

They are NOT marketing demos; they are audit fixtures.

### 13.2 Required Example Packs (v1)

Pack A — **Green / No Review Required**
- Contains: 1 item that MUST land `READY_GREEN`
- Must demonstrate:
  - sufficient vision signals PASS
  - query pack invariant applied
  - SOLD comps >= minimum
  - `needs_review=false`

Pack B — **Yellow / Needs Review**
- Contains: 1 item that lands `PRICED_PENDING_REVIEW`
- Must demonstrate:
  - thin comps handling OR conflicting evidence
  - proof packet populated
  - AI QA read-only notes allowed (no mutation)

Pack C — **Red / Blocked**
- Contains: 1 item that ends `PREFLIGHT_BLOCKED` OR `VISION_INSUFFICIENT`
- Must demonstrate:
  - paid providers are blocked
  - block-but-preserve semantics
  - reason tokens recorded

Pack D — **Lifecycle Transitions**
- Contains: 1 item that transitions states via operator action
- Must demonstrate:
  - `operator_actions[].type=lifecycle_transition`
  - `at` timestamp present
  - from_state/to_state/reason_token recorded
  - transitions append-only (no rewrite)

### 13.3 Canonical File Layout (Non-binding until implemented)

When implemented, packs MUST live under:
- `dbs/example_packs/pack_<name>/...`
with a short README describing the expected outcomes and referenced test IDs.

(Exact repo paths are implementation details and must be validated by gates once created.)

---

## 14. Verification & Enforcement

### 14.1 Principle (Hard)

Verification is performed by repo gates (scripts). The DBS defines:
- which gates exist (names)
- what each gate enforces (contracts)
- what each gate MUST print (must-print tokens)

The DBS MUST NOT embed executable gate logic.

### 14.2 Gate Output Contract (Hard)

Every gate MUST print **exactly one** of:
- `GATE_<NAME>_PASS=1`
- `GATE_<NAME>_FAIL=1`

If a gate fails, it MUST also print:
- `FAIL_REASON=<short_token_or_sentence>`

The gate runner MUST print:
- `ALL_GATES_PASS=1` when all pass, else `ALL_GATES_PASS=0`.

### 14.3 Canonical Gate Set (Hard)

The repo MUST define these gates (names are authoritative):

1) `GATE_DBS_LOCK`
   - Enforces: `locks/DBS_LOCK.sha256` matches current `dbs/MASTER_DBS.md`.
   - Failure when: hash mismatch.

2) `GATE_DBS_STRUCTURE`
   - Enforces: canonical sections `## 1..18` exist.
   - Any occurrence of sentinel tokens in Sections 1–18 MUST cause immediate gate failure.
   - Failure when: any sentinel token exists in numbered sections.

4) `GATE_BEHAVIOR_TEST_IDS`
   - Enforces: all `P-###` and `N-###` IDs are unique.
   - Enforces: Positive tests count >= 10 and Negative tests count >= 10.
   - Failure when: duplicates exist or minimum counts not satisfied.

5) `GATE_SCHEMA_ALIGN_SECTION10`
   - Enforces: Section 10 required fields are reflected in schema section (8.4):
     - `status.lifecycle_state` enum exists
     - decisions can record lifecycle transitions (Option A: action timestamp uses `at`)
   - Failure when: schema omissions or mismatch with Section 10.

6) `GATE_PAID_PROVIDER_BLOCK_ON_VISION_FAIL`
   - Enforces: P-012 and N-011.
   - Failure when: any paid provider is called while `vision_signals.sufficiency.verdict = FAIL`.

7) `GATE_QUERY_PACK_INVARIANT`
   - Enforces: P-013 and N-012.
   - Failure when: query pack (count/order/structure/providers) differs based on triage.

8) `GATE_SOLD_ONLY_PRICING`
   - Enforces: P-014 and N-013.
   - Failure when: retail or other signals alter SOLD-derived pricing, or SOLD window is not 365 days.

9) `GATE_AI_QA_READONLY`
   - Enforces: P-015 and N-014.
   - Failure when: AI QA mutates identity, comps, inclusion/exclusion, or pricing values (notes/flags only allowed).

### 14.4 Gate-to-DBS Traceability Map (Hard)

Each gate MUST cite the DBS section(s) and test IDs it enforces:

- `GATE_DBS_LOCK` -> Section 18 lock rules + repo lock files
- `GATE_DBS_STRUCTURE` -> Sections 1–18 structure
- `GATE_DBS_NO_PLACEHOLDERS` -> Section 16 completeness rule + Section 17 missing-spec rule
- `GATE_BEHAVIOR_TEST_IDS` -> Section 9 (P-### / N-###)
- `GATE_SCHEMA_ALIGN_SECTION10` -> Sections 8.4 + 10 + Decisions Option A
- `GATE_PAID_PROVIDER_BLOCK_ON_VISION_FAIL` -> P-016, N-015 + Section 11 cost-control invariants
- `GATE_QUERY_PACK_INVARIANT` -> P-017, N-016 + Section 11 query pack invariants
- `GATE_SOLD_ONLY_PRICING` -> P-018, N-017 + Section 11 sold-only pricing rules
- `GATE_AI_QA_READONLY` -> P-019, N-018 + Section 11 AI QA read-only rule

---

## 15. Golden Artifact Diff Rules

### 15.1 Principle (Hard)

Golden artifacts are the **audit trail** of what the system is. Any breaking change MUST be deliberate, reviewed, and recorded.  
This section defines:
- which files are considered “golden”
- what constitutes a breaking diff vs acceptable diff
- how diffs are reviewed and locked

### 15.2 Golden Artifacts (Hard)

The following are golden and MUST be tracked by diff review:

1) **DBS + Locks**
   - `dbs/MASTER_DBS.md`
   - `locks/DBS_LOCK.sha256`
   - `dbs/_PRINTS/MASTER_DBS_print_*.md`

2) **Gate runner + gate set (names + required outputs)**
   - `tools/gates/RUN_ALL_GATES.ps1`
   - any `tools/gates/GATE_*.ps1` scripts that enforce DBS contracts

3) **Engine truth outputs (shape-level golden)**
   - Canonical results JSON schema/shape (top-level keys + required subkeys as declared in DBS Section 8.4)
   - Canonical pricing fields and invariants (Section 11)
   - NOTE: We do **not** freeze incidental ordering/whitespace; we freeze **meaningful** content and required keys.

4) **Export artifacts (shape-level golden)**
   - XLSX column set + required column semantics (no silent column drift)
   - Export is read-only projection from results truth

### 15.3 Breaking Diff (Must Fail Without Explicit Approval)

A diff is **breaking** if it changes any of the following:

- DBS contract meaning:
  - Any change to Sections marked (LOCKED) OR any change that alters a “Hard” rule
  - Any change to pipeline stage order, provider locks, or paid-provider blocking semantics
  - Any change that allows behavior previously forbidden (Section 5/17)

- Schema sprawl:
  - Adding/removing top-level JSON keys or required subkeys without a DBS version bump + gates update
  - Renaming required fields (e.g., changing `status.lifecycle_state` names)

- Pricing truth rules:
  - Any change that makes pricing depend on retail or non-sold signals
  - Any change to SOLD window rule (must remain 365-day window unless DBS explicitly revised)

- Gate output contract:
  - Any gate stops printing required tokens (Section 14)
  - Gate runner no longer prints ALL_GATES_PASS=*

- Export surface:
  - Column set changes without explicit DBS approval
  - Column semantics change (e.g., `clean_title` changes meaning)

Breaking diffs MUST:
- be accompanied by a DBS Change Control entry (Section 18)
- update locks and prints
- update/introduce a gate that enforces the new rule

### 15.4 Acceptable Diff (Allowed)

These diffs are acceptable **without** DBS version bump **if** they do not change meaning:

- Formatting-only changes (whitespace, wrapping, punctuation) that do not alter semantics
- Adding clarifying examples that do not introduce new rules
- Reordering non-authoritative lists where order is explicitly stated as non-semantic

### 15.5 Review Rule (Hard)

All golden diffs MUST be reviewed in terms of:
- which DBS sections they touch
- which gate(s) enforce the claim
- whether the diff creates/relaxes any obligation

No “quiet” golden changes are allowed.

---

## 16. Completeness Assertions

### 16.X DBS v1 “Complete” Criteria (Hard)

DBS v1 is considered **COMPLETE** only when ALL of the following are true:

1) **All canonical sections exist** (1–18) and each section contains non-sentinel content.
2) **Section 11 is internally consistent** and contains:
   - pipeline identity + stage order (authoritative)
   - provider allowlist (hard-locked)
   - vision sufficiency gate (hard lock) with paid-provider blocking semantics
   - query pack invariants (same pack for Green/Yellow/Red)
   - sold-only pricing rules (365-day window; no blending/weighting/decay; retail labeled reference only)
   - proof packet requirements for Yellow/Red + AI QA read-only rule
3) **Schemas are declared** (Section 8.4) with:
   - top-level keys enumerated
   - required vs optional fields explicitly listed
   - “no schema sprawl” rule enforceable by behavior catalog
4) **Behavior Catalog is complete** (Section 9):
   - at least 10 Positive tests and 10 Negative tests
   - includes tests for: sufficiency paid-block, query-pack invariants, sold-only pricing, proof packet requirements
5) **State & Time is defined** (Section 10):
   - state machine(s) for item lifecycle, including block-but-preserve
6) **Verification is defined** (Section 14):
   - what gates exist (names only) and what they enforce
   - no executable gate logic embedded inside DBS text
7) **Golden diff rules are defined** (Section 15):
   - what files are considered golden outputs
   - what constitutes a breaking diff vs acceptable diff
8) **Missing Spec Rule is enforceable** (Section 17):
   - ambiguous behavior is treated as “spec incomplete”
9) **Change control is defined** (Section 18):
   - versioning scheme
   - lock regeneration rules
   - “no implementation until DBS_COMPLETE=0” rule

When DBS v1 becomes complete, the repo MUST record:

- `DBS_COMPLETE=0` (as a line inside Section 16)
- A fresh SHA-256 lock update in `locks/DBS_LOCK.sha256`
- A canonical print archived in `dbs/_PRINTS/`

Until `DBS_COMPLETE=0` exists, **no DBP generation, engine code, UI code, providers, or adapters are permitted.**

### 16.Y Interim Work Rule (Hard)

- You MUST work on UI blueprint/spec now.
- UI code MUST be drafted, but must NOT be treated as canonical or “done” until `DBS_COMPLETE=0` exists.
- Engine/provider behavior changes remain forbidden until DBS completion rules are satisfied.

This clause exists to avoid blocking design while preserving deterministic governance.
---

## 17. Missing Spec Rule

### 17.1 Principle (Hard)

**Missing spec means forbidden behavior.**  
If a behavior is not explicitly specified in DBS Sections 1–18, the implementation MUST NOT invent it.

### 17.2 Ambiguity Handling (Hard)

When the system encounters ambiguity, it MUST choose one of these outcomes:

1) **Fail closed (preferred)**  
   - Mark `needs_review=true` and stop advancing paid providers if applicable.
   - Preserve evidence and record the reason in decisions/notes.

2) **Raise a Missing Spec event (required for persistent ambiguity)**  
   - Create a spec issue (or DBS patch) describing:
     - the ambiguous scenario
     - the possible interpretations
     - the required deterministic rule to resolve it
   - Until patched into DBS, behavior remains forbidden.

3) **Operator action (allowed only if DBS declares operator discretion)**  
   - If a degree of freedom exists (Section 6), the operator MUST choose a path.
   - That choice MUST be recorded as an operator action/decision.

### 17.3 “No Best Effort” Rule (Hard)

The system MUST NOT:
- “best guess” identity when evidence is weak
- fabricate comps
- smooth/blend/decay values to produce a number
- silently change outputs to “make it look right”

### 17.4 Enforcement (Hard)

A repo gate MUST fail if:
- new behavior appears without DBS text authorizing it
- schema keys drift beyond what DBS declares (no schema sprawl)
- paid providers run in blocked states or under FAIL sufficiency

This section is enforceable via:
- Section 14 gates (names/contracts)
- Section 15 golden diff rules

---

## 18. Change Control & Versioning

### 18.1 Versioning Scheme (Hard)

DBS uses semantic versions: `DBS_VERSION = MAJOR.MINOR.PATCH`

- **MAJOR**: breaking meaning changes (Section 11 pipeline, provider locks, pricing truth rules, schema required keys)
- **MINOR**: additive rules or new tests/gates that do not break existing meaning
- **PATCH**: clarifications/formatting that do not change meaning

`DBS_VERSION` MUST be recorded as a single line in Section 18 (see 18.4).

### 18.2 Change Classes (Hard)

Any change MUST be classified as one of:

- **Class A (Breaking / MAJOR):**
  - changes pipeline order
  - changes sold pricing truth rules
  - changes paid-provider block semantics
  - schema required keys change
  - changes “Hard” invariants

- **Class B (Additive / MINOR):**
  - adds new tests or clarifies enforcement
  - adds non-breaking optional structure explicitly allowed by DBS

- **Class C (Clarifying / PATCH):**
  - formatting, wording, examples, without changing meaning

### 18.3 Required Process (Hard)

For ANY DBS change:

1) Create a timestamped backup (repo patch scripts do this).
2) Apply change via deterministic patch (no manual edits in canonical flow).
3) Regenerate lock:
   - update `locks/DBS_LOCK.sha256` with SHA-256 of `dbs/MASTER_DBS.md`
4) Verify lock:
   - run `tools/VERIFY_DBS_LOCK.ps1` and require `DBS_LOCK_OK=1`
5) Archive a print:
   - write `dbs/_PRINTS/MASTER_DBS_print_YYYYMMDD_HHMMSS.md`

### 18.4 Canonical Metadata Lines (Hard)

Section 18 MUST contain:

- `DBS_VERSION=0.1.0` (initial; version bumps MUST follow Change Control & Versioning in Section 18)
- `DBS_LAST_LOCK_SHA=<sha256>` (informational; the lock file is authoritative)
- `DBS_CHANGELOG=` (human-readable bullets allowed)

### 18.5 No Implementation Before Complete (Hard)

Until Section 16 contains `DBS_COMPLETE=0`:
- No DBP generation
- No new engine behaviors
- No provider/adapters changes
- No UI implementation changes treated as canonical

Work MUST be drafted, but must be treated as non-authoritative until DBS_COMPLETE=0 exists.

### 18.6 Governance Rule (Hard)

Any “major change” must be explicitly approved (your global rule), and MUST include:
- what will change
- why it changes
- what gate(s) prevent regression

---

## Lock Status
STRUCTURE LOCKED — Content pending section-by-section lock.
---

## Appendix A — Expansion Backlog (Non-Binding)

This appendix is a parking lot for future ideas.
It is NON-BINDING and has zero authority over Sections 1–18.
Nothing here is implemented or allowed unless promoted into the numbered DBS sections and versioned.

### A.1 Candidate Future Capabilities
- Parts-only valuation mode (separate outputs; never mixes with working pricing)
- Salvage value estimates (explicitly labeled, separate from resale comps)
- Additional marketplaces for SOLD comps (only if response-shape contracts are locked)
- Multi-lot decomposition (detect + split lots into sub-items)
- Advanced condition grading (scratch/dent scale) with strict evidence rules
- Bulk repricing workflows with replay-only enforcement
- Enterprise “Justification Report” templates per vertical/category
- Operator-specific pricing policies (fast-sale / max-margin profiles), explicitly versioned
- Enhanced identity parsing (UPC/MPN serial plate rules per category), deterministic only

### A.2 Promotion Rule
Any item in Appendix A must be promoted by:
- DBS edit into the relevant numbered section(s)
- DBS version bump
- Gate updates
- Canonical example pack updates where applicable
