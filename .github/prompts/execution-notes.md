---

## ⚙️ Execution Checklist

### For All Milestones

- [ ] 🚨 **Tool Restriction**: Will ONLY use tools allowed for this milestone
- [ ] 🚨 **No CLI Commands**: Will NOT run `recce run` or other CLI commands (except verification)
- [ ] 🚨 **MCP Understanding**: Understood that MCP tools provide LOW-LEVEL analysis, NOT preset check execution
- [ ] ✅ **Concrete Values**: All data from actual tool results (no placeholders)

### MS1 Checklist (Git/PR Only)

- [ ] ✅ Get PR information via `gh pr view`
- [ ] ✅ Analyze Git changes with `git diff`
- [ ] ✅ Identify modified `.sql` files in `models/` directory
- [ ] ✅ Categorize changes by model type/directory
- [ ] ✅ Provide qualitative impact assessment
- [ ] ✅ Output MS1 response format
- [ ] ✅ Recommend MS2/MS3 for deeper analysis

### MS2 Checklist (+ dbt Metadata)

- [ ] ✅ Read and parse `recce.yml` to understand validation scope
- [ ] ✅ Call `mcp__recce__get_lineage_diff` to get lineage changes
- [ ] ✅ Analyze downstream dependencies and impact radius
- [ ] ✅ Detect breaking changes (removed models, schema changes)
- [ ] ✅ Cross-reference with recce.yml preset checks
- [ ] ✅ Suggest validation checks based on lineage and impact
- [ ] ✅ Prioritize checks by risk level
- [ ] ✅ Output MS2 response format
- [ ] ✅ Recommend MS3 for actual data validation

### MS3 Checklist (+ Data Diffs)

- [ ] ✅ Read and parse `recce.yml` from workspace root
- [ ] ✅ Confirmed recce.yml defines preset checks for `recce run` command (NOT for MCP)
- [ ] ✅ Called `mcp__recce__get_lineage_diff` to check for lineage changes
- [ ] ✅ Called `mcp__recce__row_count_diff` for relevant models
- [ ] ✅ Used other appropriate MCP tools based on recce.yml guidance
- [ ] ✅ Adapted preset check parameters to MCP tool parameters (different formats)
- [ ] ✅ For checks without direct MCP mapping (e.g., value_diff), constructed equivalent analysis
- [ ] ✅ Analyzed MCP results and determined if anomalies exist
- [ ] ✅ Chose correct output format (brief success OR full validation summary)
- [ ] ✅ If using full format, verified against Output Validation Checklist

**🚨 CRITICAL for MS3**: Execute MCP analysis EVEN IF PR has no file changes (data validation is MANDATORY)

---

## 🚫 Common Mistakes to Avoid

### Tool Usage Mistakes

1. **🚨 DO NOT use Recce CLI commands** - NEVER run `recce run`. ONLY use MCP tools (`mcp__recce__*`)
2. **🚨 DO NOT think MCP can execute preset checks** - MCP tools provide LOW-LEVEL analysis, NOT preset check execution
3. **DO NOT expect exact parameter mapping** - MCP tool parameters differ from preset check parameters

### Analysis Mistakes

4. **🚨 DO NOT skip analysis because "no file changes"** (MS3 only) - ALWAYS execute MCP analysis regardless of code changes
5. **DO NOT skip reading `recce.yml`** (MS2/MS3) - this is the first mandatory step to understand validation scope
6. **DO NOT try to directly execute preset checks with MCP** - use recce.yml as REFERENCE, then use MCP tools for equivalent analysis
7. **DO NOT skip MCP tool calls for empty PRs** - Even merge-only PRs need data validation

### Output Mistakes

8. **DO NOT output full report if all checks pass** (MS3) - use brief success message instead
9. **DO NOT use placeholder values** - all data must come from actual tool results
10. **DO NOT exceed milestone capabilities** - MS1 cannot analyze lineage, MS2 cannot execute data diffs

---

## Example Execution Flows

### MS1 Example: Git Analysis Only

```
1. Get PR info via gh pr view
2. Run git diff to find changed files
3. Identify modified models:
   - models/staging/stg_customers.sql
   - models/marts/customers.sql
4. Categorize: 1 staging, 1 marts model
5. Assess impact: Medium (affects marts layer)
6. Output MS1 format with model list
7. Recommend MS2 for lineage analysis
```

### MS2 Example: Lineage Analysis

```
1. Read recce.yml → Found 4 preset checks
2. Call mcp__recce__get_lineage_diff
   → Result: 2 models modified, 8 downstream dependencies
3. Analyze impact:
   - customers: 5 downstream models
   - orders: 3 downstream models
4. Check recce.yml coverage:
   - row_count_diff covers both models ✅
   - query_diff covers customers ✅
5. Suggest additional checks:
   - profile_diff for customer_lifetime_value
6. Output MS2 format with lineage and suggestions
7. Recommend MS3 for data validation
```

### MS3 Example: Full Data Validation

```
1. Read recce.yml → Found 4 preset checks
2. Call mcp__recce__get_lineage_diff
   → Result: 2 models modified
3. Call mcp__recce__row_count_diff(node_names=["customers", "orders"])
   → Result: customers -15% rows (ANOMALY!)
4. Construct query_diff for value analysis
   → Result: 5% mismatch in customer_lifetime_value
5. Call query_diff with recce.yml template
   → Result: avg revenue variance -32.1% (ANOMALY!)
6. Determine: Multiple anomalies detected
7. Output: Full PR Validation Summary
8. Include: Concrete metrics, severity indicators, recommendations
```

### MS3 Example: All Checks Pass

```
1. Read recce.yml
2. Execute all MCP analyses
3. Results: All metrics within thresholds
4. Output: "✅ All Recce preset checks passed. No anomalies detected."
```

---

## Tool Availability by Milestone

### MS1: Git/PR Only
- ✅ `Read(*)` - Any files
- ✅ `Bash(gh pr view *)` - GitHub CLI
- ✅ `Bash(git *)` - Git commands
- ❌ NO Recce MCP tools
- ❌ NO dbt artifacts

### MS2: + dbt Metadata
- ✅ All MS1 tools
- ✅ `Bash(recce)` - Verification only
- ✅ `mcp__recce__get_lineage_diff` - Lineage analysis ONLY
- ❌ NO data diff tools (row_count, query, profile)

### MS3: + Data Diffs
- ✅ All MS2 tools
- ✅ `mcp__recce__row_count_diff` - Row count comparison
- ✅ `mcp__recce__query` - Execute SQL queries
- ✅ `mcp__recce__query_diff` - Compare query results
- ✅ `mcp__recce__profile_diff` - Statistical profiles

---

## Key Reminders

- **Milestone Focus**: Stay within your milestone's capabilities
- **Tool Restrictions**: Only use tools explicitly allowed for your milestone
- **recce.yml**: Use as REFERENCE, not for direct execution
- **MCP vs CLI**: Always use MCP tools, never CLI commands (except verification)
- **Concrete Values**: No placeholders - only actual data from tool results
- **Empty PRs**: MS3 MUST still execute data validation (catches non-code issues)
- **Output Format**: Follow the exact format template for your milestone
