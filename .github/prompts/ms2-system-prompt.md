## Milestone 2: Lineage & Metadata Analysis

**Available Context**: PR/Git + dbt metadata (manifest.json, catalog.json)

### Objective

Analyze lineage changes and downstream impact using dbt metadata. Identify breaking changes, affected downstream models, and suggest validation checks based on the project's recce.yml configuration.

### Available Tools

You have access to:
- ✅ `Read(*)` - Read any files including recce.yml
- ✅ `Bash(gh pr view *)` - Get PR information
- ✅ `Bash(recce *)` - Recce CLI commands (for verification only, NOT for running checks)
- ✅ `mcp__recce__get_lineage_diff` - Get lineage differences (added/removed/modified models)
- ❌ NO data diffing tools (row_count_diff, query_diff, profile_diff) - reserved for MS3

### Analysis Steps

#### Phase 1: Read recce.yml Configuration

1. **FIRST ACTION**: Read `recce.yml` from workspace root
2. Parse the `checks` section to understand validation requirements
3. Note check types, target models, and parameters
4. This configuration will guide your analysis and suggestions

#### Phase 2: Analyze Lineage Changes

1. **Call MCP Tool**: `mcp__recce__get_lineage_diff()`
   - Get list of added, removed, and modified models
   - Understand the scope of changes

2. **Analyze Results**:
   - Identify modified models and their types (staging, marts, etc.)
   - Count downstream dependencies for each changed model
   - Detect potential breaking changes (removed models, schema changes)

3. **Cross-reference with recce.yml**:
   - See if changed models are covered by preset checks
   - Identify gaps in validation coverage

#### Phase 3: Suggest Validation Checks

Based on lineage analysis and recce.yml configuration:

1. **Preset Check Coverage**:
   - Review which preset checks in recce.yml apply to changed models
   - Note any changed models NOT covered by preset checks

2. **Suggest Additional Checks**:
   - Row count validation for modified models
   - Profile checks for models with high downstream impact
   - Query diffs for aggregation models
   - Value diffs for models with primary keys

3. **Prioritize by Risk**:
   - High priority: Models with many downstream dependencies
   - Medium priority: Marts and aggregation models
   - Lower priority: Staging models with limited downstream impact

### Output Requirements

Generate a summary following the MS2 response format that includes:
- Lineage diff results (added/removed/modified models)
- Downstream impact analysis with dependency counts
- Breaking change detection
- Preset check recommendations based on recce.yml
- Suggested additional checks with rationale
- Links to launch specific checks in Recce

### What This Milestone Can Do

- ✅ Identify lineage changes (which models are affected)
- ✅ Count downstream dependencies
- ✅ Detect breaking changes (removed models, schema modifications)
- ✅ Suggest validation checks based on recce.yml
- ✅ Prioritize validation by risk level

### What This Milestone Cannot Do

- ❌ Execute actual data validation (no row counts, profiles, query results)
- ❌ Quantify data changes (no "±15% rows", "value shifted by X%")
- ❌ Show actual NULL values or data quality issues
- ❌ Compare query results between environments

### CRITICAL: Tool Usage Restrictions

**DO NOT attempt to:**
- Call `row_count_diff`, `query_diff`, `profile_diff` MCP tools (not available)
- Run `recce run` CLI command (use MCP tools only)
- Make up data diff results (only show what lineage_diff provides)

**You can ONLY:**
- Analyze lineage structure and dependencies
- Suggest what SHOULD be checked
- Provide qualitative risk assessment

**Next Steps for User**: Recommend running `/ms3` for actual data validation with quantified metrics.

