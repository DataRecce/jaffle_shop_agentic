## Milestone 3: Full Data Validation

**Available Context**: PR/Git + dbt metadata + data warehouse connection

### Objective

Perform comprehensive data validation by executing row count comparisons, profile analysis, and query diffs. Quantify the actual impact of changes with concrete metrics and detect data quality anomalies.

### Available Tools

You have FULL access to all tools:
- ✅ `Read(*)` - Read any files including recce.yml
- ✅ `Bash(gh pr view *)` - Get PR information
- ✅ `Bash(recce *)` - Recce CLI (for verification only, NOT for running checks)
- ✅ `mcp__recce__get_lineage_diff` - Get lineage differences
- ✅ `mcp__recce__row_count_diff` - Compare row counts between base and current
- ✅ `mcp__recce__query` - Execute SQL query on specified environment
- ✅ `mcp__recce__query_diff` - Compare SQL query results between environments
- ✅ `mcp__recce__profile_diff` - Compare statistical profiles (min/max/avg/distinct)

### Analysis Steps

#### Phase 1: Read recce.yml Configuration (REQUIRED)

1. **FIRST ACTION**: Read `recce.yml` from workspace root
2. Parse the `checks` section to understand validation scope
3. Note each check's name, type, description, and params
4. **IMPORTANT**: `recce.yml` defines preset checks for `recce run` command, NOT for MCP tools

#### Phase 2: Perform Analysis Using Recce MCP Tools (MANDATORY)

⚠️ **CRITICAL: Tool Selection Rules**

**YOU MUST USE MCP TOOLS ONLY - DO NOT USE RECCE CLI**

- ✅ **CORRECT**: Call `mcp__recce__get_lineage_diff`, `mcp__recce__row_count_diff`, `mcp__recce__query`, `mcp__recce__query_diff`, `mcp__recce__profile_diff`
- ❌ **WRONG**: DO NOT run `recce run` command via Bash tool
- ❌ **WRONG**: DO NOT execute `recce` CLI commands (except `recce version` for verification)
- ❌ **WRONG**: DO NOT try to execute preset checks directly via CLI

**Why MCP instead of CLI:**
- MCP tools provide programmatic access to Recce analysis with structured output
- CLI `recce run` executes preset checks but outputs unstructured text for humans
- MCP tools return JSON data that can be analyzed and compared
- CLI output cannot be reliably parsed in this automated workflow

---

🚨 **CRITICAL: Execute Phase 2 REGARDLESS of whether the PR contains file changes.**

**Even if the PR has:**
- No file changes
- Only merge commits
- No model modifications
- Empty commit history

**You MUST still:**
1. Call `mcp__recce__get_lineage_diff` to confirm no lineage changes
2. Call `mcp__recce__row_count_diff` for models referenced in recce.yml (if any)
3. If recce.yml has no specific model filters, check ALL models in the project
4. Use other MCP tools as appropriate based on recce.yml configuration

**Rationale**: MCP analysis validates data stability and catches issues that may not be visible in code changes alone (e.g., upstream data changes, schema drift, data quality degradation).

---

**Use Recce MCP tools to perform SIMILAR analysis as defined in `recce.yml`**:

⚠️ **CRITICAL LIMITATIONS:**
- MCP tools provide LOW-LEVEL analysis capabilities (lineage, row counts, queries, profiles)
- MCP tools CANNOT directly execute preset checks defined in `recce.yml`
- Some check types (e.g., `value_diff`) have NO direct MCP equivalent
- Use MCP tools to perform EQUIVALENT analysis based on recce.yml guidance

**Check Type to MCP Tool Mapping (How to Execute Each Check):**

### 1. `schema_diff` check → Use `mcp__recce__get_lineage_diff`

**What recce.yml defines:**
```yaml
type: schema_diff
params:
  select: customers orders state:modified
```

**How to execute with MCP:**
- ⚠️ **Limitation**: MCP only provides lineage diff (added/removed/modified models), NOT detailed column-level schema
- Call `mcp__recce__get_lineage_diff()` with no params (gets all changes)
- Or use `select` param if you want to filter specific models
- **Report**: List modified models and note that detailed schema changes require manual inspection

**Example MCP call:**
```
mcp__recce__get_lineage_diff()
```

---

### 2. `row_count_diff` check → Use `mcp__recce__row_count_diff` ✅

**What recce.yml defines:**
```yaml
type: row_count_diff
params:
  select: customers orders state:modified,config.materialized:table
```

**How to execute with MCP:**
- ✅ **Direct mapping available**
- Call `mcp__recce__row_count_diff()` with `select` parameter from recce.yml
- Or use `node_names` for specific models: `["customers", "orders"]`
- **Report**: Show current vs base row counts, calculate % change

**Example MCP call:**
```
mcp__recce__row_count_diff(node_names=["customers", "orders"])
```

---

### 3. `value_diff` check → Use `mcp__recce__query_diff` ⚠️

**What recce.yml defines:**
```yaml
type: value_diff
params:
  model: customers
  primary_key: customer_id
  columns:
    - customer_id
    - customer_lifetime_value
```

**How to execute with MCP:**
- ⚠️ **NO direct MCP tool** - must construct SQL query manually
- Build SQL that selects specified columns with primary key
- Use `mcp__recce__query_diff()` with the SQL and `primary_keys` parameter
- **Report**: Show matched/unmatched row counts, % match rate

**Example MCP call:**
```
mcp__recce__query_diff(
  sql_template="SELECT customer_id, customer_lifetime_value FROM {{ ref('customers') }} ORDER BY customer_id",
  primary_keys=["customer_id"]
)
```

---

### 4. `query_diff` check → Use `mcp__recce__query_diff` ✅

**What recce.yml defines:**
```yaml
type: query_diff
params:
  sql_template: |
    SELECT
      DATE_TRUNC('week', first_order) AS first_order_week,
      AVG(customer_lifetime_value) AS avg_lifetime_value
    FROM {{ ref("customers") }}
    WHERE first_order is not NULL
    GROUP BY first_order_week
    ORDER BY first_order_week;
```

**How to execute with MCP:**
- ✅ **Direct mapping available**
- Copy `sql_template` exactly from recce.yml
- Call `mcp__recce__query_diff()` with the SQL template
- **Report**: Show aggregated metrics comparison, highlight significant variances

**Example MCP call:**
```
mcp__recce__query_diff(
  sql_template="<exact SQL from recce.yml>"
)
```

---

### 5. `profile_diff` check → Use `mcp__recce__profile_diff` ✅

**What recce.yml defines:**
```yaml
# NOTE: No profile_diff check in current recce.yml
# But if one exists, it would look like:
type: profile_diff
params:
  model: customers
  columns:
    - customer_lifetime_value
    - number_of_orders
```

**How to execute with MCP:**
- ✅ **Direct mapping available**
- Call `mcp__recce__profile_diff()` with model name
- Optionally specify columns to profile
- **Report**: Show min/max/avg/distinct counts, calculate % changes

**Example MCP call:**
```
mcp__recce__profile_diff(model="customers", columns=["customer_lifetime_value", "number_of_orders"])
```

---

**Execution Guidelines:**

1. **For EACH check in recce.yml**:
   - Identify the check type
   - Use the mapping above to determine which MCP tool to call
   - Extract params from recce.yml and adapt them to MCP tool format
   - Execute the MCP tool call
   - Collect and analyze results

2. **Important Notes**:
   - recce.yml params may not exactly match MCP tool params - adapt as needed
   - For `value_diff`, you MUST construct the SQL query manually
   - For `schema_diff`, MCP provides limited info (only modified models, not column changes)
   - Always call MCP tools even if you think results will be the same

3. **After all checks complete**:
   - Collect all results
   - Determine if any anomalies detected
   - Proceed to Phase 3 for output formatting

#### Phase 3: Analyze Results and Determine Output Format

**Decision Logic:**
- **IF any check result shows anomalies** (threshold exceeded, unexpected changes, data quality issues):
  → Output FULL PR Validation Summary using the response format template
- **IF all checks pass without anomalies**:
  → Output brief success message: "✅ All Recce preset checks passed. No anomalies detected."

**Anomaly Detection Criteria:**
- Row count changes > 5% (or custom threshold in check definition)
- Schema changes (added/removed/modified columns)
- Profile metrics exceed specified thresholds
- Unexpected NULL values or data quality issues
- Query diff results show significant variance

### Output Requirements

Generate a comprehensive summary following the MS3 response format that includes:
- Lineage changes with quantified metrics
- Row count diffs with actual numbers and percentages
- Profile diffs with min/max/avg/distinct comparisons
- Query diff results with specific value changes
- Anomaly detection with severity indicators
- Suggested checks with links to Recce instance

### What This Milestone Provides

- ✅ Complete lineage and downstream impact analysis
- ✅ Quantified row count changes (±X rows, ±Y%)
- ✅ Statistical profile comparisons (min/max/avg/distinct)
- ✅ Query result comparisons with specific values
- ✅ Data quality anomaly detection
- ✅ Concrete recommendations with priority levels
- ✅ Links to interactive Recce checks

### Critical Reminders

- **Use MCP tools**, not CLI commands
- **Execute checks even for PRs with no file changes**
- **Report concrete values**, not placeholders
- **Detect anomalies** based on thresholds
- **Provide actionable recommendations**

