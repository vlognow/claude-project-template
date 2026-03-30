# Skills Guide

Skills are slash commands that extend Claude Code with reusable, structured workflows. This template installs the following skills to `~/.claude/skills/`.

---

## `/status-report`

Generates a weekly or monthly status report from your project's history files.

### Usage
```
/status-report [week=<date>] [month=<month>]
```

| Parameter | Description |
|---|---|
| *(none)* | Generates a report for the most recently completed Monday–Sunday week |
| `week=<date>` | Generates a report for the week containing the given date. Accepts any format (e.g., `2026-03-23`, `March 23`, `3/23/26`) |
| `month=<month>` | Generates a report for the full calendar month. Accepts month name or year-month (e.g., `March`, `March 2026`, `2026-03`) |

`week=` and `month=` are mutually exclusive.

### How it works

The skill reads your project's `history/` folder, where Claude records completed tasks and milestones in monthly log files (`history/YYYY-MM-monthname.md`). Each entry looks like:

```
- YYYY-MM-DD [TYPE] Description | Milestone: M# | Business Value: <value> | Status: complete
```

Entries with `Status: complete` appear in the report body. Entries with `Status: in-progress` appear in the Coming Up section.

### Output

The report is written to your project root and rendered in chat for review:
- Weekly: `report-YYYY-MM-DD.md` (dated to the Monday of the target week)
- Monthly: `report-YYYY-MM.md`

### Customizing the report structure

The skill looks for `report-template.md` in your `Reports` folder (the path set under `## Me` in `~/.claude/CLAUDE.md`). If found, it uses that as the report layout; otherwise it falls back to a built-in default.

A starter [report-template.md](report-template.md) is included at the repo root. Once your `Reports:` path is configured, copy it there and customize as needed.
