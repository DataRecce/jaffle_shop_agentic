## Milestone 2: Lineage & Metadata Analysis

**Available Context**: PR/Git + dbt metadata (manifest.json, catalog.json)

### Objective

Use dbt lineage to identify breaking changes and downstream impact. Help users understand WHICH models need validation without executing actual data checks.

**Success Metric**: User can identify which downstream models to validate without opening Recce.

### Available Tools

You have access to:
- ✅ `Read(*)` - Read any files including recce.yml
- ✅ `Bash(gh pr *)` - Get PR information
- ✅ `Bash(recce version)` - Recce version check only
- ✅ `mcp__recce__get_lineage_diff` - Get lineage differences (added/removed/modified models)
- ❌ NO data diffing tools (row_count_diff, query_diff, profile_diff) - reserved for MS3

### Analysis Steps

#### Phase 1: Get Lineage Changes (REQUIRED)

1. **Call MCP Tool**: `mcp__recce__get_lineage_diff()`
   - This tool returns: added models, removed models, modified models
   - **IMPORTANT**: Use the tool's output DIRECTLY - do NOT manually calculate dependencies

2. **Identify Breaking Changes**:
   - Removed models (potential breaking change)
   - Modified models that may affect downstream

#### Phase 2: Review recce.yml (OPTIONAL)

1. **Read `recce.yml`** (if exists) from workspace root
2. **Cross-reference**: Which changed models are covered by existing preset checks?
3. **Note gaps**: Which changed models have NO preset checks defined?

#### Phase 3: Suggest Next Steps

Based on lineage changes, suggest:
1. **Which models** should be validated (based on modification type and downstream impact from lineage_diff)
2. **What preset checks** exist in recce.yml for those models
3. **Recommend running MS3** to execute actual data validation

### Output Requirements

Generate a concise summary following the MS2 response format that includes:
- **Lineage changes**: List of added/removed/modified models from lineage_diff tool
- **Breaking changes**: Highlight removed models (if any)
- **Downstream impact**: Use information provided by lineage_diff tool DIRECTLY
- **Preset check coverage**: Which models are covered by recce.yml checks
- **Suggested next step**: Recommend running `/ms3` for data validation

### What This Milestone Provides

- ✅ List of changed models (from lineage_diff)
- ✅ Breaking change detection (removed models)
- ✅ Downstream impact indicators (from lineage_diff output)
- ✅ Preset check coverage assessment

### What This Milestone Does NOT Provide

- ❌ Row counts or data volume metrics
- ❌ Value changes or data quality metrics
- ❌ Manual dependency calculations
- ❌ Quantified impact (no "±15% rows", no percentages)

### CRITICAL: Keep It Simple

**DO:**
- ✅ Report lineage_diff output directly
- ✅ Highlight breaking changes (removed models)
- ✅ Note which models have preset checks in recce.yml
- ✅ Recommend running MS3 for data validation

**DO NOT:**
- ❌ Manually count downstream dependencies
- ❌ Calculate impact levels (high/medium/low)
- ❌ Try to execute data validation
- ❌ Spend time on complex analysis

**Expected Completion Time**: < 2 minutes

If your analysis is taking longer, you are overcomplicating it. Stick to reporting what lineage_diff provides.

