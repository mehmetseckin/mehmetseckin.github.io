---
layout: post
title: Recommendations on Git Commits and Pull Requests
---

A project's long-term success is tightly coupled by its maintainability. A clean and well crafted source control history is one of the most important and powerful tools when it comes to maintain projects.

In this document, I will try to provide some recommendations to help us build and keep a clean source control history and make life easier for both our future selves and whoever might inherit and maintain your codebase.

## Commits

The simplest building block of the source control history is the individual commits. As the commits get *better*, your source control history gets healthier, the project becomes easier to maintain and develop, which contributes a lot to the project's success.

A good commit is an *atomic* set of changes, documented with a well-written *commit message*.

### Make atomic commits

An *atomic* commit is a logically separated set of changes. Each set of change contains a single block of work that tackles a single task.

Give some thought into your changes and try to divide them into logical chunks of work, each addressing a single operations.

If you can, make your commits *digestible*; for example, don't code for a whole week on five different bugs and then submit all of your changes in a massive commit:

```text
Fix issues with single sign-on, header layout and another irrelevant module
```

Try to split your work into *at least one* commit per bug, with well-written commit messages. This will make it easier to review the changes and pull out or revert one of the change sets later if needed:

```text
commit a023bac42
Author: Mehmet Seckin <mehmetseckin@example.com>
Date:   Fri Jan 01 00:00:00 1970 -0000

Enable single sign-on for XYZ context

Fixes: #123
---
commit 0c2cda12
Author: Mehmet Seckin <mehmetseckin@example.com>
Date:   Fri Jan 02 00:00:00 1970 -0000

Improve header layout

Moved the navbar towards the top of the page to prevent the logo from
disappearing in responsive mode.

Fixes: #456
---
commit 10dcb332
Author: Mehmet Seckin <mehmetseckin@example.com>
Date:   Fri Jan 03 00:00:00 1970 -0000

Add plug-in support for XYZ module

Completes: #789
```

### Write good commit messages

There are some well-established conventions as to what makes a good commit message. The following example shows the idiomatic format and sections of a good commit message:

```text
Summarize changes in around 50 characters or less

More detailed explanatory text, if necessary. Wrap it to about 72
characters or so. In some contexts, the first line is treated as the
subject of the commit and the rest of the text as the body. The
blank line separating the summary from the body is critical (unless
you omit the body entirely); various tools like `log`, `shortlog`
and `rebase` can get confused if you run the two together.

Explain the problem that this commit is solving. Focus on why you
are making this change as opposed to how (the code explains that).
Are there side effects or other unintuitive consequences of this
change? Here's the place to explain them.

Further paragraphs come after blank lines.

 - Bullet points are okay, too

 - Typically a hyphen or asterisk is used for the bullet, preceded
by a single space, with blank lines in between, but conventions
vary here

If you use an issue tracker, put references to them at the bottom,
like this:

Resolves: #123
See also: #456, #789
```

Here are some rules of thumb:

#### Treat the first line of your commit message as the *Subject Line*

The first line of your commit message should be treated like the subject line of an e-mail message.

This should summarise the changes in a short, descriptive sentence.

##### Start with a capital letter

The subject line should be capitalised, for example;

```text
Fix file format and indentation
```

##### Keep it short - about 50 characters or less

50 characters isn't an absolute limit, but it forces the author to think about the message and try to summarise it as clearly as possible.

> If you're having a hard time summarizing, you might be committing too many changes at once. Always try to [make atomic commits](#make-atomic-commits).

Most git platforms are aware of this convention and will display a truncated version of your subject line if it's longer than it supposed to be.

##### Use imperative mood in the subject line

Git itself uses imperative whenever it creates a commit, for example if you use `git merge`, you will see a commit message like the following:

```text
Merge branch 'myfeature' into 'develop'
```

So when you write your commit messages in the imperative, you're following Git's own built-in conventions, which increases **consistency** across the source control history. For example:

```text
Refactor XYZ to improve readability
Update README file
Remove deprecated methods
Merge 'feat/abc' into 'develop'
Release v1.0.0
```

is easier to follow than the following log:

```text
Refactoring XYZ to improve readability
README file has been updated
Removal of deprecated methods
Merge 'feat/abc' into 'develop'
Released v1.0.0
```

##### Do not end the subject line with a period

Ending wih a period is unnecessary in subject lines. Besides, the period eats a precious character from the 50 character limit.

Do this:

```text
Configure Kerberos authentication
```

instead of this:

```text
Configure Kerberos authentication.
```

#### Add a body to explain the context and details of your change

Not every commit message requires a subject and a body. Some commits can be as simple as:

```text
Correct typo in README file
```

There is no need to say anything more. If the reader wants to know what was the typo, they can take a look at the change.

However, sometimes your commit needs a bit of explanation or context. In this case, add details of your change after your subject line. Try to explain the context and reason of the change. For example:

```text
Re-authenticate user with admin scope

The X action requires the user to have elevated privileges. This commit
adds functionality to request the necessary privileges and perform the
action subsequently.
```

##### Separate the body from the subject line with a blank line

For example, `git revert` generates the following:

```text
Revert "Add the thing with the stuff"

This reverts commit cc87791524aedd593cff5a74532befe7ab69ce9d.
```

##### Use the body to explain *what* and *why* instead of *how*

Code is generally self explanatory about *how* a change was made. Focus on documenting the problem your solution and why is it the best way to tackle the problem in the message, instead of the implementation details of your solution.

For example, do this:

```text
Clear the token cache when a new session starts

The cached tokens were being re-used by the browser which resulted
in token renewal errors between sessions. Clearing the token cache
avoids the futile effort by the browser to renew the previous session.
```

Instead of this:

```text
Clear the token cache when a new session starts

Call `OAuth2UserManager.TokenCache.Clear()` to clear the token cache.
```

##### Add references to tasks or bugs at the end of the body

Drop a reference to the related work item to make it much easier to track the cause of the change. This is especially good when the git platform is capable of automatically associating the referenced work item as it also helps with changelogs.

## Pull Requests

The Pull Requests are an important part of the source control history, because this is the place where a particular change is documented, explained, reviewed and refined.

### Keep Pull Requests as small as possible

The more changes in a pull request, the harder to understand it, and the longer it takes to review it.

Break down your work into multiple pieces of logically separate and independent pull requests to ease the review process, catch bugs early and reduce code smell.

### Apply single responsibility principle

> The single responsibility principle is a computer programming principle that states that every module or class should have responsibility over a single part of the functionality provided by the software, and that responsibility should be entirely encapsulated by the class.

Just like classes and modules, pull requests should do only one thing. Before submitting a PR for review, try applying the principle of single responsibility. If this code is doing more than one thing, break it into other Pull Requests.

### The Pull Request title should be short and self-explanatory

The title should be sufficient to understand what is being changed. For example:

- Add single sign-on support for X
- Improve registration error handling process

### The description should contain as much detail as possible

- Describe **what** has changed.
- Explain **why** has the change been made.
- Clearly define **how** the change was implemented
- Use screenshots, code snippets and other resources to demonstrate the changes.

This is especially helpful if the Pull Requests are merged into the mainstream via a *squash merge*, in which case your PR title and description will automatically form a good commit message.

## Further Reading

This document is heavily inspired from the following articles:

- [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)
- [Git Commit Guidelines](https://www.git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project#_commit_guidelines)
- [The Art of Pull Requests](https://hackernoon.com/the-art-of-pull-requests-6f0f099850f9)
- [The Anatomy of a Perfect Pull Request](https://medium.com/@hugooodias/the-anatomy-of-a-perfect-pull-request-567382bb6067)