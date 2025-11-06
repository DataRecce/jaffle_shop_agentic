# PR Validation Summary (MS2) - REVISED FORMAT
## Copyright 2025 - Revised

**Analysis Level**: PR/Git + dbt Metadata (Lineage)  
**Date**: [Current Datetime] - **You MUST SHOWS CURRENT TIME**, **IF YOU DON'T KNOW IT PLEASE SHOWS 12:00**




---

## 📋 Lineage Changes

> **Note**: Report lineage_diff tool output directly

**Modified Models**: [count]
- `model.name1`
- `model.name2`
- [list all modified models]

**New Models**: [count]
- `model.new1`
- [list all new models if any]

**Removed Models**: [count]
- 🔴 `model.removed1` ← **BREAKING CHANGE**
- [list all removed models if any]

---

## 🔍 Breaking Changes

> **Note**: Only show this section if there are removed models

- 🔴 **`model.removed_name`** has been removed
  - This is a potential breaking change for downstream dependencies
  - **Action**: Verify no downstream models/dashboards depend on this

---

## ✅ Preset Check Coverage

> **Note**: Cross-reference changed models with recce.yml

**Models Covered by Preset Checks**:
- `customers` → row_count_diff, value_diff, query_diff
- `orders` → row_count_diff

**Models NOT Covered**:
- `model.uncovered1` - No preset checks defined
- `model.uncovered2` - New model with no validation

---

## 🎯 Recommended Next Steps

### Option 1: Run Data Validation (Recommended)
Run `/ms3` to execute actual data validation:
- ✅ Quantified row count changes
- ✅ Value shift detection
- ✅ Data quality metrics
- ✅ Profile comparisons

### Option 2: Interactive Review
Launch Recce for manual exploration:
- [Launch Recce Instance](https://cloud.datarecce.io/launch?pr=[PR_NUMBER])

---

## 📝 Summary

- **Modified Models**: [count]
- **New Models**: [count]
- **Removed Models**: [count] ← Breaking changes if > 0
- **Preset Check Coverage**: [X of Y models covered]

---

## ⚠ Limitations

**What MS2 Provides:**
- ✅ List of changed models
- ✅ Breaking change detection

**What MS2 Does NOT Provide:**
- ❌ No row counts
- ❌ No data metrics
- ❌ No quantified impact

**For quantified data validation, run `/ms3`**

