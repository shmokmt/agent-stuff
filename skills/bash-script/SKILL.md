---
name: bash-script
description: "Write bash scripts following best practices for safety, portability, and maintainability. Use when creating new shell scripts or refactoring existing ones."
---

# Bash Script

Write robust, portable, and maintainable bash scripts by applying a standard template, coding conventions, security rules, and portability guidelines.

## Steps

1. Clarify the script's purpose, target platform(s) (Linux-only, macOS-only, or both), and whether strict POSIX `sh` compatibility is required.
2. Copy the **Script Template** below and remove sections that are not needed (e.g., drop `getopts` if the script takes no arguments). Keep it minimal.
3. Implement the logic following the **Coding Conventions** and **Security Rules** sections.
4. If the script must run on both macOS and Linux, review the **Portability** section and apply the relevant workarounds.
5. Run `shellcheck <script>` (if available) and fix every warning. Explain each fix to the user.
6. Add a brief comment block at the top of the script (after the shebang) describing what it does.

## Script Template

```bash
#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cleanup() {
  # Remove temp files, restore state, etc.
  :
}
trap cleanup EXIT

usage() {
  cat <<EOF
Usage: ${SCRIPT_NAME} [options] <args>

Description of what this script does.

Options:
  -h    Show this help message
  -v    Enable verbose output
EOF
}

log() {
  printf '%s: %s\n' "${SCRIPT_NAME}" "$*" >&2
}

die() {
  log "error: $*"
  exit 1
}

main() {
  local verbose=0

  while getopts ":hv" opt; do
    case "${opt}" in
      h) usage; exit 0 ;;
      v) verbose=1 ;;
      :) die "option -${OPTARG} requires an argument" ;;
      *) die "unknown option -${OPTARG}" ;;
    esac
  done
  shift $((OPTIND - 1))

  # --- script logic starts here ---
}

main "$@"
```

## Coding Conventions

- **Variable names**: `snake_case` for locals, `UPPER_SNAKE_CASE` for constants and environment variables.
- **Quoting**: Always double-quote variable expansions and command substitutions — `"$var"`, `"$@"`, `"$(cmd)"`. Unquoted expansions are acceptable only inside `[[ ]]` on the right side of `=~` or `==` with intentional globbing.
- **Function definitions**: Use `fname() { }` form. Do not use the `function` keyword.
- **Conditionals**: Prefer `[[ ]]` over `[ ]`. Use `(( ))` for arithmetic.
- **Command substitution**: Use `$(command)`, never backticks.
- **Local variables**: Declare with `local` inside functions. Separate declaration from assignment when capturing exit codes: `local output; output="$(cmd)"`.
- **Comments**: Only for non-obvious logic. Do not add trivial comments.
- **Indentation**: 2 spaces, no tabs.

## Security Rules

- **No `eval`**: Do not use `eval`. If absolutely unavoidable, add a comment explaining why and what input has been validated.
- **Temporary files**: Always create with `mktemp`. Clean up in a `trap cleanup EXIT` handler. Never use predictable paths like `/tmp/myscript.tmp`.
- **Input validation**: Validate user-supplied arguments before use. Reject unexpected characters with pattern matching.
- **Guard `rm -rf`**: Never write `rm -rf "$dir"` without first verifying that `$dir` is non-empty and expected. Prefer `rm -rf "${dir:?}"` to abort on unset variables.
- **Avoid piping untrusted URLs to shell**: Do not use `curl ... | bash` patterns. Download first, inspect, then execute.
- **Privilege checks**: If the script requires root or specific permissions, check early and fail fast with a clear error message.

## Portability

When the script must work on both macOS and Linux, watch for these common incompatibilities:

| Area | macOS (BSD) | Linux (GNU) | Workaround |
|---|---|---|---|
| `sed` in-place | `sed -i '' 's/.../g'` | `sed -i 's/.../g'` | Use `sed -i.bak ... && rm *.bak`, or detect OS |
| `date` relative | No `-d` flag | `date -d '1 day ago'` | Use `date -v-1d` on macOS or `perl`/`python` |
| `readlink -f` | Not supported | Works | Use `cd "$(dirname "$0")" && pwd` pattern instead |
| `grep -P` (PCRE) | Not supported | Works | Use `grep -E` or `awk` |
| `mktemp` template | `mktemp -t prefix` | `mktemp prefix.XXXXXX` | Use `mktemp "${TMPDIR:-/tmp}/prefix.XXXXXX"` |
| `xargs -r` | Not supported | Skips empty input | Pipe through `grep .` before `xargs`, or check input |

If strict POSIX `sh` compatibility is required, additionally avoid: `[[ ]]`, arrays, `local` (non-POSIX but widely supported), process substitution `<()`, and `{a..z}` brace expansion.

## Notes

- Remove unused template sections. A 10-line script does not need `getopts` or `usage`.
- When modifying an existing script, follow the existing style rather than imposing the template.
- When the user says "shell script" without specifying a shell, default to bash.
- When fixing ShellCheck warnings, explain the reason to the user, not just the fix.

## References

- [GNU Bash Reference Manual](https://www.gnu.org/software/bash/manual/bash.html)
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [ShellCheck](https://www.shellcheck.net/)
- [Greg's Wiki — BashPitfalls](https://mywiki.wooledge.org/BashPitfalls)
- [Greg's Wiki — BashFAQ](https://mywiki.wooledge.org/BashFAQ)
- [Greg's Wiki — BashGuide](https://mywiki.wooledge.org/FullBashGuide)
