---
name: feedback-run-tests-first
description: Run the test suite before saying a change works; a clean build is not enough
type: feedback
---

Run the tests before telling me a change works. A build that compiles has twice hidden a broken
checkout page.

**Why:** a change once compiled cleanly, got reported as done, and broke the basket total for a day.

**How to apply:** after any code change, run the project's test command and report the result
(pass, or the failing test and its error). If there are no tests for that area, say so.

Related: [[project-launch-date]]
