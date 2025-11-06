# PR Analysis Summary (MS1)

**Analysis Level**: Git/PR Context Only  
**Date**: [Current Date]

---

## Changes Overview

**Models**: [X] modified, [Y] new, [Z] deleted.  (Show the number if greater than zero; omit if none)
**Column Changes**: [X] modified, [Y] new, [Z] deleted. (Show the number if greater than zero; omit if none)

**Affected Models**:
- ⚠️ Modified: [list all modified models]
- New: [list all new models]
- Removed: [list all removed models]

**Column Changes**:
[Show new and modified columns in existing models. Do NOT show columns in new models. If there are more than ten new and modified columns, limit to the ten highest-impact columns and clarify that you did so.]

- [changed column definition] - [3-5 word description of what changed]
- [changed column definition] - [3-5 word description of what changed]
- [changed column definition] - [3-5 word description of what changed]
- [added column in existing table] - added
- [added column in existing table] - added

---

## Potential Impact (Qualitative Assessment)

Based on file locations and dbt conventions:

- **Scope**: [Wide/Medium/Narrow] - affects [staging/marts/specific area]
- **Risk Level**: [High/Medium/Low] - based on number of models and model types
- **Breaking Changes**: [Possible/Unlikely] - what the changes are

> **Note**: This assessment is based on file changes only. For precise dependency analysis and data validation, add dbt artifacts and data sources.

### Recommended Follow-up Checks

[Provide no more than ten follow up suggestions, prioritized by highest impact. These are exemplars.]

[] Check changed definitions, such as `old_model.changed_column`
[] Check downstream impact of changed `old_model.changed_column`
[] Validate new model, `new_model`
[] Ensure no downstream impact for removed `old_model`

[Launch Recce](https://cloud.datarecce.io/launch?pr=[PR_NUMBER]) to perform interactive validation.

---

## Limitations of MS1 Analysis

At this milestone, the analysis is limited to:

- ✅ Identifying which models changed (from Git diff)
- ✅ Categorizing changes by directory structure
- ❌ Cannot analyze downstream dependencies (requires dbt lineage metadata)
- ❌ Cannot validate data quality or row counts (requires data warehouse connection)
- ❌ Cannot suggest specific validation checks (requires recce.yml + artifacts)

---

- **PR Number**: #[number] ([PR_title])  [head branch] → [base branch]
- **Files Changed**: [total count]
