# PR Analysis Summary (MS1)

**Analysis Level**: Git/PR Context Only  
**Date**: [Current Date]

---

## Changed Models

**Modified Models** (X models. Do not show this section if there are none.):

- `stg_user_data` - note
- `customers`
- [list all modified models]

**New Models** (Y models. Do not show this section if there are none.):

- `new_model`
- [list if any]

**Removed Models** (Z models. Do not show this section if there are none.):

- `old_model`
- [list if any]

---

## Potential Impact (Qualitative Assessment)

Based on file locations and dbt conventions:

- **Scope**: [Wide/Medium/Narrow] - affects [staging/marts/specific area]
- **Risk Level**: [High/Medium/Low] - based on number of models and model types
- **Breaking Changes**: [Possible/Unlikely] - what the changes are

> **Note**: This assessment is based on file changes only. For precise dependency analysis and data validation, add dbt artifacts and data sources.

---

## Limitations of MS1 Analysis

At this milestone, the analysis is limited to:

- ✅ Identifying which models changed (from Git diff)
- ✅ Categorizing changes by directory structure
- ❌ Cannot analyze downstream dependencies (requires dbt lineage metadata)
- ❌ Cannot validate data quality or row counts (requires data warehouse connection)
- ❌ Cannot suggest specific validation checks (requires recce.yml + artifacts)

---

## Recommended Next Steps

### Recommended Follow-up Checks

[] Check changed definitions, such as `old_model.changed_column`
[] Check downstream impact of changed `old_model.changed_column`
[] Validate new model, `new_model`
[] Ensure no downstream impact for removed `old_model`

### Launch Recce for Interactive Validation

[Launch Recce](https://cloud.datarecce.io/launch?pr=[PR_NUMBER]) to perform interactive validation with full visualization.

---

## PR Details

- **PR Number**: #[number]
- **Title**: [PR title]
- **Files Changed**: [total count]
- **Branch**: [head branch] → [base branch]
