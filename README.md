# agent-stuff

A repository for managing skills (prompt-based plugins) for Claude Code and Codex CLI.

## Install

```bash
make install
```

Copies all skills from `skills/` into `~/.claude/skills/` and `~/.codex/skills/`.

## Skills

| Skill | Description |
|-------|-------------|
| `git-commit` | Create git commits in Conventional Commits format |
| `decrypt-office` | Decrypt password-protected Office files |

## Adding a New Skill

Create `skills/<skill-name>/SKILL.md` with YAML frontmatter (`name`, `description`) and Markdown instructions.

```
skills/
  my-new-skill/
    SKILL.md
```

Run `make install` to apply.

## Acknowledgements

This repository is inspired by [mitsuhiko/agent-stuff](https://github.com/mitsuhiko/agent-stuff). Thanks to [@mitsuhiko](https://github.com/mitsuhiko) for sharing his skills and extensions for AI agents.
