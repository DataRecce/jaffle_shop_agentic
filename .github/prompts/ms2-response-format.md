# PR Validation Summary (MS2)

**Analysis Level**: PR/Git + dbt Metadata (Lineage)  
**Date**: [Current Date]

---

## ⚠ Lineage Changes Detected

**Modified Models**: X models
- `model.name1` (Y downstream dependencies)
- `model.name2` (Z downstream dependencies)
- [list all with dependency counts]

**New Models**: N models
- `model.new1`
- [list if any]

**Removed Models**: M models
- `model.old1`
- [list if any, flag as BREAKING CHANGE]

---

## Downstream Impact Analysis

### High Impact Models (>10 downstream dependencies)
- `model.name` → **X downstream models affected**
  - Direct children: [list top 3-5]
  - Impact radius: [staging/marts/metrics layers affected]

### Medium Impact Models (5-10 downstream dependencies)
- `model.name` → **Y downstream models affected**

### Lower Impact Models (<5 downstream dependencies)
- `model.name` → **Z downstream models affected**

---

## Breaking Changes Detected

> **Note**: Flag critical changes that may break downstream processes

### Removed Models
- 🔴 `model.removed1` - Had X downstream dependencies
  - Affected models: [list downstream models that referenced this]
  - **Action Required**: Update or remove dependent models

### Schema Modifications (if detectable from lineage)
- ⚠ `model.modified1` - Schema file also changed
  - Review for column additions/removals
  - May affect downstream SELECT statements

---

## Preset Check Coverage

**From recce.yml analysis:**

### Checks Covering Changed Models
- ✅ **row_count_diff**: Covers `customers`, `orders` (2 of X modified models)
- ✅ **query_diff**: Covers weekly aggregation in `customers`
- ⚠ **value_diff**: Only covers `customers`, but `orders` also modified

### Gaps in Coverage
- ❌ `model.uncovered1` - Modified but NO preset checks defined
- ❌ `model.uncovered2` - New model with no validation
- ⚠ `model.high_impact` - High downstream impact but only basic row count check

---

## Suggested Validation Checks

> **Note**: These are SUGGESTED checks based on lineage analysis. Actual execution requires MS3.

### Priority 1: Critical Validations
1. **Row Count Diff** for high-impact models:
   - `model.high_impact1` (X downstream dependencies)
   - `model.high_impact2` (Y downstream dependencies)
   - **Rationale**: Verify data volume stability for models with wide impact

2. **Profile Diff** for key metrics:
   - `customers.customer_lifetime_value` (core business metric)
   - `orders.total_amount` (aggregated values)
   - **Rationale**: Detect value shifts in critical business logic

### Priority 2: Recommended Validations
1. **Query Diff** for aggregation models:
   - Aggregated metrics in `model.agg1`
   - **Rationale**: Complex transformations need result validation

2. **Value Diff** for models with primary keys:
   - `model.with_pk1` on primary key `id`
   - **Rationale**: Ensure record-level integrity

### Priority 3: Optional Validations
- Row counts for lower-impact staging models
- Profile checks for dimensional attributes

---

## Recommended Action Plan

### ✅ Covered by Preset Checks
The following validations are already defined in recce.yml:
- [list checks that cover changed models]
- **Next Step**: Run `/ms3` to execute these checks with data

### ⚠ Requires Additional Validation
The following models need attention:
- [list models not covered by preset checks]
- **Next Step**: Consider adding checks to recce.yml or run ad-hoc validation

### 🔴 Breaking Changes - Immediate Action
- [list any removed models or critical schema changes]
- **Action**: Review and update dependent models/dashboards

---

## Limitations of MS2 Analysis

At this milestone, the analysis is limited to:
- ✅ Identifying lineage changes and downstream impact
- ✅ Detecting breaking changes (removed models)
- ✅ Suggesting validation checks based on impact
- ❌ Cannot execute data validation (no row counts, no value comparisons)
- ❌ Cannot quantify data changes (no "±15% rows" metrics)
- ❌ Cannot show actual data quality issues

**All suggested checks are RECOMMENDATIONS based on lineage. No actual data has been validated yet.**

---

## Next Steps

### To Execute Validations

**Run MS3 Analysis** (`@claude /ms3`):
- Requires: MS2 + data warehouse connection
- Executes: Row count diffs, profile diffs, query diffs
- Provides: Quantified metrics, actual data changes, anomaly detection

### Interactive Validation

**Launch Recce** for interactive exploration:
- [Launch Full Recce Instance](https://cloud.datarecce.io/launch?pr=[PR_NUMBER])
- [Launch Row Count Check](https://cloud.datarecce.io/launch?pr=[PR_NUMBER]&check=row_count)
- [Launch Lineage View](https://cloud.datarecce.io/launch?pr=[PR_NUMBER]&view=lineage)

---

## Summary Statistics

- **Models Modified**: X
- **Models Added**: Y
- **Models Removed**: Z
- **Total Downstream Impact**: N models affected
- **Preset Checks Applicable**: M checks
- **Suggested Additional Checks**: K checks
- **Breaking Changes**: [0 or count]

