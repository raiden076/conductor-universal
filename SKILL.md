---
name: conductor
description: Conductor context-driven development for Claude Code. Use when: setting up a new project, planning features/bugs, implementing specs, checking track status, or reverting work. Creates product.md, tech-stack.md, workflow.md and manages tracks with spec.md and plan.md. Follows Context → Spec & Plan → Implement workflow.
---

# Conductor for Claude Code

Conductor enables **Context-Driven Development**: Context → Spec & Plan → Implement.

This skill adapts the [Gemini CLI Conductor extension](https://github.com/gemini-cli-extensions/conductor) for Claude Code, using the exact same prompts and workflow.

## How This Works

1. I detect your intent from your message
2. Load and follow the appropriate command protocol
3. Execute tasks using Claude Code's tools (Read, Write, Bash, TodoWrite)

## Commands

| Command | When to Use | Protocol |
|---------|-------------|----------|
| **setup** | "Set up conductor", "Initialize project", "Start with conductor" | [setup.md](commands/setup.md) |
| **new-track** | "Create a track for [feature]", "Plan [feature]", "New track" | [new-track.md](commands/new-track.md) |
| **implement** | "Implement the track", "Execute the plan", "Start implementation" | [implement.md](commands/implement.md) |
| **status** | "Show status", "Track progress", "What's the current state?" | [status.md](commands/status.md) |
| **revert** | "Revert the track", "Undo last task", "Rollback changes" | [revert.md](commands/revert.md) |

## Intent Detection

I analyze your message to determine which command you want:

- **Setup**: "set up", "initialize", "start with conductor" + project context
- **New Track**: "create", "plan", "new track" + feature/bug description
- **Implement**: "implement", "execute", "start working", "do the plan"
- **Status**: "status", "progress", "show tracks", "what's pending"
- **Revert**: "revert", "undo", "rollback" + track/task/phase

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
- **Claude Code Advantages**: Better file tools, bash execution, TodoWrite for task tracking
- **Project Scope**: Creates `conductor/` directory in your project root

## Source

Based on [gemini-cli-extensions/conductor](https://github.com/gemini-cli-extensions/conductor), adapted for Claude Code's skill system.
