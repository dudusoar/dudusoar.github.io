# Hugo Log Manager - Quick Reference

## Installation

This skill is already installed in your project's `.claude/skills/` directory.

## Usage

### 1. Add Log Entry

```bash
# Auto-detect from git changes
python .claude/skills/hugo-log-manager/scripts/add_log_entry.py "Your change description"

# Specify type explicitly
python .claude/skills/hugo-log-manager/scripts/add_log_entry.py "Added new feature" --type dev
python .claude/skills/hugo-log-manager/scripts/add_log_entry.py "New blog post" --type content

# Add tags
python .claude/skills/hugo-log-manager/scripts/add_log_entry.py "Fixed bug" --tags bug,urgent
```

### 2. Search Logs

```bash
# Search all logs
python .claude/skills/hugo-log-manager/scripts/search_logs.py "keyword"

# Search specific log
python .claude/skills/hugo-log-manager/scripts/search_logs.py "theme" --log dev

# Filter by date
python .claude/skills/hugo-log-manager/scripts/search_logs.py --since 2024-01-01

# Filter by tags
python .claude/skills/hugo-log-manager/scripts/search_logs.py --tags bug
```

### 3. Generate Summary

```bash
# Last 7 days
python .claude/skills/hugo-log-manager/scripts/summarize_logs.py

# Last 30 days
python .claude/skills/hugo-log-manager/scripts/summarize_logs.py --days 30

# Group by type
python .claude/skills/hugo-log-manager/scripts/summarize_logs.py --group-by type

# Group by date
python .claude/skills/hugo-log-manager/scripts/summarize_logs.py --group-by date

# Group by tags
python .claude/skills/hugo-log-manager/scripts/summarize_logs.py --group-by tags
```

## Log Files

- `DEVELOPMENT_LOG.md` - Development changes (code, theme, config)
- `CONTENT_LOG.md` - Content changes (posts, tutorials, projects)

## Common Tags

- `feature` - New feature
- `bug` - Bug fix
- `content` - Content update
- `design` - Design/UI change
- `config` - Configuration change
- `theme` - Theme modification
- `mobile` - Mobile-related
- `performance` - Performance improvement

## Tips

1. Log changes immediately after making them
2. Use consistent, descriptive messages
3. Tag entries for easier searching
4. Review summaries regularly to track progress
