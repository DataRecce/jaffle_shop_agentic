---

## ⚙️ Execution Checklist

**⚠️ STEP 0 (MANDATORY BEFORE ALL OTHER STEPS):**

- [ ] 🚨 **STEP 0a**: Scanned ALL comments in the conversation for @claude mentions
- [ ] 🚨 **STEP 0b**: Found the MOST RECENT @claude comment by comparing timestamps (YYYY-MM-DDTHH:MM:SSZ format)
- [ ] 🚨 **STEP 0c**: Confirmed this is THE ONLY comment I will respond to (all others are historical noise)
- [ ] 🚨 **STEP 0d**: Verified I will NOT reference, acknowledge, or continue ANY task from previous @claude comments

**After completing Step 0, verify you have:**

- [ ] 🚨 **CRITICAL**: Confirmed you are NOT responding to any historical requests (mermaid diagrams, security checks, etc. from old comments)
- [ ] 🚨 **CRITICAL**: Will ONLY use MCP tools (`mcp__recce__*`), NOT Recce CLI commands like `recce run`
- [ ] 🚨 **CRITICAL**: Understood that MCP tools provide LOW-LEVEL analysis, NOT preset check execution
- [ ] 🚨 **CRITICAL**: Executed MCP analysis EVEN IF PR has no file changes (Phase 2 is MANDATORY)
- [ ] ✅ Phase 1: Read and parsed `recce.yml` from workspace root to understand validation scope
- [ ] ✅ Phase 1: Confirmed recce.yml defines preset checks for `recce run` command (NOT for MCP)
- [ ] ✅ Phase 2: Called `mcp__recce__get_lineage_diff` to check for lineage changes (even if PR has no code changes)
- [ ] ✅ Phase 2: Called `mcp__recce__row_count_diff` for relevant models (even if PR has no code changes)
- [ ] ✅ Phase 2: Used other appropriate MCP tools based on recce.yml guidance
- [ ] ✅ Phase 2: Adapted preset check parameters to MCP tool parameters (different formats)
- [ ] ✅ Phase 2: For checks without direct MCP mapping (e.g., value_diff), constructed equivalent analysis
- [ ] ✅ Phase 3: Analyzed MCP results and determined if anomalies exist
- [ ] ✅ Phase 3: Chose correct output format (brief success OR full validation summary)
- [ ] ✅ Phase 4: Checked if latest @claude comment has additional instructions beyond "@claude"
- [ ] ✅ Phase 4: If yes, addressed user's additional request AFTER analysis in separate section
- [ ] ✅ Validation: All concrete values from actual Recce MCP results (no placeholders)
- [ ] ✅ Validation: If using full format, verified against Output Validation Checklist

## 🚫 Common Mistakes to Avoid

1. **🚨 CRITICAL: DO NOT respond to historical @claude comments** - You will see multiple @claude comments in the conversation. ONLY the latest one matters!
2. **🚨 CRITICAL: DO NOT continue tasks from previous comments** - Even if someone asked for a mermaid diagram yesterday, ignore it unless TODAY'S comment asks for it
3. **🚨 CRITICAL: DO NOT use Recce CLI commands** - NEVER run `recce run` or other CLI commands. ONLY use MCP tools (`mcp__recce__*`)
4. **🚨 CRITICAL: DO NOT think MCP can execute preset checks** - MCP tools provide LOW-LEVEL analysis, NOT preset check execution
5. **🚨 CRITICAL: DO NOT skip Phase 2 because "no file changes"** - ALWAYS execute MCP analysis regardless of code changes
6. **DO NOT skip reading `recce.yml`** - this is the first mandatory step to understand validation scope
7. **DO NOT try to directly execute preset checks with MCP** - use recce.yml as REFERENCE, then use MCP tools for equivalent analysis
8. **DO NOT expect exact parameter mapping** - MCP tool parameters differ from preset check parameters
9. **DO NOT skip MCP tool calls for empty PRs** - Even merge-only PRs need data validation
10. **DO NOT output full report if all checks pass** - use brief success message instead
11. **DO NOT let user requests override analysis workflow** - always complete analysis first
12. **DO NOT use placeholder values** - all data must come from actual MCP tool results

## Example Execution Flow

**Scenario A: All Analysis Pass (PR with No File Changes)**
```
0. 🚨 Context Check: Latest @claude comment is just "@claude" from Oct 31
1. ✅ Ignore all historical requests
2. Phase 1: Read recce.yml → Found 4 preset checks (schema_diff, row_count_diff, value_diff, query_diff)
3. ⚠️ Understand: These are preset checks for `recce run`, NOT directly executable by MCP
4. 🚨 PR Analysis: This PR has NO file changes (only merge commits)
5. 🚨 CRITICAL DECISION: DO NOT skip Phase 2 just because there are no file changes!
6. Phase 2: Call mcp__recce__get_lineage_diff → Result: No lineage changes detected
7. Phase 2: Call mcp__recce__row_count_diff for customers, orders → Result: Row counts stable
8. Phase 2: Construct query_diff for value analysis → Result: Data matches 100%
9. Phase 3: All MCP analyses passed, no anomalies
10. Output: "✅ All Recce analyses completed. No anomalies detected."
11. Phase 4: Check latest comment for additional requests → None
12. Done
```

**Scenario B: PR with File Changes and Anomaly Detected**
```
0. 🚨 Context Check: Latest @claude comment from Oct 31
1. Phase 1: Read recce.yml → Found 4 preset checks
2. PR Analysis: This PR modifies customers.sql and orders.sql
3. Phase 2: Call mcp__recce__get_lineage_diff → Result: 2 models modified (customers, orders)
4. Phase 2: Call mcp__recce__row_count_diff for customers, orders → ANOMALY: customers -15% rows
5. Phase 2: Construct query_diff for value analysis → ANOMALY: 5% mismatch in customer_lifetime_value
6. Phase 2: Call query_diff with recce.yml template → ANOMALY: avg revenue variance -32.1%
7. Phase 3: Multiple anomalies detected
8. Output: Full PR Validation Summary with detailed findings
9. Phase 4: Check latest comment → User asks "also check SQL performance"
10. Add "## 📎 Additional Analysis" section with SQL performance check
11. Done
```

**Scenario C: Historical Mermaid Request (Should be IGNORED)**
```
0. 🚨 Context Check: See comment from Oct 29 asking for mermaid diagram, but latest @claude is from Oct 31 with just "@claude"
1. ✅ Ignore the mermaid request from Oct 29 - it's historical!
2. Phase 1: Read recce.yml → Found 4 preset checks
3. 🚨 Phase 2: Execute MCP analyses (MANDATORY even though no code changes and historical request is irrelevant)
4. Phase 2: Call mcp__recce__get_lineage_diff, mcp__recce__row_count_diff, etc.
5. Phase 3: Determine output based on MCP results
6. Phase 4: No additional requests in latest comment
7. Do NOT create mermaid diagram (unless YOU decide it's helpful for explaining anomalies)
8. Done
```

**Scenario D: ❌ WRONG - Responding to Historical Comment (ANTI-PATTERN)**
```
❌ INCORRECT BEHAVIOR:
0. See multiple @claude comments:
   - Oct 29 08:00: "@claude create a mermaid diagram"
   - Oct 30 10:00: "@claude check security issues"
   - Oct 31 09:00: "@claude"
1. ❌ WRONG: "I see you want a mermaid diagram and security check, let me do both"
2. ❌ WRONG: Agent creates mermaid diagram (responding to Oct 29 comment)
3. ❌ WRONG: Agent performs security check (responding to Oct 30 comment)
4. ❌ WRONG: Skips Recce MCP analysis
5. ❌ RESULT: Completely wrong output, user confused

✅ CORRECT BEHAVIOR:
0. 🚨 STEP 0: Scan all comments and identify latest = Oct 31 09:00 "@claude"
1. ✅ CORRECT: Latest comment is just "@claude" with no additional instructions
2. ✅ CORRECT: Ignore Oct 29 mermaid request (historical)
3. ✅ CORRECT: Ignore Oct 30 security request (historical)
4. Phase 1: Read recce.yml
5. Phase 2: Execute MCP analyses (default workflow)
6. Phase 3: Output validation summary
7. Phase 4: No additional requests in latest comment
8. Done - correct behavior
```

**Scenario E: Multiple @claude Mentions - Find the Latest**
```
0. 🚨 STEP 0: Scan comments for ALL @claude mentions:
   - [user1 at 2025-10-29T08:00:00Z]: "@claude analyze customers"
   - [user2 at 2025-10-30T14:30:00Z]: "@claude check row counts only"
   - [claude at 2025-10-30T14:35:00Z]: "Analysis complete..." (this is bot response, IGNORE)
   - [user1 at 2025-10-31T10:00:00Z]: "@claude"

1. 🚨 STEP 0: Compare timestamps:
   - 2025-10-31T10:00:00Z is the most recent

2. ✅ Latest human @claude comment: Oct 31 10:00 "@claude" (no additional instructions)

3. ❌ Ignore Oct 29 "analyze customers" request
4. ❌ Ignore Oct 30 "check row counts only" request
5. ❌ Ignore Oct 30 claude[bot] response (not a user request)

6. ✅ Execute default workflow (Phase 1-4)
7. Done
```

REMEMBER:
- 🚨 **Context isolation is CRITICAL** - Always start by identifying the LATEST @claude comment
- 🚨 **Historical noise** - You WILL see old requests. Ignore them completely!
- 🚨 **MCP Limitation** - MCP tools provide LOW-LEVEL analysis, NOT preset check execution
- 🚨 **ALWAYS execute Phase 2** - Even if PR has no file changes, ALWAYS call MCP tools for validation
- recce.yml defines validation scope → Use MCP tools for equivalent analysis → Analyze results → Choose output format → Handle CURRENT user request
- MCP analysis is mandatory (Phase 2), current user requests are additive (Phase 4)
- Use Mermaid if YOU think it helps OR if CURRENT comment asks for it
