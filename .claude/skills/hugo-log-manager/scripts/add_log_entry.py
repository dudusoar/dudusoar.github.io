#!/usr/bin/env python3
"""
Add log entries to Hugo site logs with automatic change detection.
"""

import argparse
import subprocess
from datetime import datetime
from pathlib import Path
import sys


def detect_change_type():
    """Detect whether changes are development or content related from git status."""
    try:
        result = subprocess.run(
            ['git', 'status', '--short'],
            capture_output=True,
            text=True,
            check=True
        )

        changed_files = result.stdout.strip().split('\n')
        if not changed_files or changed_files == ['']:
            return None

        dev_patterns = ['themes/', 'layouts/', 'assets/', 'static/', '.github/',
                       'hugo.yaml', 'hugo.toml', 'config.toml', 'config.yaml']
        content_patterns = ['content/posts/', 'content/tutorials/', 'content/projects/',
                          'content/photos/', 'content/about/']

        dev_count = 0
        content_count = 0

        for line in changed_files:
            if len(line) < 3:
                continue
            filepath = line[3:].strip()

            if any(filepath.startswith(pattern) for pattern in dev_patterns):
                dev_count += 1
            elif any(filepath.startswith(pattern) for pattern in content_patterns):
                content_count += 1

        if dev_count > content_count:
            return 'dev'
        elif content_count > dev_count:
            return 'content'
        else:
            return None

    except (subprocess.CalledProcessError, FileNotFoundError):
        return None


def get_changed_files():
    """Get list of changed files from git status."""
    try:
        result = subprocess.run(
            ['git', 'status', '--short'],
            capture_output=True,
            text=True,
            check=True
        )

        files = []
        for line in result.stdout.strip().split('\n'):
            if len(line) < 3:
                continue
            filepath = line[3:].strip()
            if filepath:
                files.append(filepath)

        return files

    except (subprocess.CalledProcessError, FileNotFoundError):
        return []


def init_log_file(log_path, log_type):
    """Initialize a log file with header if it doesn't exist."""
    if log_path.exists():
        return

    log_title = "Development Log" if log_type == "dev" else "Content Log"
    log_desc = ("This log tracks code changes, theme modifications, configuration updates, "
                "and technical improvements.") if log_type == "dev" else \
               ("This log tracks content updates including new posts, tutorials, "
                "projects, photos, and edits.")

    header = f"""# {log_title}

{log_desc}

---

"""

    log_path.write_text(header, encoding='utf-8')
    print(f"Created {log_path.name}")


def add_log_entry(log_type, description, files=None, tags=None, project_root='.'):
    """Add an entry to the appropriate log file."""
    project_path = Path(project_root).resolve()

    # Determine log file
    if log_type == 'dev':
        log_file = project_path / '.claude' / 'DEVELOPMENT_LOG.md'
        change_type = 'Development'
    else:
        log_file = project_path / '.claude' / 'CONTENT_LOG.md'
        change_type = 'Content'

    # Initialize log if needed
    init_log_file(log_file, log_type)

    # Format timestamp
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M')

    # Build entry
    entry = f"\n### {timestamp} - [{change_type}]\n\n"
    entry += f"**Description:** {description}\n\n"

    # Add files if provided
    if files and len(files) > 0:
        entry += "**Files affected:**\n"
        for file in files:
            entry += f"- {file}\n"
        entry += "\n"

    # Add tags if provided
    if tags:
        entry += f"**Tags:** {', '.join(tags)}\n\n"

    entry += "---\n"

    # Append to log file
    with open(log_file, 'a', encoding='utf-8') as f:
        f.write(entry)

    print(f"Added {change_type.lower()} log entry to {log_file.name}")
    return log_file


def main():
    parser = argparse.ArgumentParser(
        description='Add log entries to Hugo site logs'
    )
    parser.add_argument(
        'description',
        help='Description of the change'
    )
    parser.add_argument(
        '--type',
        choices=['dev', 'content'],
        help='Type of change (auto-detected if not specified)'
    )
    parser.add_argument(
        '--tags',
        help='Comma-separated tags (e.g., bug,mobile,ui)'
    )
    parser.add_argument(
        '--files',
        help='Comma-separated list of affected files (auto-detected from git if not specified)'
    )
    parser.add_argument(
        '--project-root',
        default='.',
        help='Path to Hugo project root (default: current directory)'
    )

    args = parser.parse_args()

    # Determine change type
    change_type = args.type
    if not change_type:
        change_type = detect_change_type()
        if not change_type:
            print("Could not auto-detect change type. Please specify --type dev or --type content")
            sys.exit(1)
        print(f"Auto-detected change type: {change_type}")

    # Get files
    files = []
    if args.files:
        files = [f.strip() for f in args.files.split(',')]
    else:
        files = get_changed_files()

    # Parse tags
    tags = None
    if args.tags:
        tags = [t.strip() for t in args.tags.split(',')]

    # Add entry
    add_log_entry(
        log_type=change_type,
        description=args.description,
        files=files,
        tags=tags,
        project_root=args.project_root
    )


if __name__ == '__main__':
    main()
