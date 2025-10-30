# Recce PR Analysis Response Format

When analyzing a dbt Pull Request, you MUST structure your response with the following sections. Use "# PR Validation Summary" as the main title in your actual response.

**CRITICAL**: Sections marked with [REQUIRED] MUST be included. Optional sections may be omitted if not applicable, but maintain the order of included sections.

---
## [REQUIRED] Compared environment
|  | Manifest	 | Catalog | 
| Production |	YYYY-MM-DD HH:SS:MM	| YYYY-MM-DD HH:SS:MM | 
| This PR | 	YYYY-MM-DD HH:SS:MM | 	YYYY-MM-DD HH:SS:MM | 

>> **Note** compare the time between these 2 environments and provide status, 🔴 if date diff >= 1 day, ⚠  if date diff < 1 day and > 4 hours,  ✅ if date diff <= 4 hours
- 🔴 the date diff is **X** hours, please check your data
- ⚠ the date diff is  **X** hours, be aware of the potential issue
- ✅ the data diff is  **X** mintues

---

## [REQUIRED] ⚠ Anomalies Detected

Use emoji indicators for severity:

- 🔴 Critical issues (e.g., Large value shift: `model.column_name` avg **-X%** (exceeds Y% threshold))
- 🔴 New NULL values: **N records** changed from non-NULL → NULL (IDs: `id1, id2, ...`) — **X%**
- ⚠ Warnings (e.g., High-magnitude changes: specific description **-X% ~ -Y%**)
- ✅ Stable metrics (e.g., Row counts stable: All models maintained record counts)

If no critical issues, state: "✅ No critical anomalies detected"

---
## [REQUIRED] Changed Overview

Lineage Diff
>> **Note** generate mermaid graph from left to right to display the lineage diff with impact radius, highlight the transformation type of impact columns. If the models are more then 20, show the lineage focus on the model that have most changes

- Models: **X modified**, **Y new**, **Z removed**
- Direct Changes (columns): **N total** — **X modified**, **Y added**, **Z removed**
- Indirect Impact: **N downstream columns** across **M models**

### Top Columns Changes (by downsteam impact)
- `model.column_name` → description of change
- `model.column_name` → description of change
- `model.column_name` → description of change
- [X more columns] [link to lineage diff](#link to Recce Cloud)


---
## [REQUIRED] ✅ Checks Summary

> **Note**: Read recce.yml to get what to test, the status can be like below exmaples. Show action links that users can click to lauch the check in Recce for each check

**Preset check results:**
- ✅ Schema validation: **N columns added/modified/removed** [See in Recce](link to launch this check in Recce)
- ✅ Row count validation: **all stable** / specific changes noted [See in Recce](link to launch this check in Recce)
- ⚠ Profile threshold exceeded: **>X% change in [metric]** [See in Recce](link to launch this check in Recce)
  
> **Note**: Based on your understanding, call out the highest risk that users should check as suggsted checks with reason briefly. If you can do the checks with MCP, then provide the result. If not, still write the suggested validation.Show action links that users can click to lauch the check in Recce for each check
**Suggested checks:**
- ✅ Profile diff in `model.column_name` and the result is no change. [See in Recce](link to launch this check in Recce)
- ⚠  Row counts diff in `model.column_name` and see **>X% change in [metric]** [See in Recce](link to launch this check in Recce)
- ❌ Critical failures: (if any) [See in Recce](link to launch this check in Recce)

**[Lauch Recce](link to launch this PR in Recce)**

---

## [OPTIONAL] 📊 Validation Results
> **Note**: Show the diff section based oon the result from preset check results and suggested checks result. Show the restuls when they are ⚠  or ❌. Skip the section if it's ✅.


### Schema Diff
Use `mcp__recce__schema_diff` results (prefer table format):

- `model.column_name`: current_count (change: ±X rows, ±Y%)


### Row Count Diff

Use `mcp__recce__row_count_diff` results (prefer table format):

- `model_name`: current_count (change: ±X rows, ±Y%)


### Profile Diff

**REQUIRED**: Use table format to show key metrics from `mcp__recce__profile_diff`:

| Metric                  | Current | Change | Threshold | Status     |
| ----------------------- | ------- | ------ | --------- | ---------- |
| model.column_name (avg) | value   | ±X%    | Y%        | ✅/⚠ Status |
| model.column_name (sum) | value   | ±X%    | Y%        | ✅/⚠ Status |

**Example with actual values:**

| Metric                                      | Current | Change | Threshold | Status     |
| ------------------------------------------- | ------- | ------ | --------- | ---------- |
| customers.customer_lifetime_value (avg)     | 124.8   | -32.1% | 30%       | ⚠ Exceeded |
| customers.net_customer_lifetime_value (avg) | 98.4    | +2.3%  | 30%       | ✅ Within   |
| orders.total_amount (sum)                   | 1245320 | -4.8%  | 10%       | ✅ Within   |

> **Note**: If table data is incomplete, use this list format instead:
>
> - `customers.customer_lifetime_value` (avg): 124.8 (change: -32.1%, threshold: 30%, ⚠ exceeded)
> - `customers.net_customer_lifetime_value` (avg): 98.4 (change: +2.3%, threshold: 30%, ✅ within)

### Top-K Affected Records

**Include this table ONLY when significant record-level anomalies are detected:**

| Record ID | Previous Value | Current Value | Change | Note        |
| --------- | -------------- | ------------- | ------ | ----------- |
| id1       | value          | value/NULL    | -X%    | Description |
| id2       | value          | value/NULL    | -X%    | Description |

> **Note**: Fill with actual Diff results. Only provide this table when significant anomalies are detected.


---

## 📝 Formatting Guidelines

**Key Principles:**

- Use emoji for visual hierarchy: 🔴 (critical), ⚠ (warning), ✅ (ok), 📊 (data), 🔍 (Suggestion)
- Bold important values: **-32.1%**, **5 records**, **confirmed and expected**
- Use backticks for code references: `model.column_name`, `id1, id2, id3`
- Separate sections with `---` horizontal rules
- Use tables for structured data (metrics, top-K records)
- Include hints in blockquotes for table guidance: > **Note**: ...
- Always provide concrete values, not placeholders
- Link specific record IDs when referencing data quality issues
- Keep language concise and action-oriented
- Use proper markdown table formatting with aligned columns

---

## ✅ Output Validation Checklist

Before submitting your response, verify:

- [ ] Main title is "# PR Validation Summary [current_date]"
- [ ] Add current date to title
- [ ] All [REQUIRED] sections are included in order
- [ ] Section titles match exactly (including emoji indicators)
- [ ] Major sections separated with `---` horizontal rules
- [ ] Profile Diff uses table format (or list with explanation)
- [ ] Concrete values used instead of placeholders
- [ ] Decision Guide provides clear merge/investigate/block guidance
- [ ] Based on actual Recce MCP tool results, not assumptions
