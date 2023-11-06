How to contribute to sbtest
=====================================

Thank you for considering contributing to this project!

## General guidelines
- Keep PRs short to simplify review
- PRs should include changes only to files related to change
- Avoid style only code based PRs

#### Reporting issues

Check if this issue is already fixed in the latest release.  If not, please include the following information in your post:

- Describe what you expected to happen.
- Describe what actually happened.
- Include the full traceback if there was an exception.


## Submitting patches

You can work on any issue that doesn't have an open PR linked to it or a
maintainer assigned to it. These show up in the sidebar. No need to ask if you
can work on an issue that interests you.


## First time setup

- Install [git](https://git-scm.com/downloads)

- Configure your [git username](https://docs.github.com/en/github/using-git/setting-your-username-in-git) and [git email](https://docs.github.com/en/github/setting-up-and-managing-your-github-user-account/setting-your-commit-email-address)
```sh
$ git config --global user.name 'your name'
$ git config --global user.email 'your email'
```

- Make sure you have a [GitHub account](https://github.com/join)


## Clone/Fork Repository

- [Fork sbtest](https://github.com/zeroasiccorp/sbtest/fork) to your GitHub account (external contributors only)

- [Clone](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo#step-2-create-a-local-clone-of-your-fork) the main repository locally.

```sh
$ git clone https://github.com/{username}/sbtest
$ cd sbtest
```

- Add fork as a remote to push your work to (external contributors only)

```sh
$ git remote add fork https://github.com/{username}/sbtest
```


## Start coding

-  Create a branch to identify the issue you would like to work on.

```sh
$ git fetch origin
$ git checkout -b your-branch-name origin/main
```
- Using your favorite editor, make your changes, and [commit](https://dont-be-afraid-to-commit.readthedocs.io/en/latest/git/commandlinegit.html#commit-your-changes)

- Push your commits to your fork on GitHub (external contributors)

```sh
$ git push --set-upstream fork your-branch-name
```

- Push your commits to your sbtest branch on GitHub (team contributors)
```sh
$ git push -u origin your-branch-name
```

## Create a Pull Request

- Create a [pull request](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) through GitHub.

## Resources

Based on the [SiliconCompiler contribution guidelines](https://github.com/siliconcompiler/siliconcompiler/blob/main/CONTRIBUTING.md)
