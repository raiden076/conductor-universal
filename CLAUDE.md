# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is the **Conductor Skill** for Claude Code - an adaptation of the [Gemini CLI Conductor extension](https://github.com/gemini-cli-extensions/conductor) for context-driven development. The skill enables the workflow: Context → Spec & Plan → Implement.

## Architecture

The skill has a single entry point (`SKILL.md`) that detects user intent and routes to the appropriate command protocol:

```
SKILL.md (router)
    ↓ (intent detection)
    ├── setup.md        - Initialize Conductor for a project
    ├── new-track.md    - Create spec.md and plan.md for features/bugs
    ├── implement.md    - Execute tasks from plan.md
    ├── status.md       - Show track progress
    └── revert.md       - Revert work by track/phase/task
```

**Key Design Decisions:**
- **Single skill with routing** - Claude detects intent from user messages and loads the appropriate command
- **Verbatim prompts** - `commands/*.md` contain exact prompts extracted from upstream conductor TOML files
- **Template separation** - `templates/` contains workflow.md and code_styleguides/ copied verbatim from upstream
- **Upstream tracking** - `upstream/` directory holds a clone of the original conductor repository for syncing

## Commands

| Command | Purpose | File |
|---------|---------|------|
| `setup` | Initialize project context (product.md, tech-stack.md, workflow.md) | commands/setup.md |
| `new-track` | Create spec.md and plan.md for a feature/bug | commands/new-track.md |
| `implement` | Execute the current track's plan following workflow.md | commands/implement.md |
| `status` | Display all tracks and their status | commands/status.md |
| `revert` | Revert work by track/phase/task using git history | commands/revert.md |

## Syncing with Upstream

When conductor releases updates, run the sync script:

```bash
./sync.sh
```

This script:
1. Pulls latest from `https://github.com/gemini-cli-extensions/conductor` into `upstream/`
2. Copies updated templates from `upstream/templates/` to `templates/`
3. Extracts prompts from `upstream/commands/conductor/*.toml` to `commands/*.md` using `sed`
4. Creates `VERSION.md` with commit hash and sync date

The sed extraction pattern:
```bash
cat file.toml | sed -n '/^prompt = """/,/^"""/p' | sed '1d;$d' > output.md
```

## File Structure

```
conductor-skill/
├── SKILL.md                  # Main skill entry point (router)
├── README.md                 # User-facing documentation
├── sync.sh                   # Sync script for upstream updates
├── commands/                 # Extracted prompts from conductor TOML files
│   ├── setup.md
│   ├── new-track.md
│   ├── implement.md
│   ├── status.md
│   └── revert.md
├── templates/                # Copied verbatim from upstream/conductor
│   ├── workflow.md           # Development workflow (TDD, commits, etc.)
│   └── code_styleguides/     # Language-specific style guides
│       ├── python.md
│       ├── typescript.md
│       ├── javascript.md
│       ├── go.md
│       ├── dart.md
│       ├── html-css.md
│       └── general.md
└── upstream/                 # Git clone of conductor repository
```

## How the Skill Works

1. User sends message like "Set up conductor" or "Create a track for auth"
2. Claude detects intent from the message
3. Loads and reads the appropriate command file from `commands/`
4. Follows the protocol exactly (step-by-step instructions copied from upstream)
5. Uses Claude Code tools (Read, Write, Bash, TodoWrite) to execute
6. Creates/manages `conductor/` directory with project artifacts

## Adaptations from Gemini CLI

The prompts are copied verbatim, but the skill leverages Claude Code capabilities:
- **TodoWrite tool** - Used for task tracking during implement
- **File tools** - Read, Write, Edit for working with plan.md, spec.md
- **Bash tool** - Direct command execution for git, tests, etc.
- **Model invocation** - Skill auto-activates based on description matching

## Installation

Users install via:
1. **Project skill**: `.claude/skills/conductor/` (committed to git)
2. **Personal skill**: `~/.claude/skills/conductor/` (personal workflows)

The skill description is critical for Claude to discover it: includes "Context → Spec & Plan → Implement" and mentions tracks, specs, plans.

## Testing Changes

After syncing or making changes:
1. Install locally: `cp -r conductor-skill ~/.claude/skills/conductor`
2. Test in a sample project directory with commands like "Set up conductor"
3. Verify all command files load correctly and protocols are followed
