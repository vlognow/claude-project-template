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

### Step 1 — Install global files

Double-click the installer for your platform. It copies everything in `files/` into `~/.claude/`, skipping any files that already exist.

**Windows:** Double-click `install_win.bat` in Explorer.

**Mac:** Double-click `install_mac.command` in Finder.
> First time only: macOS may block it. If so, right-click → Open, then click Open in the dialog. You may also need to run `chmod +x install_mac.command` once in Terminal if it doesn't open.

After running, edit `~/.claude/CLAUDE.md` to fill in your personal details (email, Jira account ID, etc.).

> **Manual install:** If you prefer not to use the installer, copy each file in `files/` to `~/.claude/`, and copy `files/skills/status-report/SKILL.md` to `~/.claude/skills/status-report/SKILL.md`. Skip any files that already exist at the destination. **Mac users:** skip `start-claude.ps1` — it's Windows-only.

> **Existing files are skipped.** If you already have a `~/.claude/CLAUDE.md`, the installers will not overwrite it. Manually merge any sections from `files/CLAUDE.md` into your existing file.

> :sunglasses: To keep tab titles after sleep/wake on Windows, ask Claude: "Add suppressApplicationTitle to my Windows PowerShell profile in Windows Terminal settings.json"

### Step 2 — Edit the global `~/.claude/CLAUDE.md` file

It has three specific fields that need your attention:

1. Set your email on the Email: line
2. Set your Projects Folder path under **My Projects Folder**
3. Set your Jira account ID (if you are using the Atlassian MCP server with **CC**).
>To find your Jira account ID, open a browser where you're logged into Jira and navigate to
  https://machinify.atlassian.net/rest/api/3/myself — your accountId is in the JSON response.
>
> To install the Atlassian MCP Server, see this [Notion article](https://www.notion.so/machinify/Install-Claude-Code-Enterprise-30d5356b39718056be01e5eb7ce42d15#30d5356b3971804e871cf0018e771ad2)

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
