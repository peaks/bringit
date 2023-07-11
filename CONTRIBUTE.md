# Developer's Guide

This is a quick check-list on how to properly contribute to this project.

## Code style

### Code linting

- Code must follow standard lint recommendations depending on the language
- Please always use Linux newlines (**LF**) over Windows ones (**CRLF**)

### Self-explanatory code, comments and documentation

- Code should be mainly self-explanatory, comments are for tricky parts of code only
- Use meaningful names for EVERY variable, class, method... Even in loops and small functions
- Avoid trivial comments
- Follow language's documentation good standards, like Javadoc for Java
- Document Classes and Methods (through comments) to easy code appropriation


### Logging

- If possible, use a dedicated tool for logging, avoid `print` statements
- Follow [these recommendations](https://dzone.com/articles/logging-best-practices) to log application's activity
- Always log catched errors and exceptions
- Also log *normal* activity to help developers to monitor the application
- Write clear self-explanatory logs, with package, class or service name
  - `2014-07-02 20:52:39 INFO [AUTH] user bob authenticated`

## Continuous Integration

### Testing

- Write Unit Tests for new code if possible
- New tests should cover a minimum of cases (do not over test)
- While fixing a bug, if no unit test covers this case, write a new test to complete test suite

### Gitlab CI/CD

- **DO NOT DISABLE CI STEPS TO MERGE CODE**

## Versioning
### Commit

- Follow [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/)
- Use you full name and Peaks email as identity (see [here](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup#_your_identity) for details)
- Create coherent and consistent commits
- Rearrange (squash, reorder...) commits if needed
- Avoid to many commits for a single feature
- Do not use the *squash all* option on Gitlab

### Rebase for all

- Always rebase before merge
- No merge during development!
- Only merge through Gitlab to close MRs
