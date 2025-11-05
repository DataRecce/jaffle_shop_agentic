# PR Analysis Summary (MS1)

**Analysis Level**: Git/PR Context Only  
**Date**: [Current Date]

---

## Changed Models

**Modified Models** (X files):
- `models/staging/stg_customers.sql`
- `models/marts/customers.sql`
- [list all modified .sql files]

**New Models** (Y files):
- `models/marts/new_model.sql`
- [list if any]

**Removed Models** (Z files):
- `models/deprecated/old_model.sql`
- [list if any]

**Other Changes**:
- Schema files modified: [list .yml files if any]
- Configuration changes: [packages.yml, dbt_project.yml if modified]

---

## Change Breakdown by Layer

### Staging Models
- X models modified
- Focus: [brief description of changes]

### Marts Models
- Y models modified
- Focus: [brief description of changes]

### Other Layers
- [if applicable]

---

## Potential Impact (Qualitative Assessment)

Based on file locations and dbt conventions:
- **Scope**: [Wide/Medium/Narrow] - affects [staging/marts/specific area]
- **Risk Level**: [High/Medium/Low] - based on number of models and model types
- **Breaking Changes**: [Possible/Unlikely] - note if schema files also modified

> **Note**: This assessment is based on file changes only. For precise dependency analysis and data validation, use `/ms2` (with dbt metadata) or `/ms3` (with full data diff).

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

### For Deeper Analysis

1. **Run MS2 Analysis** (`@claude /ms2`):
   - Requires: dbt artifacts (manifest.json, catalog.json)
   - Provides: Lineage diff, downstream impact, breaking change detection
   - Suggests: Preset checks based on recce.yml

2. **Run MS3 Analysis** (`@claude /ms3`):
   - Requires: MS2 + data warehouse connection
   - Provides: Row count diffs, profile diffs, value changes
   - Quantifies: Actual data impact with metrics

### Launch Recce for Interactive Validation

[Launch Recce](https://cloud.datarecce.io/launch?pr=[PR_NUMBER]) to perform interactive validation with full visualization.

---

## PR Details

- **PR Number**: #[number]
- **Title**: [PR title]
- **Files Changed**: [total count]
- **Branch**: [head branch] → [base branch]

