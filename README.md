# Conductor Plugin for Claude Code

Context-driven development workflow for Claude Code - adapted from the [Gemini CLI Conductor extension](https://github.com/gemini-cli-extensions/conductor).

## What is Conductor?

Conductor enables **Context-Driven Development**: Context → Spec & Plan → Implement.

Instead of just writing code, Conductor ensures a consistent, high-quality lifecycle:
1. **Context**: Define product, tech stack, workflow
2. **Spec & Plan**: Create detailed requirements and implementation plans
3. **Implement**: Execute tasks following the workflow (TDD, commits, verification)

## Installation

### Via Claude Code Plugin System (Recommended)

```bash
claude plugins install https://github.com/yourname/conductor-plugin
```

### Manual Installation

```bash
# Clone to plugins directory
git clone https://github.com/yourname/conductor-plugin.git ~/.claude/plugins/conductor

# Or project-specific
mkdir -p .claude/plugins
git clone https://github.com/yourname/conductor-plugin.git .claude/plugins/conductor
```

### As Project Skill (Team Sharing)

```bash
# Add as submodule in your project
git submodule add https://github.com/yourname/conductor-plugin.git .claude/skills/conductor
```

Team members then run:
```bash
git clone --recursive
```

## Quick Start

1. **Initialize Conductor** for your project:
   ```
   Set up conductor for this project
   ```

2. **Create a track** for a feature or bug:
   ```
   Create a track for user authentication with JWT tokens
   ```

3. **Implement the track**:
   ```
   Implement the current track
   ```

4. **Check progress**:
   ```
   Show track status
   ```

## How It Works

The skill automatically detects your intent and follows the appropriate protocol:

| Your Message | What I Do |
|--------------|-----------|
| "Set up conductor" | Initialize project context, generate templates |
| "Create a track for [feature]" | Generate spec.md and plan.md |
| "Implement the track" | Execute tasks from plan.md following workflow |
| "Show status" | Display all tracks and their progress |
| "Revert the last task" | Rollback work using git history |

## Conductor Artifacts

After setup, your project will have:

```
conductor/
├── product.md              # Project vision, users, goals
├── product-guidelines.md   # Brand, style, voice standards
├── tech-stack.md           # Languages, frameworks, databases
├── workflow.md             # Development workflow (TDD, commits)
├── code_styleguides/       # Language-specific style guides
├── tracks.md               # All tracks and status
├── tracks/
│   └── <track_id>/
│       ├── spec.md         # Requirements
│       ├── plan.md         # Implementation tasks
│       └── metadata.json   # Track info
└── setup_state.json        # Resume state for setup
```

## Workflow

The default workflow (in `templates/workflow.md`) includes:

- **Test-Driven Development**: Red (failing test) → Green (minimal code) → Refactor
- **Task Tracking**: Mark tasks as `[ ]`, `[~]`, `[x]` in plan.md
- **Phase Verification**: Manual verification at end of each phase
- **Git Workflow**: Commit after each task, use git notes for summaries
- **Quality Gates**: >80% test coverage, linting, type safety

## Advantages Over Gemini CLI

- **Better File Tools**: Read, Write, Edit tools are more capable
- **Bash Execution**: Run commands directly without friction
- **TodoWrite**: Track task progress visually
- **Progressive Disclosure**: Load files only when needed
- **Context Management**: Better understanding of project state

## Commands Reference

### setup
Initialize Conductor for a new or existing project. Creates product.md, tech-stack.md, workflow.md, and selects code style guides.

### new-track
Create a new track (feature or bug) with spec.md and plan.md. Interactive questioning to gather requirements.

### implement
Execute the current track's plan. Follows workflow.md task lifecycle, updates plan.md with task status and commit SHAs.

### status
Display all tracks and their completion status. Shows tracks.md content.

### revert
Revert work by track, phase, or task. Analyzes git history to find logical units of work.

## Updating from Upstream

To sync with the latest conductor release:

```bash
cd ~/.claude/plugins/conductor
./sync.sh
```

This will:
1. Pull latest from upstream conductor repository
2. Copy updated templates
3. Extract updated prompts from TOML files
4. Create VERSION.md with sync info

## Development

### Project Structure

```
conductor-plugin/
├── plugin.json              # Plugin manifest
├── skills/
│   └── conductor/
│       ├── SKILL.md         # Main skill entry point
│       ├── commands/        # Extracted prompts from conductor
│       │   ├── setup.md
│       │   ├── new-track.md
│       │   ├── implement.md
│       │   ├── status.md
│       │   └── revert.md
│       └── templates/       # Copied from upstream conductor
│           ├── workflow.md
│           └── code_styleguides/
├── sync.sh                  # Sync script
└── CLAUDE.md                # Developer documentation
```

### Testing Changes

1. Install locally: `cp -r conductor-plugin ~/.claude/plugins/conductor`
2. Test in a sample project directory
3. Verify skill activates correctly

## Source

Based on [gemini-cli-extensions/conductor](https://github.com/gemini-cli-extensions/conductor) v0.1.1.

## License

Apache License 2.0 (same as upstream conductor)

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

For significant changes, please open an issue first to discuss.
