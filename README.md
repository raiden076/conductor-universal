# Conductor Skill for Claude Code

Context-driven development for Claude Code, adapted from the [Gemini CLI Conductor extension](https://github.com/gemini-cli-extensions/conductor).

## What is Conductor?

Conductor enables **Context-Driven Development**: Context → Spec & Plan → Implement.

Instead of just writing code, Conductor ensures a consistent, high-quality lifecycle:
1. **Context**: Define product, tech stack, workflow
2. **Spec & Plan**: Create detailed requirements and implementation plans
3. **Implement**: Execute tasks following the workflow (TDD, commits, verification)

## Installation

### Option 1: Project Skill (Recommended for Teams)

```bash
# In your project directory
mkdir -p .claude/skills
git clone https://github.com/yourname/conductor-skill.git .claude/skills/conductor
```

### Option 2: Personal Skill

```bash
mkdir -p ~/.claude/skills
git clone https://github.com/yourname/conductor-skill.git ~/.claude/skills/conductor
```

### Option 3: Manual Install

```bash
# Download and extract
cd /tmp
curl -L https://github.com/yourname/conductor-skill/archive/main.tar.gz | tar xz
mkdir -p ~/.claude/skills
cp -r conductor-skill-main ~/.claude/skills/conductor
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
cd ~/.claude/skills/conductor
cd upstream
git pull origin main
cd ..
# Prompts are extracted automatically if needed
```

## Source

Based on [gemini-cli-extensions/conductor](https://github.com/gemini-cli-extensions/conductor) v0.1.1, adapted for Claude Code's skill system.

## License

Apache License 2.0 (same as upstream conductor)
