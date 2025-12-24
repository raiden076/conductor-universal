---
name: conductor
description: Context-driven development workflow. Use when: "set up conductor", "create a track", "new track", "implement the plan", "track status", "what's pending", "spec and plan", "conductor status". Manages product.md, tech-stack.md, workflow.md, tracks, specs, plans. Follows Context → Spec & Plan → Implement methodology with TDD, task tracking, and phase verification.
---

# Conductor for Claude Code

Conductor enables **Context-Driven Development**: Context → Spec & Plan → Implement.

This skill adapts the [Gemini CLI Conductor extension](https://github.com/gemini-cli-extensions/conductor) for Claude Code, using the exact same prompts and workflow.

## Version History

- **v0.1.1** (2024-12-24): Initial Claude Code plugin release, based on conductor v0.1.1
- Upstream repository: https://github.com/gemini-cli-extensions/conductor

## How This Works

1. I detect your intent from your message
2. Load and follow the appropriate command protocol
3. Execute tasks using Claude Code's tools (Read, Write, Bash, TodoWrite)

## Commands

| Command | Trigger Phrases | Protocol |
|---------|----------------|----------|
| **setup** | "set up conductor", "initialize project", "start with conductor", "conductor setup" | [setup.md](commands/setup.md) |
| **new-track** | "create a track", "new track", "plan feature", "create spec", "track for [feature]" | [new-track.md](commands/new-track.md) |
| **implement** | "implement the track", "execute the plan", "start implementation", "do the plan", "work on track" | [implement.md](commands/implement.md) |
| **status** | "show status", "track progress", "what's pending", "what's the current state", "conductor status" | [status.md](commands/status.md) |
| **revert** | "revert the track", "undo last task", "rollback changes", "revert work" | [revert.md](commands/revert.md) |

## Intent Detection

I analyze your message to determine which command you want:

**Setup**: "set up conductor", "initialize project", "start with conductor" + project context
**New Track**: "create", "plan", "new track", "track for" + feature/bug description
**Implement**: "implement", "execute", "start working", "do the plan"
**Status**: "status", "progress", "show tracks", "what's pending"
**Revert**: "revert", "undo", "rollback" + track/task/phase

## The Protocol

When a command is triggered, I:
1. Read the full protocol from the corresponding `.md` file in `commands/`
2. Follow it exactly as written (copied verbatim from conductor)
3. Use TodoWrite to track task progress
4. Execute bash commands, read/write files as needed
5. Update track status and plan.md as tasks complete

## Conductor Artifacts

The skill creates/manages these files in your `conductor/` directory:

```
conductor/
├── product.md              # Project vision, goals, users
├── product-guidelines.md   # Brand, style, communication standards
├── tech-stack.md           # Languages, frameworks, databases
├── workflow.md             # Development workflow (TDD, commits, etc.)
├── code_styleguides/       # Language-specific style guides
├── tracks.md               # All tracks and their status
├── tracks/
│   └── <track_id>/
│       ├── spec.md         # Detailed requirements
│       ├── plan.md         # Phases, tasks, sub-tasks
│       └── metadata.json   # Track metadata
└── setup_state.json        # Resume state for setup
```

## Example Usage

```
You: "Set up conductor for my web API project"
→ I follow [setup.md](commands/setup.md) protocol

You: "Create a track for user authentication with JWT"
→ I follow [new-track.md](commands/new-track.md) to generate spec and plan

You: "Implement the current track"
→ I follow [implement.md](commands/implement.md) to execute tasks

You: "What's the status?"
→ I follow [status.md](commands/status.md) to show progress
```

## Workflow Template

The default workflow is in [templates/workflow.md](templates/workflow.md). It defines:
- Task lifecycle (Red-Green-Refactor TDD)
- Phase completion verification
- Git commit conventions
- Quality gates

## Code Style Guides

Language-specific guides are in `templates/code_styleguides/`:
- `python.md`
- `typescript.md`
- `javascript.md`
- `go.md`
- `dart.md`
- `html-css.md`
- `general.md`

## Notes

- **Model-Invoked**: I automatically use this skill when I detect you want context-driven development
- **Exact Protocols**: Command files contain the exact prompts from conductor, just formatted as markdown
- **No External Dependencies**: Uses Claude Code built-in tools (Read, Write, Bash, TodoWrite)
- **Project Scope**: Creates `conductor/` directory in your project root
- **Progressive Disclosure**: Loads command files only when needed for efficient context management

## Source

Based on [gemini-cli-extensions/conductor](https://github.com/gemini-cli-extensions/conductor) v0.1.1, adapted for Claude Code's skill system.

## License

Apache License 2.0 (same as upstream conductor)
