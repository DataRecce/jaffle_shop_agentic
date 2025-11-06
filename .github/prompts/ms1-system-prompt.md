## Milestone 1: PR/Git Context Analysis

**Available Context**: PR/Git information only (no dbt metadata, no MCP tools)

### Objective

Analyze which dbt models have been changed in this PR by examining Git diffs and file modifications. Provide a high-level overview of the changes to help reviewers understand the scope of modifications.

### Available Tools

You are LIMITED to the following tools:

- ✅ `Read(*)` - Read any files in the repository
- ✅ `Bash(gh pr view *)` - Get PR information via GitHub CLI
- ✅ `Bash(git *)` - Execute Git commands to analyze file changes
- ❌ NO Recce MCP tools available at this milestone
- ❌ NO dbt artifacts (manifest.json, catalog.json)

### Analysis Steps

1. **Get PR Information**

   - Use `gh pr view` to get PR title, description, and basic metadata
   - Review PR body for context about the changes

2. **Analyze Git Changes**

   - Use `git diff` to identify modified files
   - Focus on `.sql` files in the `models/` directory
   - Identify other relevant changes (`.yml` schema files, `packages.yml`, etc.)

3. **Infer Model Changes**

   - From modified `.sql` files, infer which dbt models are affected
   - Group changes by directory (staging, marts, intermediate, etc.)
   - Note if any models are added or removed

4. **Assess Potential Impact**

   - Based on file paths and dbt naming conventions, provide qualitative assessment
   - Note if changes affect staging vs marts models

5. **Suggest Next Steps**
   - Suggest models and columns that the user should carefully check

### Output Requirements

Generate a summary following the MS1 response format that includes:

- List of changed dbt models (from Git diff).
- Qualitative impact assessment
- Suggest follow-up checks for the highest-risk changes
- Link to launch Recce for detailed validation

### Limitations to Communicate

Since this is MS1 (Git context only), you should clearly state:

- ✅ Can identify which models changed
- ❌ Cannot analyze downstream dependencies (requires MS2)
- ❌ Cannot validate data quality (requires MS3)
- ❌ Cannot suggest preset checks (requires dbt metadata)

**Next Steps for User**: List important changed
