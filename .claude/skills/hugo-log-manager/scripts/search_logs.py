#!/usr/bin/env python3
"""
Search Hugo site logs with various filters.
"""

import argparse
import re
from datetime import datetime
from pathlib import Path


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
        'tags': tags,
        'raw': entry_text
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


def search_logs(query=None, log_type=None, since=None, tags=None, project_root='.'):
    """Search logs with filters."""
    project_path = Path(project_root).resolve()

    # Determine which logs to search
    logs_to_search = []
    if log_type == 'dev' or log_type is None:
        dev_log = project_path / '.claude' / 'DEVELOPMENT_LOG.md'
        if dev_log.exists():
            logs_to_search.append(('dev', dev_log))

    if log_type == 'content' or log_type is None:
        content_log = project_path / '.claude' / 'CONTENT_LOG.md'
        if content_log.exists():
            logs_to_search.append(('content', content_log))

    # Read all entries
    all_entries = []
    for log_name, log_path in logs_to_search:
        entries = read_log_entries(log_path)
        for entry in entries:
            entry['log'] = log_name
            all_entries.append(entry)

    # Apply filters
    filtered_entries = all_entries

    # Filter by date
    if since:
        since_date = datetime.strptime(since, '%Y-%m-%d')
        filtered_entries = [e for e in filtered_entries if e['timestamp'] >= since_date]

    # Filter by tags
    if tags:
        tag_list = [t.strip() for t in tags.split(',')]
        filtered_entries = [e for e in filtered_entries
                          if any(tag in e['tags'] for tag in tag_list)]

    # Filter by query
    if query:
        query_lower = query.lower()
        filtered_entries = [e for e in filtered_entries
                          if query_lower in e['description'].lower() or
                          any(query_lower in f.lower() for f in e['files'])]

    # Sort by timestamp (newest first)
    filtered_entries.sort(key=lambda e: e['timestamp'], reverse=True)

    return filtered_entries


def print_results(entries):
    """Print search results."""
    if not entries:
        print("No matching entries found.")
        return

    print(f"\nFound {len(entries)} entries:\n")
    print("=" * 80)

    for entry in entries:
        timestamp_str = entry['timestamp'].strftime('%Y-%m-%d %H:%M')
        print(f"\n[{entry['log'].upper()}] {timestamp_str} - {entry['type']}")
        print(f"  {entry['description']}")

        if entry['files']:
            print(f"  Files: {', '.join(entry['files'][:3])}" +
                  (f" ... (+{len(entry['files'])-3} more)" if len(entry['files']) > 3 else ""))

        if entry['tags']:
            print(f"  Tags: {', '.join(entry['tags'])}")

        print("-" * 80)


def main():
    parser = argparse.ArgumentParser(
        description='Search Hugo site logs'
    )
    parser.add_argument(
        'query',
        nargs='?',
        help='Search query (searches in descriptions and file paths)'
    )
    parser.add_argument(
        '--log',
        choices=['dev', 'content'],
        help='Search only in specific log (default: both)'
    )
    parser.add_argument(
        '--since',
        help='Only show entries since date (format: YYYY-MM-DD)'
    )
    parser.add_argument(
        '--tags',
        help='Filter by tags (comma-separated)'
    )
    parser.add_argument(
        '--project-root',
        default='.',
        help='Path to Hugo project root (default: current directory)'
    )

    args = parser.parse_args()

    # Search
    entries = search_logs(
        query=args.query,
        log_type=args.log,
        since=args.since,
        tags=args.tags,
        project_root=args.project_root
    )

    # Print results
    print_results(entries)


if __name__ == '__main__':
    main()
