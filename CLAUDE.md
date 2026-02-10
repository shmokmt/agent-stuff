# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository manages reusable **skills** (prompt-based plugins) for Claude Code and Codex CLI. Skills are stored in `skills/` as directories containing a `SKILL.md` file.

## Install Skills

```
make install
```

This copies all skill directories from `skills/` into `~/.claude/skills/` and `~/.codex/skills/`.

## Adding a New Skill

Create a new directory under `skills/<skill-name>/` with a `SKILL.md` file. The SKILL.md must have YAML frontmatter (`name`, `description`, optionally `version`) followed by Markdown instructions.

## Git Commit Convention

Use Conventional Commits format: `<type>(<scope>): <summary>` (see `skills/git-commit/SKILL.md`). Do not push after committing. Do not add sign-offs or breaking-change footers.
