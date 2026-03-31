# How to Use the Claude/VSCode Template

This project template is designed to give you a quick way to start a new project with a template designed to integrate easily and powerfully with Claude Code. Let's get started! 

## Create your new project

1. **Copy:** Start by copying the _Template folder to wherever you keep your work projects *(we will refer to this folder as your **Work** folder)* - rename the copied folder to a short, identifiable project name *(**Important:** this name will be used as your Claude window title and session name. We will refer to this copied folder as the **Project** folder)*.

2. **Open the workspace** — double-click `project.code-workspace`. Claude Code will launch automatically.

3. **Run the quick-start workflow** — once Claude is running, say:

   > *"Read quick-start.md and follow it"*

   Claude will ask you a few questions and configure `CLAUDE.md` and your first milestone file automatically.

> :sunglasses: Prefer to set things up yourself? See [Manual Project Setup](#manual-project-setup) at the bottom of this guide.

4. **Close** — close Claude and all VSCode windows so the next open picks up the updated `CLAUDE.md`.

##### ...Project setup complete

---

## Using your project

### Opening the workspace

> :round_pushpin: If you had VSCode open to do the editing of the project files, close all project windows before continuing

Open the project by double-clicking `project.code-workspace` (or `File > Open Workspace from File...` in VSCode). 

#### Auto-launching Claude Code

When the workspace opens, VSCode automatically runs the **Start Claude** task (defined in `.vscode/tasks.json`). This opens a new terminal running `claude --continue`, using `~/.claude/start-claude.ps1` to restore your prior session. The workspace also sets the Claude window's working directory to the project root and sets its window title to the folder name (this way having multiple projects open at once won't be confusing - there won't be 4 'Claude Code' terminal windows).

> :round_pushpin: On first open, VSCode may prompt you to allow automatic task execution. Click **Allow** (or set `task.allowAutomaticTasks` to `on` in your VSCode user settings).

#### On Claude Startup
- When starting a session, Claude will read `CLAUDE.md` automatically and pick up the active milestone and current status.
- You can tell Claude: *"Continue with the active milestone"* and it will orient itself from the project files without further prompting.
- As your work progresses, add new tasks and new milestones by telling Claude what you want to add. It will create new files, table entries and keep everything in sync.

#### Auto memory

The global `~/.claude/CLAUDE.md` installed by this template enables **auto memory** — Claude will automatically save notes (build commands, debugging insights, discovered preferences) to `~/.claude/projects/<project>/memory/MEMORY.md` and persist them across sessions. You can view, edit, or clear these notes at any time by running `/memory` inside a Claude session. See [Auto memory](https://code.claude.com/docs/en/memory#auto-memory) for full details on how it works and how to disable it if needed.

> :wine_glass: Between the project CLAUDE.md, auto memory, and starting with --continue, **CC** becomes very good at resuming work after you've closed your project and restart at a later time.

#### Adding related folders

When you want your project to use another folder (whether it's a folder of code, of seed files, any other set of useful files), you don't need to copy them into the project (unless you want to - maybe you want to change the file without affecting the original). 

> :sunglasses: Use the VSCode `Add folder to workspace` command to bring the existing folder into view of your project

When you instruct Claude to refer to a file inside the newly added folder, you can say something like `...use myFile from myFolder that was added to the workspace...` and Claude will know where to find your file.

#### Useful conventions

| Subfolder | Purpose |
|-----------|---------|
| `links/`  | `.url` shortcut files to related web pages |
| `assets/` | Images, data files (excluded from Claude by default) |
| `docs/`   | Reference material, specs, research |

---

## More Usage Tips

### CLAUDE.md Tips

- Keep it **short** and **scannable** — dense prose is less useful than bullets for Claude context.
- Keep it purely operational content for Claude — no inline commentary, no personal notes.
- Refer to [How Claude remembers your project](https://code.claude.com/docs/en/memory#claudemd-files) for additional guidance on writing effective instructions

### Global Configuration

- Global `CLAUDE.md` at `~/.claude/CLAUDE.md` contains directives that apply to all sessions (e.g., auto memory, coding conventions).
- Global MCP servers are defined in `~/.claude.json` (near the bottom).
> :radioactive: But be careful, within the `.claude.json` file are **multiple** `mcpServers` sections - All but 1 are within a section starting with the full path to a project - **normally, you don't want those** - you'll add your MCP servers at the User level (the one mcpServers section **not** inside a project section)

### Atlassian MCP Tips

- When creating Jira stories via Claude, you can set: Summary, Description, Assignee, Priority, Labels, Components, Issue Type.
- Modifying existing stories is limited — you can only add Comments (the MCP cannot delete).
- Craft new Jira stories carefully using Claude, then manage them in the Jira web UI.

### .claudeignore Tips

- For this project structure, `*.code-workspace` is excluded from Claude context (along with common noise like build artifacts, binaries, and OS files).
- Claude honors `.gitignore` by default, so:
  - Non-Claude files **in git** → put in `.claudeignore`
  - Non-Claude files **not in git** → put in `.gitignore`

### Keeping your template up to date

When a new version of the Claude Project Template is released, run the upgrade workflow to apply changes to your global files and all existing projects:

1. Pull the latest repo (`git pull` in your `claude-project-template` folder)
2. Launch Claude from any directory
3. Say: *"Read `/path/to/claude-project-template/setup.md` and follow it"*

The workflow is idempotent — safe to re-run at any time. See [setup.md](setup.md) for details on what each upgrade checks and updates.

---

### Activity History and Status Reports

Each project maintains a `history/` folder where Claude records completed tasks and milestones. This history powers the `/status-report` skill, which generates weekly or monthly reports from your project activity. See [skills-guide.md](skills-guide.md) for details.

---

## Manual Project Setup

If you prefer to configure your project files by hand instead of using `quick-start.md`, follow these steps.

### Edit `CLAUDE.md` in the Project folder

1. **Set attributes**
   - **Project** — set the project name at the top.
   - **Default Jira Project** — if you intend to have Claude interact with Jira, set the Jira project to use.
   - **Scope** — if there are specific topics to include or exclude from Claude's context, add them to the appropriate sub-section. Otherwise, clear these items.

2. **Define Milestones and Tasks**

   This template allows for multiple phases or milestones. Each milestone has its own list of tasks. The idea is that you work on one milestone at a time — this keeps information for other milestones out of context until needed.

   > :sunglasses: Just define enough to get started (at least 1 milestone) — Claude can add milestones and tasks, adjust goals, add questions and decisions, etc. Just ask!

   **Update the milestone table — for each milestone:**
   - Set the milestone name
   - Set the milestone status: no fixed rules, but typically (`Not Started` → `Planning` → `In Progress` → `Complete`)
   - Set the Markdown URL using a short abbreviation in the form `[milestone1-xxx](milestone1-xxx.md)`

### Edit the `milestoneN-xxx.md` files

For each milestone:

1. **Rename** `milestoneN-xxx.md` to match your milestone's filename (as defined above)
2. **Edit the milestone file**
   - Set the milestone name at the top to match the `CLAUDE.md` milestone table
   - Specify the milestone goal and business value
   - *(optional)* List any **Key Decisions** that are finalized — helps prevent Claude from re-analyzing settled questions
   - *(optional)* List any **Open Questions** — helps Claude suggest next steps and areas to research
   - *(optional)* Provide links to related background information
   - Include a list of tasks: use the `- [ ] **Name** — description` format for each. To associate a task with its own Jira story, append `| Jira: IDS-12345` to the task line.
