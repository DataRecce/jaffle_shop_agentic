# Recce PR Analysis Response Format

When analyzing a dbt Pull Request, structure your response with the following sections. Use "PR Validation Summary" as the main title in your actual response.

---

## ⚠ Anomalies Detected

Use emoji indicators for severity:

- 🔴 Critical issues (e.g., Large value shift: `model.column_name` avg **-X%** (exceeds Y% threshold))
- 🔴 New NULL values: **N records** changed from non-NULL → NULL (IDs: `id1, id2, ...`) — **X%**
- ⚠ Warnings (e.g., High-magnitude changes: specific description **-X% ~ -Y%**)
- ✅ Stable metrics (e.g., Row counts stable: All models maintained record counts)

If no critical issues, state: "✅ No critical anomalies detected"

---

## Changes Overview

- Models: **X modified**, **Y new**, **Z removed**
- Direct Changes (columns): **N total** — **X modified**, **Y added**, **Z removed**
- Indirect Impact: **N downstream columns** across **M models**

### Modified Columns

- `model.column_name` → description of change
- `model.column_name` → description of change

### Downstream Impact

- `model.column_name` → dependency explanation
- `model.column_name` → dependency explanation

### Affected Models

- Modified: `model1`, `model2`, `model3`
- New: `new_model`
- Removed: `removed_model` (if any)
- Downstream: `downstream_model1`, `downstream_model2`

---

## ✅ Test Status

- ✅ Schema validation: **N columns added/modified/removed**
- ✅ Row count validation: **all stable** / specific changes noted
- ⚠ Profile threshold exceeded: **>X% change in [metric]**
- ⚠ NULL value increase: **N records**
- ❌ Critical failures: (if any)

---

## 📊 Validation Results

### Profile Diff

Use table format to show key metrics (if available from `mcp__recce__profile_diff`):

| Metric                  | Current | Change | Threshold | Status     |
| ----------------------- | ------- | ------ | --------- | ---------- |
| model.column_name (avg) | value   | ±X%    | Y%        | ✅/⚠ Status |
| model.column_name (sum) | value   | ±X%    | Y%        | ✅/⚠ Status |

> **Note**: Fill values from Recce Profile Diff results. Use list format if complete data is unavailable.

### Top-K Affected Records (Optional)

If significant record-level changes detected, show top affected records:

| Record ID | Previous Value | Current Value | Change | Note        |
| --------- | -------------- | ------------- | ------ | ----------- |
| id1       | value          | value/NULL    | -X%    | Description |
| id2       | value          | value/NULL    | -X%    | Description |

> **Note**: Fill with actual Diff results. Only provide this table when significant anomalies are detected.

### Row Count Diff

Use `mcp__recce__row_count_diff` results:

- `model_name`: current_count (change: ±X rows, ±Y%)
- `model_name`: current_count (✅ stable)

---

## 🔍 Review Required

- Investigate drivers of [specific metric] **±X%**; confirm the [change description] is intentional.
- Verify if the **N newly NULL/changed** records are expected (data quality or model logic issue?).
- Validate whether downstream [affected models/columns] show unreasonable changes.
- Confirm business logic changes align with requirements.

## ✅ Suggested Checks

Provide actionable check references (format: `Check type: targets`):

- Row count diff: `model1`, `model2`
- Distribution shift: `model.column_name`
- NULL emergence: `model.column_name`
- Downstream validation: `downstream_model.column_name`
- Query validation: [specific business logic or metric]

## 🧭 Decision Guide

- **Merge if**: [Critical changes] are **confirmed and expected**, [Anomalies] are **explained and acceptable**, downstream impacts are **validated with no issues**.
- **Investigate further if**: [Issues] are **unexpected** or data quality concerns are **unclear**; run suggested checks before deciding to merge.
- **Block merge if**: **Critical data quality regression** exists, **breaking schema changes** lack migration plan, or **unresolved threshold violations** remain.

---

## 📝 Formatting Guidelines

**Key Principles:**

- Use emoji for visual hierarchy: 🔴 (critical), ⚠ (warning), ✅ (ok), 📊 (data), 🔍 (review), 🧭 (decision)
- Bold important values: **-32.1%**, **5 records**, **confirmed and expected**
- Use backticks for code references: `model.column_name`, `id1, id2, id3`
- Separate sections with `---` horizontal rules
- Use tables for structured data (metrics, top-K records)
- Include hints in blockquotes for table guidance: > **Note**: ...
- Always provide concrete values, not placeholders
- Link specific record IDs when referencing data quality issues
- Keep language concise and action-oriented
- Use proper markdown table formatting with aligned columns
