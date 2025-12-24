# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is the **Conductor Plugin** for Claude Code - a plugin that distributes a skill adapting the [Gemini CLI Conductor extension](https://github.com/gemini-cli-extensions/conductor) for context-driven development.

## Plugin Structure

```
conductor-plugin/
├── plugin.json              # Plugin manifest (name, version, skills list)
├── skills/
│   └── conductor/
│       ├── SKILL.md         # Main skill entry point with intent detection
│       ├── commands/        # Protocols extracted from upstream conductor TOML
│       │   ├── setup.md
│       │   ├── new-track.md
│       │   ├── implement.md
│       │   ├── status.md
│       │   └── revert.md
│       └── templates/       # Copied verbatim from upstream/conductor
│           ├── workflow.md
│           └── code_styleguides/
├── sync.sh                  # Sync script to update from upstream
└── CLAUDE.md                # This file
```

## How the Plugin Works

The plugin contains a single skill (`conductor`) that:

1. **Detects user intent** from natural language messages
2. **Routes to appropriate command** protocol (setup, new-track, implement, status, revert)
3. **Loads protocol markdown** from `commands/*.md` files progressively
4. **Follows exact prompts** copied from upstream conductor
5. **Uses Claude Code tools**: Read, Write, Bash, TodoWrite

## Key Design Decisions

- **Single skill with routing** - One skill detects intent and routes internally rather than 5 separate skills
- **Verbatim prompts** - `commands/*.md` are exact extractions from upstream TOML files
- **Template separation** - `templates/` copied from upstream for updates
- **Progressive disclosure** - Command files load only when needed

## Syncing with Upstream

The `sync.sh` script:

1. Clones/updates `https://github.com/gemini-cli-extensions/conductor` (currently not tracked in this repo)
2. Copies `templates/workflow.md` and `code_styleguides/`
3. Extracts prompts from `commands/conductor/*.toml` using:
   ```bash
   cat file.toml | sed -n '/^prompt = """/,/^"""/p' | sed '1d;$d' > output.md
   ```
4. Creates `VERSION.md` with upstream commit hash

To run sync:
```bash
./sync.sh
```

## Command File Extraction

Each `.md` file in `commands/` is extracted from upstream TOML:

| Command | TOML Source | Output File |
|---------|-------------|-------------|
| setup | `commands/conductor/setup.toml` | `commands/setup.md` |
| new-track | `commands/conductor/newTrack.toml` | `commands/new-track.md` |
| implement | `commands/conductor/implement.toml` | `commands/implement.md` |
| status | `commands/conductor/status.toml` | `commands/status.md` |
| revert | `commands/conductor/revert.toml` | `commands/revert.md` |

The `newTrack` → `new-track` conversion is handled in sync.sh.

## Plugin Manifest

`plugin.json` defines:
- Plugin metadata (name, version, description)
- Skills included (`["conductor"]`)
- Minimum Claude Code version
- Categories and keywords for discovery

## Distribution Methods

1. **Plugin installation** (primary): `claude plugins install https://github.com/...`
2. **Manual clone**: Clone to `~/.claude/plugins/conductor/`
3. **Project skill**: Add as submodule to `.claude/skills/conductor/`

## Testing Changes

After making changes:
1. Build/install locally: `cp -r conductor-plugin ~/.claude/plugins/conductor`
2. Create test directory: `mkdir /tmp/test-conductor && cd $_`
3. Test commands: "Set up conductor", "Create a track", "Show status"
4. Verify skill activates and follows protocols correctly

## Version Tracking

- This plugin version: tracked in `plugin.json` `version` field
- Upstream conductor version: tracked in `SKILL.md` version history
- Sync history: in `VERSION.md` (created by sync.sh)

Current versions:
- Plugin: 0.1.1
- Based on: conductor v0.1.1
