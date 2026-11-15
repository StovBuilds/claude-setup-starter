# SETUP.md: install instructions for Claude

You are an AI assistant (Claude Code or similar) and the user has asked you to set up
**claude-setup-starter** in their project. Follow these steps in order. The user is a person who may
not be technical: keep messages short and plain, and use UK spelling.

**The golden rule: never overwrite or delete anything the user already has.** New files are added.
Existing files are merged into (added to, never cut), and you show the user what changed.

If you can't run commands or edit files (for example in a plain chat), don't pretend to. Tell the
user, then walk them through the steps below by hand, giving them the file contents to paste.

---

## Step 1: Check where you are

1. The target is the **current working directory** (the user's project). Print it.
2. If it's the user's home folder, the root of the drive or a system folder, stop and ask which
   project folder to use. Don't scatter files in the wrong place.
3. Note whether it's a git repository (`git rev-parse --is-inside-work-tree`). If it is, note
   whether there are uncommitted changes, so you can tell your changes apart from theirs later.

## Step 2: Get the starter files

Download to a **temporary folder**, never into the project itself.

```sh
TMP="$(mktemp -d)"
git clone --depth 1 https://github.com/StovBuilds/claude-setup-starter.git "$TMP/starter-src"
```

If `git` isn't installed, download the zip instead:

```sh
curl -fsSL -o "$TMP/starter.zip" https://github.com/StovBuilds/claude-setup-starter/archive/refs/heads/main.zip
unzip -q "$TMP/starter.zip" -d "$TMP" && mv "$TMP"/claude-setup-starter-main "$TMP/starter-src"
```

If the user gave you a different source (a local folder, a `file://` path or a fork), use that.

**If neither works** (an error such as "repository not found", "could not resolve host", a 404, or
a request for a password), stop and tell the user:

> The starter repo isn't reachable from here, so I haven't changed anything. It may be private or
> not published yet, or this machine may be offline. If you have a copy of the files, tell me where
> they are and I'll use those.

Don't try to log in, don't guess other URLs and don't rebuild the files from memory.

The files you need are in `$TMP/starter-src/starter/`. Read `$TMP/starter-src/README.md` so you
understand what each piece is for.

## Step 3: Ask the user a few questions

Ask these in **one** message, numbered, and say they can answer briefly or say "skip":

1. What's the project called?
2. What is it, in a sentence? (What it does and who it's for.)
3. How do you run it or test it? (A command, or "not sure" / "no tests yet".)
4. Up to three rules you always want me to follow in this project.
5. Anything I must never do without asking you first? (The starter already covers deleting files,
   publishing, sending messages and spending money.)

Wait for the answers. If you're running without a person to ask (no way to get a reply), or the
user already gave the answers in their request, use what you have, put `<to fill in>` where you
have nothing, and say so in the summary.

## Step 4: Add the files, merging where they already exist

Work through this table. "Example content" means the sample entries in the starter files (the
fictional web shop): leave those out of the user's project.

| Starter file | If the project doesn't have it | If it already exists |
|---|---|---|
| `CLAUDE.md` | Copy it, then fill in "Project facts" (Step 5). | **Merge**, see below. |
| `memory/MEMORY.md` | Copy the headings and the intro, without the example lines. | Keep it. Add only the lines for notes you create. |
| `memory/_TEMPLATE.md` | Copy. | Skip (tell the user). |
| `memory/` example notes | Don't copy. | Don't copy. |
| `state.md` | Create it with only the anchor comment line from the starter's first line, then a blank line. | Keep every entry. If the anchor line is missing, add it as the very first line. |
| `desk.md`, `commitments.md` | Copy, but empty the "Open" and "Done" lists. | Keep it as is. Mention it in the summary. |
| `.claude/skills/_TEMPLATE.md` | Copy. | Skip. |
| `.claude/skills/release-checklist/` | Copy only if the user wants an example skill; otherwise leave it out. | Never replace a skill with the same name. |
| `scripts/state-add.sh` | Copy and make it executable (`chmod +x`). | If a different file has that name, copy ours as `scripts/state-add-starter.sh` instead. |

**Merging into an existing `CLAUDE.md`:**
1. Read the existing file in full first, and keep every line of it.
2. Append one new section at the end, headed `## Working memory (from claude-setup-starter)`,
   containing the starter's "Before you start" and "While you work" rules, plus any "Safety" and
   "Style" rules the existing file doesn't already say in some form.
3. Skip any starter rule that duplicates or contradicts one already in the file. The user's rule
   wins; mention the conflict in the summary.
4. If the existing file already has project facts, don't add a second "Project facts" section;
   add only new facts from the answers, under the existing ones.

Before writing to any file that already existed, copy it to `<file>.before-setup` in the temporary
folder so you can show the diff in Step 6. (If the project uses git, the user can also restore any
file with git.)

## Step 5: Fill in the user's details

1. In `CLAUDE.md`, replace the placeholder "Project facts" lines with facts from the answers
   (what it is, how to run or test it), and add their rules (answers 4 and 5) under "Safety" or a
   short "Project rules" list. Remove placeholder lines like `<your framework>` that you couldn't
   fill, rather than leaving them in.
2. Write a first memory note, `memory/project-overview.md`, in the format from
   `memory/_TEMPLATE.md` (type `project`): what the project is, who it's for, and how to run it,
   with **Why** and **How to apply** lines. Add its line to `memory/MEMORY.md` under "Project".
3. Write the first state entry with the helper:
   ```sh
   scripts/state-add.sh "Set up claude-setup-starter" "done: rules, memory, state, desk and commitments files added" "next: <what the user said they want to work on, or 'start using it'>"
   ```

## Step 6: Check your work

- Each file you were meant to add exists, and no existing file lost a line: compare each merged
  file with its `.before-setup` copy (`diff -u`). Every change should be an addition.
- `scripts/state-add.sh` is executable and the first entry sits directly under the anchor line at
  the top of `state.md`.
- If the project is a git repository, run `git status` and check that only the files you meant
  to touch show up. **Don't commit** unless the user asks you to.

## Step 7: Clean up and report

Delete the temporary folder. Then give the user a short summary:

1. **Added:** the new files.
2. **Merged:** each existing file you added to, with the diff (or the added lines if the diff is long).
3. **Left alone:** existing files you didn't touch, and any conflicts where their rule won.
4. **How to use it**, in three lines:
   - I'll read `state.md`, `memory/MEMORY.md` and `commitments.md` at the start of each session.
   - Anything that needs your decision goes on `desk.md` with a number; reply like "2 yes, 3 no".
   - When you correct me twice about the same thing, I'll suggest a new rule for `CLAUDE.md`.
5. Anything you filled with `<to fill in>`, so they can give you the details later.
