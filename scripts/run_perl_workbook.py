#!/usr/bin/env python3
"""Execute the committed native Perl workbook cells in one fresh process."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]
PIN = '80ca9a5188817818764532febd47482e96cbb701'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    notebook = ROOT / 'perl/fluent-writes.md'
    source = notebook.read_text()
    cells = re.findall(r'^```perl\s*\n(.*?)^```\s*$', source, re.M | re.S)
    if not cells:
        raise SystemExit('No Perl workbook cells found')
    native = Path(os.environ.get('SELECTO_LIVE_SELECTO_PERL', ROOT.parent / 'selecto-perl')).resolve()
    revision = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=native, text=True).strip()
    dirty = bool(subprocess.check_output(['git', 'status', '--porcelain', '--untracked-files=no'], cwd=native, text=True).strip())
    if (revision != PIN or dirty) and os.environ.get('SELECTO_NOTEBOOK_ALLOW_LOCAL') != '1':
        raise SystemExit('Native Perl revision differs from workbook pin; set SELECTO_NOTEBOOK_ALLOW_LOCAL=1 for a recorded local run')
    with tempfile.TemporaryDirectory(prefix='selecto-perl-workbook-') as directory:
        program = Path(directory) / 'workbook.pl'
        program.write_text('\n'.join(cells))
        result = subprocess.run([os.environ.get('SELECTO_WRITE_PERL', 'perl'), '-I', str(native / 'lib'), str(program)],
                                text=True, encoding='utf-8', capture_output=True)
        if result.returncode:
            # Native errors are redacted. Avoid displaying a host DBI diagnostic.
            raise SystemExit('Perl workbook execution failed; check native dependencies and workbook assertions')
        report = json.loads(result.stdout)
    report.update(nativeRevision=revision, nativeDirty=dirty, workbookHash=hashlib.sha256(notebook.read_bytes()).hexdigest(),
                  workbook='perl/fluent-writes.md', cellCount=len(cells), proof='native teaching execution; not a certification profile')
    encoded = json.dumps(report, ensure_ascii=False, indent=2) + '\n'
    if args.output:
        args.output.write_text(encoded)
    else:
        print(encoded, end='')


if __name__ == '__main__':
    main()
