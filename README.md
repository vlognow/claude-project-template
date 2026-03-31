# Claude/VSCode Project Template

## Overview

The idea of this project template is to get you using [Claude Code](https://claude.ai/code) (**CC**) for all your work. The strategy employed here is that you have a main Tasks or Projects folder somewhere in your computer. Inside that folder would be one folder per project you are working on. Each project folder would contain all the files (or links to them) that you need to do your work. [VSCode](https://code.visualstudio.com/) is a nice IDE (Integrated Development Environment) that opens on your folder and lets you view and work with your project files. And you'll have a Claude Code terminal window that opens (focused on the same project folder) that can help you do your work. *(The **CC** windows will be titled with the name of your project folder so you can work on multiple projects simultaneously without being confused by multiple windows with the same '**Claude Code**' title.)*

> :warning: If you don't like VSCode or prefer another IDE, this project may not be of much use to you! :anguished: (A few ideas here and there, maybe.)

### Components:

- **Global files** (`files/`) — a `CLAUDE.md` with your personal preferences, a helper PowerShell script (Windows only), and skills — all installed to `~/.claude/`.
- **Project template** (`_Template/`) — a ready-to-copy project folder pre-configured with a VSCode workspace, Claude settings, milestone tracking, and `.claudeignore`.
- **Skills** — slash commands that extend Claude Code with reusable workflows.

---

## Installation

Installation is handled by `setup.md` — a guided workflow that Claude executes for you.

### Step 1 — Download the latest release

Go to the [Releases page](https://github.com/vlognow/claude-project-template/releases), download the latest `CPT-vX.X.X.zip` asset, and unzip it to a convenient location on your computer.

### Step 2 — Run the setup workflow

Launch Claude from any directory and say:

> *"Read /path/to/claude-project-template/setup.md and follow it"*

Claude will detect that this is a fresh install, ask for your name, email, Projects folder path, and Reports folder path, then set everything up automatically — including copying `~/.claude/CLAUDE.md`, installing the status-report skill, and copying `_Template/` to your Projects folder.

> After setup, fill in your Jira credentials in `~/.claude/CLAUDE.md` under the `## Jira` section:
> - **Machinify Jira** (`mcp__atlassian__` tools): Set your account ID. To find it, navigate to `https://machinify.atlassian.net/rest/api/latest/myself` — your `accountId` is in the JSON response.
> - **Performant Jira** (`mcp__jira-dc__` tools): Set your user key (typically your login username, e.g. `jsmith`).
> - If you only use one system, leave the other placeholder in place or delete that subsection.
>
> To install the Machinify Jira MCP server, see this [Notion article](https://www.notion.so/machinify/Install-Claude-Code-Enterprise-30d5356b39718056be01e5eb7ce42d15#30d5356b3971804e871cf0018e771ad2)
>
> To install the Performant Jira MCP server, see this [Notion article](https://www.notion.so/machinify/Connect-Claude-Code-to-Performant-Jira-Confluence-Data-Center-3115356b397181a1bcbbd09aed0ca8d1)

## Get Started

### Step 1 — Copy the `_Template` folder

Copy `_Template` to wherever you keep your projects and rename it for the new project:

```bash
cp -r _Template ~/Projects/my-new-project
```

On Windows (PowerShell):
```powershell
Copy-Item -Recurse _Template "$env:USERPROFILE\Projects\my-new-project"
```

### Step 2 — Open new project folder

See [project-guide.md](project-guide.md) for full usage instructions and [skills-guide.md](skills-guide.md) for details on included skills.

---

## Keeping Your Work History

Each project maintains a `history/` folder with monthly log files (`history/YYYY-MM-monthname.md`). Claude appends an entry whenever a task or milestone is completed, capturing the date, type, description, and business value.

**Recommendation:** Periodically remind Claude to record work history — especially at the end of a work session or when wrapping up a milestone. Also make sure Claude asks for (and records) **business value** when you create a new task or milestone. This history is the primary input for the `/status-report` skill — see [skills-guide.md](skills-guide.md) for details.

---

Maintained by [John Moses](mailto:john.moses@machinify.com)
