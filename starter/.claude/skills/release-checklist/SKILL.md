---
name: release-checklist
description: Ship a new version of the shop safely. Use when asked to release, deploy or "put it live", or when a release failed halfway.
---

# Release checklist

Written after a release went out with an old config file. Follow it in order.

## Before
1. Make sure you're on an up-to-date `main`: `git fetch && git status`.
2. Run the tests. Stop if anything fails.
3. Check the version number has been bumped in one place only.

## Release
4. Build from a clean copy, not a folder with local edits.
5. Deploy with `<your deploy command>`.
6. Open the live site and check one thing that changed. Add `?nocache=1` to the address if
   the old page still shows.

## After
7. Write a checkpoint in `state.md`: version, time, what you checked.
8. If anything went wrong, add the trap to "Known traps" below.

## Known traps
- The deploy says "success" even when it uploaded nothing. Always check the live page (step 6).
- Building in a folder with uncommitted changes ships those changes too.
