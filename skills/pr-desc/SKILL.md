---
name: pr-desc
description: "Generate a PR description following a Markdown template. Use when creating a PR, writing a PR description, or generating PR summary. When an existing PR description already follows the template, review it for drift from actual changes."
---

# PR Description

Analyze the current branch changes and generate a PR description following the template below.

## Steps

1. Run `gh repo view --json visibility --jq '.visibility'` to determine the output language (PUBLIC → English, PRIVATE → Japanese).
2. If a PR number or URL is provided as an argument, fetch the existing description with `gh pr view <PR> --json body,title,number`.
3. Run `git log main..HEAD --oneline` and `git diff main...HEAD --stat` to get an overview of changes.
4. If needed, run `git diff main...HEAD` for detailed diffs.
5. **If an existing description follows the template** → enter drift check mode (see below).
6. **If no existing description or it does not follow the template** → generate a new description using the template.
7. If an issue number is provided as an argument, include it in the Related Issue section.

## Drift Check Mode

When an existing PR description follows the template, review it instead of generating a new one.

1. Compare each section (Summary, Changes, Testing, Impact, Review Points) against the actual diff.
2. Flag any discrepancies and propose corrections. Common drifts:
   - Summary does not match the actual changes
   - Changes section has missing or extra items
   - Impact section is incomplete or overstated
3. If no drift is found, report "No issues found."
4. If drift is found, present the corrected full description to the user and ask for confirmation before updating.
5. Once the user approves, update with `gh pr edit <PR number> --body "..."`.

## Template

```markdown
## Summary
<!-- Describe the purpose of this change in 1-2 lines -->

## Related Issue
<!-- Fixes #123 or Closes #123 -->

## Changes
<!-- List specific changes -->

## Testing
- [ ] Unit tests
- [ ] Integration tests
- [ ] Manual testing

## Impact
<!-- Describe the scope of impact -->

## Docs
<!-- Links to official documentation relevant to the changes -->

## Review Points
<!-- Highlight areas that need careful review -->
```

## Notes

- Output language depends on repository visibility (PUBLIC → English, PRIVATE → Japanese).
- Docs section: If the changes involve libraries, APIs, or frameworks, include links to the relevant official documentation. Omit if not applicable.
- Testing, Impact, and Review Points sections are optional. Omit them if not applicable.
- Output raw Markdown without wrapping in a code block.
