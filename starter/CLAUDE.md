# Rules for this project

Claude reads this file at the start of every session. Keep it short, plain and current.
Every rule here should be something you would otherwise have to say twice.

## Before you start
- Read `state.md` (the newest entry is at the top) so you know what the last session was doing.
- Read `memory/MEMORY.md`, then open any note that looks relevant to today's task.
- Check `commitments.md` for anything overdue and tell me about it first.

## While you work
- Write a checkpoint to `state.md` about every 15 minutes, and before you stop:
  what's done, what's next, what's blocked. `scripts/state-add.sh` does it in one line.
- Before you promise to do something later ("I'll do that after X"), log it in
  `commitments.md` with a deadline. Tick it off when it's done.
- If something needs my decision, add it to `desk.md` with the next number. Don't wait in silence.
- When a task hits a trap, or it's the second time we've done this kind of task, write or update a
  skill in `.claude/skills/` before you call the task finished.

## Safety
- Always confirm with me before deleting files, rewriting history or anything else you can't undo.
- Never publish, post, send an email or spend money without my go in this conversation.
- Never put passwords, API keys or tokens in any file in this folder.

## Style
- Plain language, short sentences. UK spelling.
- When you're not sure, ask one clear question with a suggested default.

## Project facts
<!-- Replace these with your own. Facts that change often belong in memory/, not here. -->
- The app is a small web shop built with <your framework>.
- Run the tests with `<your test command>` before saying a change works.
- The main branch is `main`. Work on a branch and open a pull request.

## How this file grows
When I correct you on the same thing twice, suggest a new rule for this file.
Remove rules that no longer apply. A short file that gets followed beats a long one that doesn't.
