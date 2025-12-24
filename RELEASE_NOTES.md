# Release Notes

## [0.1.1] - 2024-12-24

### Initial Release for Claude Code

**Based on**: [gemini-cli-extensions/conductor](https://github.com/gemini-cli-extensions/conductor) v0.1.1

#### Features

- **Complete Conductor workflow** adapted for Claude Code
  - Context-driven development: Context → Spec & Plan → Implement
  - All 5 commands: setup, new-track, implement, status, revert
  - Exact prompts copied from upstream conductor

- **Plugin distribution**
  - Proper plugin.json manifest for Claude Code plugin system
  - Install via: `claude plugins install https://github.com/yourname/conductor-plugin`
  - Also supports manual installation and project skill usage

- **Enhanced for Claude Code**
  - Better description with trigger phrases for auto-detection
  - TodoWrite integration for task tracking
  - Progressive file loading for efficiency
  - No external dependencies (uses built-in tools)

- **Developer experience**
  - Sync script (`./sync.sh`) for upstream updates
  - Comprehensive documentation (README.md, CLAUDE.md)
  - Version history tracking
  - .gitignore for clean repository

#### Included from Upstream

- `templates/workflow.md` - Complete development workflow protocol
- `templates/code_styleguides/` - Language-specific style guides
  - Python, TypeScript, JavaScript, Go, Dart, HTML/CSS, General
- Command prompts extracted from all 5 TOML files

#### Installation

```bash
# Via Claude Code plugin system (recommended)
claude plugins install https://github.com/yourname/conductor-plugin

# Manual installation
git clone https://github.com/yourname/conductor-plugin.git ~/.claude/plugins/conductor

# As project skill (for teams)
git submodule add https://github.com/yourname/conductor-plugin.git .claude/skills/conductor
```

#### Usage

```bash
# In any project directory
claude
> Set up conductor for this project
> Create a track for user authentication
> Implement the current track
> Show track status
```

#### Known Differences from Gemini CLI Version

- **Skill invocation**: Claude detects intent vs explicit `/conductor:setup` commands
- **Tool differences**: Uses Claude Code's tools (Read, Write, Bash, TodoWrite)
- **Progress tracking**: Visual TodoWrite vs terminal output
- **File operations**: More capable built-in file tools

#### License

Apache License 2.0 (same as upstream conductor)

#### Acknowledgments

- Original Conductor: [gemini-cli-extensions/conductor](https://github.com/gemini-cli-extensions/conductor)
- Inspired by: [obra/superpowers](https://github.com/obra/superpowers) for skill structure patterns
