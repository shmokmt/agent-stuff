SKILLS_DIR := skills
CLAUDE_DEST := $(HOME)/.claude/skills
CODEX_DEST := $(HOME)/.codex/skills
SKILLS := $(wildcard $(SKILLS_DIR)/*)

.PHONY: install

install:
	@mkdir -p $(CLAUDE_DEST) $(CODEX_DEST)
	@for skill in $(SKILLS); do \
		name=$$(basename $$skill); \
		echo "Installing $$name..."; \
		rm -rf $(CLAUDE_DEST)/$$name; \
		cp -r $$skill $(CLAUDE_DEST)/$$name; \
		rm -rf $(CODEX_DEST)/$$name; \
		cp -r $$skill $(CODEX_DEST)/$$name; \
	done
	@echo "Done."
