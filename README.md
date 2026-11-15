# Claude setup starter: a Claude that never forgets

A lightweight starter pack for working with Claude (Claude Code, or any assistant that can read
files in your project) without losing track of what you were doing.

The usual problem with Claude isn't that it isn't smart enough. It's that it forgets. Every new
chat starts from zero. Long chats get summarised and the early detail goes. A session ends halfway
through a job and the next one has no idea what happened.

The fix is simple: **nothing important lives only in a chat.** It lives in a few plain files that
Claude reads every time. This pack gives you six of them, with templates and examples. None of it
is clever code. It works whether you run one session or several at once.

> **Let Claude set it up.** Open Claude Code (or another assistant that can run commands and edit
> files) in your project folder and paste this one line:
>
> ```
> Set up https://github.com/StovBuilds/claude-setup-starter in this project. Follow its SETUP.md.
> ```
>
> It downloads the files, asks you a few quick questions, and adds everything without overwriting
> what you already have (existing files are merged and it shows you the changes). In a plain chat
> that can't touch your files, Claude can walk you through the same steps by hand instead.

## What's in the box

```
SETUP.md                        install steps Claude follows (see the box above)
starter/
  CLAUDE.md                     1. the rules file
  memory/
    MEMORY.md                   2. the memory index (capped at 150 lines)
    _TEMPLATE.md                   the format for one memory note
    *.md                           four example notes
  .claude/skills/
    _TEMPLATE.md                3. the skill format
    release-checklist/SKILL.md     an example skill
  state.md                      4. the state file (checkpoints, newest first)
  scripts/state-add.sh             a tiny helper to add a checkpoint
  desk.md                       5. the decision desk
  commitments.md                6. promises and reminders, with deadlines
```

## Getting started by hand (five minutes)

1. Copy everything inside `starter/` into the root of your project, including the hidden `.claude`
   folder. The `-n` stops it overwriting files you already have; merge those by hand (or let
   Claude do it, as above):
   ```sh
   cp -Rn starter/. /path/to/your-project/
   ```
2. Open `CLAUDE.md` and replace the "Project facts" section with your own. Delete any rule you
   don't want.
3. Delete the example memory notes and example desk, state and commitment entries once you've seen
   the format (or keep them until your own replace them).
4. Start a session. `CLAUDE.md` tells Claude to read the state file, the memory index and the
   commitments first, so from now on it starts every session knowing where things stand.

If you'd rather add the pieces one at a time, start with 1 and 4. They make the biggest
difference on day one.

---

## 1. The rules file (`CLAUDE.md`)

**What it is.** One file of standing instructions that Claude reads before it does anything. Claude
Code loads a `CLAUDE.md` in your project automatically; with other tools, tell the assistant to read
it first.

**Why it helps.** You stop repeating yourself. Things like "always confirm before deleting",
"never publish without my go" or "run the tests before saying it works" are said once and followed
every session.

**How to grow it.** The best rule of thumb: **when you correct Claude twice about the same thing,
it becomes a rule**, so you never have to correct it a third time. The template asks Claude to
suggest the rule itself. Keep the file short and prune it. A short file that gets followed beats a
long one that doesn't.

## 2. Memory: one fact per note

**What it is.** A `memory/` folder with one small file per fact, plus an index (`MEMORY.md`) with one
line per note. Claude reads the index every session and opens the notes that matter for the task.

**Why it helps.** One giant notes file grows until it's too big to read, and then it stops being
read. Small notes stay findable, easy to update and easy to delete when they stop being true. The
index is **capped at 150 lines** so it never bloats.

**The format.** Each note says three things:
- **the fact** (in a sentence or two),
- **why** it matters (what happened, or the reason behind it),
- **how to apply** it (what Claude should do differently).

Notes have a type: `user` (how you like to work), `feedback` (corrections and approaches that
worked), `project` (goals, dates and constraints that aren't visible in the code) and `reference`
(where things live). See `memory/_TEMPLATE.md` and the four examples.

**Good habits.** Update a note rather than adding a near-duplicate. Write dates in full, never "next
Tuesday". Don't store what the code or git history already shows.

## 3. Skills: how to do it

**What it is.** Memory is *what is true*. Skills are *how to do it*: short checklists for jobs you do
more than once. In Claude Code, each skill is a folder in `.claude/skills/` with a `SKILL.md` inside.
Claude sees each skill's description and loads the full checklist when a task matches.

**Why it helps.** Without them, every new session rediscovers the same traps. With them, the next
session just follows the checklist.

**When to write one.** Any time a task **hit a trap**, or it's **the second time** you've done that
kind of job. Ask Claude to write or update the skill before it calls the task finished. Generic
skills are everywhere online; the valuable ones are specific to how *you* work. The example,
`release-checklist`, shows the shape: steps in order, a check that it worked, and a "known traps"
list that grows over time.

## 4. The state file and checkpoints

**What it is.** One file, `state.md`, where every session writes a short checkpoint roughly **every 15
minutes**, and before it stops: what's done, what's next, what's blocked. Newest entry at the top.

**Why it helps.** This is the piece that stops work getting lost. When a chat fills up and gets
summarised, or a session crashes, or you simply come back tomorrow, the next session reads the top
of the file and picks up exactly where the last one left off. It's also what makes it safe to run
more than one session at once, because each can see what the others are doing.

**How to start.** The rule in `CLAUDE.md` asks for the checkpoints. The helper makes each one a
single line:

```sh
scripts/state-add.sh "Basket discount codes" "done: field added, tests pass" "next: server side"
```

Two or three honest lines beat a polished entry that never gets written. If Claude forgets, remind
it; if you want it automatic, Claude Code can run a command on a schedule or after tool calls
(look up "hooks" in its docs).

## 5. The decision desk

**What it is.** One numbered list, `desk.md`, for everything that needs a person's decision or is
worth handing to another session. Each item gets a number, a kind (decision, task or review), a
line of context and a suggested default.

**Why it helps.** Questions stop getting lost in old chats. You can clear a pile of them in one go
by replying "4 yes, 5 no, 6 later", and the work goes ahead. If you run several sessions, any free
one can pick up a task from the desk.

**How to start.** Tell Claude (the template already does) that anything needing you goes on the
desk with the next number instead of waiting in silence. Every so often, ask it to check the open
items against what's actually done, close the finished ones and bring you only the real decisions,
quickest first.

## 6. Promises and reminders

**What it is.** `commitments.md`: a list of promises, each with a deadline. **Before** Claude says
"I'll do that", it logs it here. Reminders use the same list: "park this till Tuesday" becomes a
dated line, not a hope.

**Why it helps.** Assistants (like people) say "I'll get to it" and then the session ends. Because
the promise was written down first, the next session sees it, and anything past its deadline gets
flagged at the start of every session.

**How to start.** The rule is already in `CLAUDE.md`. If you want an actual ping when something is
overdue, a few lines of script on a schedule that read this file and message you will do it; start
without that and add it when you need it.

---

## Tips

- **Start small.** The rules file and the state file alone fix most "it forgot" moments.
- **Plain files win.** Markdown in your project is readable by you, by Claude and by any other tool,
  and it's versioned with git for free.
- **Never put secrets in these files.** Passwords, API keys and tokens belong in your tool's secret
  store or environment, not in notes.
- **Prune.** Every few weeks, ask Claude to tidy the memory index, close done desk items and remove
  rules that no longer apply.

## About

Made by Jack Stovell, who builds in public as **StovBuilds**
([@stovbuilds](https://www.instagram.com/stovbuilds/) on Instagram and [YouTube](https://www.youtube.com/@stovbuilds)).

- Portfolio: [jstov.uk](https://jstov.uk)
- AI consultancy and builds: [APE, aibyape.com](https://aibyape.com)

This is a lightweight starter, the core ideas from a much bigger setup. If you want help building
something like it for your team, get in touch through either site.

## Licence

MIT. See [LICENSE](LICENSE). Use it, change it, share it.
