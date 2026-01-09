#!/usr/bin/env python3
"""
Generate summaries of Hugo site log entries.
"""

import argparse
import re
from datetime import datetime, timedelta
from pathlib import Path
from collections import defaultdict


def parse_log_entry(entry_text):
    """Parse a log entry into structured data."""
    lines = entry_text.strip().split('\n')
    if not lines:
        return None

    # Parse header: ### 2024-01-07 14:30 - [Type]
    header_match = re.match(r'###\s+(\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2})\s+-\s+\[(.+?)\]', lines[0])
    if not header_match:
        return None

    timestamp_str, entry_type = header_match.groups()
    timestamp = datetime.strptime(timestamp_str, '%Y-%m-%d %H:%M')

    # Parse description
    description = ""
    files = []
    tags = []

    i = 1
    while i < len(lines):
        line = lines[i].strip()

        if line.startswith('**Description:**'):
            description = line.replace('**Description:**', '').strip()
        elif line.startswith('**Files affected:**'):
            i += 1
            while i < len(lines) and lines[i].strip().startswith('-'):
                files.append(lines[i].strip()[1:].strip())
                i += 1
            continue
        elif line.startswith('**Tags:**'):
            tags_str = line.replace('**Tags:**', '').strip()
            tags = [t.strip() for t in tags_str.split(',')]

        i += 1

    return {
        'timestamp': timestamp,
        'type': entry_type,
        'description': description,
        'files': files,
        'tags': tags
    }


def read_log_entries(log_path):
    """Read and parse all entries from a log file."""
    if not log_path.exists():
        return []

    content = log_path.read_text(encoding='utf-8')

    # Split by entry separator
    entries_text = re.split(r'\n### ', content)

    # Remove header (everything before first entry)
    if entries_text:
        entries_text = entries_text[1:]

    # Add back the ### prefix
    entries_text = ['### ' + e for e in entries_text]

    # Parse entries
    entries = []
    for entry_text in entries_text:
        entry = parse_log_entry(entry_text)
        if entry:
            entries.append(entry)

    return entries


def generate_summary(days=7, group_by=None, project_root='.'):
    """Generate summary of recent log entries."""
    project_path = Path(project_root).resolve()

    dev_log = project_path / '.claude' / 'DEVELOPMENT_LOG.md'
    content_log = project_path / '.claude' / 'CONTENT_LOG.md'

    # Read entries
    all_entries = []

    if dev_log.exists():
        dev_entries = read_log_entries(dev_log)
        for entry in dev_entries:
            entry['log'] = 'Development'
            all_entries.append(entry)

    if content_log.exists():
        content_entries = read_log_entries(content_log)
        for entry in content_entries:
            entry['log'] = 'Content'
            all_entries.append(entry)

    # Filter by date range
    cutoff_date = datetime.now() - timedelta(days=days)
    recent_entries = [e for e in all_entries if e['timestamp'] >= cutoff_date]

    # Sort by timestamp (oldest first for summary)
    recent_entries.sort(key=lambda e: e['timestamp'])

    return recent_entries


def print_summary(entries, days, group_by=None):
    """Print summary report."""
    if not entries:
        print(f"No entries found in the last {days} days.")
        return

    print(f"\n{'='*80}")
    print(f"SUMMARY: Last {days} days ({len(entries)} entries)")
    print(f"{'='*80}\n")

    if group_by == 'type':
        # Group by entry type
        grouped = defaultdict(list)
        for entry in entries:
            grouped[entry['log']].append(entry)

        for log_type in sorted(grouped.keys()):
            print(f"\n## {log_type} Changes ({len(grouped[log_type])} entries)\n")
            for entry in grouped[log_type]:
                date_str = entry['timestamp'].strftime('%Y-%m-%d')
                print(f"- [{date_str}] {entry['description']}")
                if entry['tags']:
                    print(f"  Tags: {', '.join(entry['tags'])}")

    elif group_by == 'date':
        # Group by date
        grouped = defaultdict(list)
        for entry in entries:
            date_key = entry['timestamp'].strftime('%Y-%m-%d')
            grouped[date_key].append(entry)

        for date in sorted(grouped.keys()):
            print(f"\n## {date} ({len(grouped[date])} entries)\n")
            for entry in grouped[date]:
                print(f"- [{entry['log']}] {entry['description']}")
                if entry['tags']:
                    print(f"  Tags: {', '.join(entry['tags'])}")

    elif group_by == 'tags':
        # Group by tags
        tag_entries = defaultdict(list)
        untagged = []

        for entry in entries:
            if entry['tags']:
                for tag in entry['tags']:
                    tag_entries[tag].append(entry)
            else:
                untagged.append(entry)

        for tag in sorted(tag_entries.keys()):
            print(f"\n## Tag: {tag} ({len(tag_entries[tag])} entries)\n")
            for entry in tag_entries[tag]:
                date_str = entry['timestamp'].strftime('%Y-%m-%d')
                print(f"- [{date_str}] [{entry['log']}] {entry['description']}")

        if untagged:
            print(f"\n## Untagged ({len(untagged)} entries)\n")
            for entry in untagged:
                date_str = entry['timestamp'].strftime('%Y-%m-%d')
                print(f"- [{date_str}] [{entry['log']}] {entry['description']}")

    else:
        # Chronological list
        for entry in entries:
            timestamp_str = entry['timestamp'].strftime('%Y-%m-%d %H:%M')
            print(f"[{timestamp_str}] [{entry['log']}] {entry['description']}")
            if entry['tags']:
                print(f"  Tags: {', '.join(entry['tags'])}")
            print()

    # Statistics
    print(f"\n{'='*80}")
    print("STATISTICS")
    print(f"{'='*80}\n")

    dev_count = sum(1 for e in entries if e['log'] == 'Development')
    content_count = sum(1 for e in entries if e['log'] == 'Content')

    print(f"Total entries: {len(entries)}")
    print(f"  Development: {dev_count}")
    print(f"  Content: {content_count}")

    # Tag statistics
    all_tags = []
    for entry in entries:
        all_tags.extend(entry['tags'])

    if all_tags:
        from collections import Counter
        tag_counts = Counter(all_tags)
        print(f"\nMost common tags:")
        for tag, count in tag_counts.most_common(5):
            print(f"  {tag}: {count}")

    # File statistics
    all_files = []
    for entry in entries:
        all_files.extend(entry['files'])

    if all_files:
        print(f"\nTotal files affected: {len(set(all_files))}")


def main():
    parser = argparse.ArgumentParser(
        description='Generate summary of Hugo site logs'
    )
    parser.add_argument(
        '--days',
        type=int,
        default=7,
        help='Number of days to include in summary (default: 7)'
    )
    parser.add_argument(
        '--group-by',
        choices=['type', 'date', 'tags'],
        help='Group entries by type, date, or tags'
    )
    parser.add_argument(
        '--project-root',
        default='.',
        help='Path to Hugo project root (default: current directory)'
    )

    args = parser.parse_args()

    # Generate summary
    entries = generate_summary(
        days=args.days,
        group_by=args.group_by,
        project_root=args.project_root
    )

    # Print summary
    print_summary(entries, args.days, args.group_by)


if __name__ == '__main__':
    main()
