# Exercises - Git advanced topics

**Table of Content:**

[[_TOC_]]

<br>

:fire:
**About "Additional Tasks"**  
As you will see, some of the exercises contain an **Additional Tasks** section.
These are tasks that you can do if you have completed the regular part of the
exercise but there is still time in the exercise session. Additional Tasks will
not be corrected in class, but you can find corrections for them in the
exercise solutions.

<br>
<br>

## Exercise 1 - The vim cheat-sheet rebase  [40 min]
**Objective:** learn to use **interactive rebase**. You will be using the
following commands:
```sh
git rebase                                  # Rebase a branch.
git rebase --interactive                    # Interactively rebase a branch.
git switch                                  # Switch to a different branch.
git log --all --decorate --oneline --graph  # Or the "git adog" alias if you created it.
```

<br>

In this exercise, your task is to perform a cleanup on an existing repository
that contains instructions on how to use the `vim` editor.

:fire:
**Important:** in this exercise we will be **rewriting history on the `main` branch**
of our repository. In a *production* environment, this
**should in principle be avoided**.

Proceed as follows:

1. Enter the `exercise_1/vim_cheatsheet.git` repository and have a look at it's
   history. If you are using `vim` as an editor in Git, you can have a look at
   the content of the files in the repository to learn about some useful `vim`
   commands.  

2. Looking at the **commit history** on the `main` branch, you will see that
   the edits to the different files are all over the place. To make things more
   tidy, we first would like to group (in the history's chronology) the edits
   to each of the 3 files: `README.md`, `normal_mode.md` and `command_mode.md`.

   Your first task is thus to **re-order the commits on the `main` branch** in
   the following order (here listed from oldest to newest):
   ```
    1. First commit of the vim cheat-sheet project. Add README file
    2. Edit README file
    3. Edit README file: add open file example
    4. Add 'normal_mode' file: commands for vim's normal mode
    5. Edit 'normal_mode' file: add 'dd' and 'yy' commands
    6. Edit 'normal_mode' file: add more commands
    7. Add 'command_mode' file: commands for vim's command mode
    8. Edit 'command_mode' file: add more commands
   ```
   :warning:
   Note that we are only re-ordering commits that affect completely different
   files, but we are keeping the order of commits that affect the same file
   in the same relative order, because they "build on each other" (e.g. we
   could *not* have the commit that edits the file `normal_mode.md` before the
   commit that creates it!).

   <br>

3. **After you are done with the re-ordering**, display the history of the repo
   using `git log --all --decorate --oneline --graph` (or `git adog`, if you
   created this alias).
   You should see that branch `dev` still contains the two "old" commits
   (`9c7f8b4` and `c110031`) from the shared history it had with the `main`
   branch before the rebase. These two commits are now duplicated between the
   two branches. To get rid of them, rebase `dev` on `main`, then return to
   `main`.

   :pushpin:
   **Note:** after the rebase completed, you should observe that Git
   **automatically skipped the duplicated commits** on `dev`, because they have
   the exact same content as their counterparts on `main`. Git lets us know
   that the commits were skipped via the following warning:
   ```txt
   warning: skipped previously applied commit 9c7f8b4
   warning: skipped previously applied commit c110031
   ```

   <br>

4. All things considered, our repo history would look cleaner if, for each
   file, we had a **single commit** rather than having multiple small and
   incremental commits.  
    * **For each file, merge the different commits** so that your history looks
      like what is shown below (the oldest commit is listed at the bottom).
    * **Change** the commit message of the commit adding the README file to:
      `README: add vim modes and open file example`.
       ```
        * 7. Add 'command_mode' file: commands for vim's command mode
        * 4. Add 'normal_mode' file: commands for vim's normal mode
        * 2. README: add vim modes and open file example
        * 1. First commit of the vim cheat-sheet project. Add README file
       ```

   :fire:
   **Important:** the commit message for the second commit is a new message.
   You will need to **edit the commit message during the rebase**.  
   :pushpin:
   **Note:** the `README.md` file still has 2 commits - because its first
   commit is also the first commit of the repo (and that first commit is more
   difficult - but not impossible - to change).

   <br>

5. Display the history of the repo using
   `git log --all --decorate --oneline --graph`, or `git adog`, if you
   created this alias.

   You will see that, again, **`dev` and `main` have diverged** with
   **duplicated commits**. At this point, please temporarily save the hash of
   the commit to which `dev` is currently pointing - you will need shortly.

   To get rid of the duplicated commits, we need to rebase `dev` on `main`.
   However, in this case, a regular rebase will *not* be able to automatically
   remove the duplicated commits (because they no longer exactly match on a
   one-to-one basis). Instead, a regular rebase would raise conflicts that you
   would then have to manually resolve.

   Since we know which commits are duplicated (all except the last 2 commits
   of `dev`), the **better approach here is to use interactive rebase** and
   manually instruct Git to drop the duplicated commits.  
   :pushpin:
   **Note:** an alternative approach would be to run `git rebase --skip` each
   time there is a conflict, to tell Git to skip the conflicting commit.

   :fire:
   **Tip:** after the rebase completed, to ensure that the rebase was performed
   properly and that **no changes/commits were lost** in the operation, you can
   run the command `git diff <hash before rebase> dev` (where
   `<hash before rebase>` is the hash you were asked to temporarily save
   earlier). This will compare the content of the repo as it was just before
   the rebase (i.e. when `dev` was pointing at `<hash before rebase>`), to its
   state after the rebase (i.e. current position of `dev`). If the rebase was
   done properly, **the diff should not yield any difference**.

   <br>

6. **Switch back to the `main` branch**. At this point, the history of your
   repo should look like this (commit ID values will differ):

    ```
    * be67a87 (dev) Maybe we should all switch to emacs...
    * 7c5827f Add image file showing a visual overview of vim modes
    * c778c05 (HEAD -> main) 7. Add 'command_mode' file: commands for vim's command mode
    * 8186e45 4. Add 'normal_mode' file: commands for vim's normal mode
    * c454a04 2. README: add vim modes and open file example
    * a818d5a 1. First commit of the vim cheat-sheet project. Add README file
    ```

<br>

### Additional Tasks (if you have time)

7. **We would like to fix a small bug** in the `README.md` and `normal_mode.md`
   files.  
   Proceed as follows:
    * Make sure you are on branch `main`.
    * In the `README.md` file, remove the line starting with `TODO:`.
    * In the `normal_mode.md` file, remove the last two lines that contain
      duplicated commands (the `dd` and `yy` commands are listed twice).
    * For *each* file to correct, create a `--fixup` commit (meaning you create
      2 fixup commits). You should
      **carefully select to which commit each of the fixup applies**.  
      :dart:
      **Hint:** to learn about the `--fixup` and `--autosquash` options, look
      at the supplementary material slides of the course.
    * Rebase (interactively) the branch `main` using the **`--autosquash`**
      option so that Git automatically adds the correct instructions and
      order for the `--fixup` commits.

   :dart:
   **Hint:** before the interactive rebase, your history on the `main` branch
   should look like this - notice the 2 **`fixup!`** commits
   (commit ID values will differ):
    ```
    * 542f88d (HEAD -> main) fixup! Add 'command_mode' file: commands for vim's command mode
    * f0d33d7 fixup! README: add vim modes and open file example
    * c778c05 7. Add 'command_mode' file: commands for vim's command mode
    * 8186e45 4. Add 'normal_mode' file: commands for vim's normal mode
    * c454a04 2. README: add vim modes and open file example
    * a818d5a 1. First commit of the vim cheat-sheet project. Add README file
    ```

    <br>

8. As we have once more modified `main`, **rebase `dev` on `main` again**.  
   :dart:
   **Hint:** to easily skip a commit, you can either use interactive rebase as
   we did earlier, or use a regular rebase and run **`git rebase --skip`** when
   a conflict arises (see also the message that Git is printing when a conflict
   is detected).

   After the rebase, switch back to the `main` branch and display the history
   of your repository. It should look like this (commit ID values will differ):
    ```
    * 062a1e2 (dev) Maybe we should all switch to emacs...
    * 07e7d86 Add image file showing a visual overview of vim modes
    * 9a0188b (HEAD -> main) 7. Add 'command_mode' file: commands for vim's command mode
    * 4c17a23 4. Add 'normal_mode' file: commands for vim's normal mode
    * 3becef8 2. Edit README file: add vim modes and open file example
    * a818d5a 1. First commit of the vim cheat-sheet project. Add README file
    ```

9. There are 2 more things you can try:
    * **Merge the first 2 commits of the repo** into a single one: for this
      you will need to use the **`--root`** option of the `git rebase` command
      (for details, see the course supplementary slides).
    * **Change the commit message** of the latest commit of the `dev` branch
      from `Maybe we should all switch to emacs...` to
      `Add xkcd comic image file`. You can do this easily with
      `git commit --amend`.


<br>
<br>
<br>


## Exercise 2 - The big reset [40 min]
**Objective:** get familiar with `git reset` and its `--mixed`, `--soft` and
`--hard` options. You will be using the following commands:
```sh
git init                      # Initialize new Git repo.
git add                       # Stage files (add files to Git index).
git commit                    # Create a commit.
git commit --amend --no-edit  # Amend the latest commit, without changing its commit message.
git switch --create           # Create a new branch and switch to it. `-c` is the short form for `--create`.
git reset --soft              # Reset while preserving the index and working tree.
git reset --mixed             # Reset while preserving only the working tree.
                              # Note: `--mixed` is the default option of `git reset`.
git reset --hard              # Reset everything: HEAD, index and working tree!
```
<br>

In this exercise, we will build a Git repo to keep track of our favorite
[Chuck Norris](https://en.wikipedia.org/wiki/Chuck_Norris) quotes :tada:.

:pushpin:
**Note:** in order show you some use cases of `git reset`, we will
**intentionally make some mistakes** along the way so that we can
then correct them. So don't be unsettled by the fact that this exercise keeps
asking you to change things: *it's by design*!

**Let's get started:**

1. Change into the `exercise_2/the_big_reset.git` directory, where you will
   find a number of files. Your first task is to turn this directory into a Git
   repository.

2. Stage the file `README.md`, then make a first commit with the commit message
   `"First commit"` (or any other message you like).

3. Stage the file `my_quotes.md`, and make a new commit with the message
   `"Add a file to keep track of quotes"`.

4. Wait, that last commit message is not nearly dramatic enough for what is
   about to unfold in this exercise. Let's change it to:
   `"Starting The Big Reset"`.  
   :pushpin:
   **Note:** while the optimal way to do this is using `git commit --amend`,
   we here suggest that you try to use **`git reset`** (with either the
   **`--soft`** or **`--mixed`** option).

5. Actually, there's still a thing we forgot: there is a
   `chuck_norris_quotes.txt` file in the repo - but we will not track it. So
   let's put that file on the list of files to be ignored by Git and make this
   change **part of the very first commit of the history** (in other words, the
   file you create to ignore `chuck_norris_quotes.txt` should be part of the
   first commit).

   :dart:
   **Hint:** you will need to use a combination of **reset** and **amending**,
   and then re-do the second commit.

   :sparkles:
   **Tip:** instead of re-doing the second commit, you could also delete the
   `my_quotes.md` file and then **cherry-pick** the `Starting The Big Reset!`
   commit you made earlier (this commit will be orphaned after you reset your
   `HEAD` to the first commit, but it can still be cherry-picked!). If you
   can't find its commit ID displayed in your shell, you can use the
   **`git reflog`** command to find it.
   <br>

6. Alright, fixing stuff is fun, but let's try to get some real work done here.
    * Open the `chuck_norris_quotes.txt` file and select your 3 favorite quotes.
    * Add each of your 3 quotes **successively** to the `my_quotes.md` file,
      making a new commit **each time** you add a quote.
    * So after that, you should have 3 additional commits in your history, and
      a total of 5 commits. Your git history should look like this (commit IDs
      will differ):
        ```txt
        * 5560a53 (HEAD -> main) Add 3rd favorite quote
        * e78e2ab Add 2nd favorite quote
        * 70c65be Add 1st favorite quote
        * c3d7850 Starting the Big Reset
        * e044feb First commit
        ```

7. With so many epic quotes to chose from, it a real shame we can chose only 3!
   But wait - Git has a solution for us: **branches**!.  
   Create an alternate branch named `second_choice` at the point in history
   where the `my_quotes.md` file was still empty and switch to it. Verify that
   `my_quotes.md` does indeed not contain any quotes.
   :owl:
   **Reminder:** by default, new branches are created at the current **`HEAD`**
   position, but you also create them at any arbitrary commit by passing the
   reference to that commit:
   ```sh
   git branch <branch name> <commit ref>
   git switch -c <branch name> <commit ref>  # Create new branch and switch to it.
   ```

8. Add 3 new Chuck Norris quotes to the `my_quotes.md` file, and commit. This
   time, we make a single commit with all quotes. Then, have a look at your
   repo's history with `git log --all --decorate --oneline --graph`
   (or `git adog`, if you have created this alias).

   You should see that your 2 branches have diverged, like so:
    ```txt
    * 23c0462 (HEAD -> second_choice) Add alternate favorite quotes
    | * 5560a53 (main) Add 3rd favorite quote
    | * e78e2ab Add 2nd favorite quote
    | * 70c65be Add 1st favorite quote
    |/  
    * c3d7850 Starting the Big Reset
    * e044feb First commit
    ```
    <br>

9. Upon reflection, why not put all of our favorite quotes (who said we could
   have only 3!) into the `my_quotes.md` file on the `main` branch.  
   To do this, **merge branch `second_choice` into `main`**. This will be a
   **3-way merge** (i.e. a non-fast-forward merge) - so get ready for some
   possible **conflict resolution** action.

10. After the merge is done, let's look at the history of our Git repo again
    with `git log --all --decorate --oneline --graph`. You can see that, as
    expected, the 3-way merge introduced an additional **merge commit** (the
    commit `c6b02ce` in our example below), so our history is not as clean as
    could be.
    ```
    *   c6b02ce (HEAD -> main) Merge branch 'second_choice'
    |\  
    | * 23c0462 (second_choice) Add alternate favorite quotes
    * | 5560a53 Add 3rd favorite quote
    * | e78e2ab Add 2nd favorite quote
    * | 70c65be Add 1st favorite quote
    |/  
    * c3d7850 Starting the Big Reset
    * e044feb First commit
    ```

    Can we fix it? *Yes, we can!*
     * Reset the repository to its state before the merge.
       :dart: **Hint:** time to put that `--hard` option to good use!.
     * Rebase `second_choice` on `main`, before merging `second_choice` into
       `main`.
    <br>

    When you are done, run `git log --all --decorate --oneline --graph` and
    marvel at your perfectly clean history (commit IDs will differ).
    ```
    * 9f554ad (HEAD -> main, second_choice) Add alternate favorite quotes
    * 5560a53 Add 3rd favorite quote
    * e78e2ab Add 2nd favorite quote
    * 70c65be Add 1st favorite quote
    * c3d7850 Starting the Big Reset
    * e044feb First commit
    ```

<br>
<br>
<br>


## Exercise 3 - The backport [30 min]
**Objective:** learn to use `git stash` and `git tag`, understand the
**detached HEAD mode**.

You are busy working on the `dev` branch of a data analysis pipeline, when you
get a message from a user: they want you to backport the support for a new type
of input data onto an old version of the pipeline (version `1.0.1`). You try to
argue that this is an old version with security vulnerabilities, and that they
should not use it anymore... but they *just don't care*. As a problem never
comes alone, they need this *right now*.

1. Change into `exercise_3/backport.git` and have a look at the Git
   repository's history. Note the different branches and tags.  
   **Reminder:** you can use `git log --all --decorate --oneline --graph` to
   display the entire repo's history - or `git adog`, if you have created this
   alias.

2. Implementing the backport is urgent, so you will finish your work on the
   `dev` branch later.  
   **Stash away any uncommitted change**, so you don't lose your hard work.
   Then go back to version `1.0.1` of the project.
    * :question:
      **Question:** where is the `HEAD` pointer now?
    * :question:
      **Question:** has anything else changed in the repository's history?
   <br>

3. Implement the backport fix:
    * In the file `functions.py`, add support for JSON files by changing the
      line `if extension in [".img", ".txt", ".csv"]:` to
      `if extension in [".img", ".txt", ".csv", ".json"]:` (see, writing
      software is easy!).
    * Commit your change.
   <br>

4. Go back to the `dev` branch. As you leave, you should see a warning message
   from Git.
    * :question:
      **Question:** what would happen to our latest commit if we "leave it behind"?
    * Take Git's advice and create a new branch named `backport` that points to
      the commit we just left behind.
    * While we are at it, let's also add a **tag** `v1.0.1b` to our new commit.
   <br>

5. Technically, after tagging our new commit with `v1.0.1b`, the `backport`
   branch is not really needed anymore, since a tagged commit will not be
   garbage collected. So let's delete this branch (using force deletion if
   needed).

6. That's it, we're done with the backport. Now we can finally get back to work
   on `dev`.
    * Restore the stashed content on `dev`.
    * Commit the change - you can use the commit message
      `Improve file import tests`.
   <br>

   At this point, your working tree should be clean and you Git history should
   look like this:
    ```
    * 0bc9428 (HEAD -> dev) Improve file import tests
    * a9096d0 Add tests for import module
    * fe0cdf5 Rename import module file
    * 08470b9 Add new module for file import
    | * 1a2fa0c (tag: v1.0.1b) Backport: add support for 'json' file type
    | | * b7d3e86 (main) Improve code documentation
    | | * 5efa0e0 (tag: v1.0.2) Improve tests
    | |/  
    |/|   
    * | 81fcc20 Add new module for file export
    |/  
    * d2c319e (tag: v1.0.1) Add tests
    * 8f93dc0 Add import_file() function
    * a67a81f Add random class
    * 7332db6 (tag: v0.0.1) Add first version of code
    * e3c1543 First commit. Add README
    ```

<br>

### Additional Tasks (if you have time)

7. Update the `main` branch with the new commits from `dev`:
    * Rebase your `dev` branch onto `main`, before merging it into `main`.
    * Add a new tag `v2.0.0` to the latest commit on `main`.
   <br>

   Your git history should now look like this:
   ```
   * 7f37744 (HEAD -> main, tag: v2.0.0, dev) Improve file import tests
   * 9065d06 Add tests for import module
   * cd61372 Rename import module file
   * c6859d4 Add new module for file import
   * b7d3e86 Improve code documentation
   * 5efa0e0 (tag: v1.0.2) Improve tests
   * 81fcc20 Add new module for file export
   | * 1a2fa0c (tag: v1.0.1b) Backport: add support for 'json' file type
   |/  
   * d2c319e (tag: v1.0.1) Add tests
   * 8f93dc0 Add import_file() function
   * a67a81f Add random class
   * 7332db6 (tag: v0.0.1) Add first version of code
   * e3c1543 First commit. Add README
   ```


<br>
<br>
<br>


## Exercise 4 - The treasure hunt [120 min]
**Objective:** collaborative exercise to review the Git commands and concepts
seen during the course.
* :pushpin:
  For participants who wish to receive **ECTS credits** for this course, this
  exercise also serves as **exam** - please see the instructions at the end of
  the exercise on how to submit your work.

<br>

### Introductory notes
**We have saved the best for last!** In this collaborative exercise, you will
**team-up with two fellow pirates** in order to retrieve the lost treasure of
the feared pirate [John Longsilver](https://en.wikipedia.org/wiki/Long_John_Silver).  
Get ready for a quest that will be *legend* ... wait for it ... *dary !!*

In your quests, you will be asked to follow a **collaborative workflow** that
uses the following branches:
* **`main`:** this is the **production branch**, i.e. the branch on which only
  final, production ready, material is published. Do *not* work directly on the
  `main` branch.
* Short-lived **personal branches** (feature branches) will be used by each
  team member to add their work, before merging it into `main`.
* Each **new release** of your work will be indicated by **a tag**.

:owl:
**Reminder:** if a divergence on the `main` branch occurs between you local
repo and the remote, you can either:
* **Rebase** your local changes in `main` onto `origin/main` (this is often
  the best solution, as it will give you a cleaner branch history than using
  a merge):
  ```sh
  git pull --rebase
  # Which, for the branch `main`, is the same as doing:
  git fetch
  git rebase origin/main
  ```
* **Merge** your local changes in `main` with `origin/main`:
  ```sh
  git pull --no-rebase
  # Which, for the branch `main`, is the same as doing:
  git fetch
  git merge origin/main
  ```
* **Hard reset** your local `main` branch to `origin/main`:
  `git reset --hard origin/main`.
  Use this **with caution**, as it can result in loss of local commits or
  loss of uncommitted changes to files.

:fire:
**Important** - please pay particular attention to the following points:
* Keep a **clean history** by avoiding unnecessary merges. Rebase branches to
  be merged before merging them whenever possible (unless explicitly instructed
  otherwise).
* Use **clear and meaningful commit messages** for your commits.
* **Delete temporary branches** that are no longer needed (e.g. a personal
  feature branch).
* **Make sure to fully, carefully, read the instructions and hints** given
  for each section, before starting the work.
* **Please ask for help** if you are stuck at any point, especially if you
  cannot solve one of the riddles (the objective is not to test your
  puzzle-solving abilities :bulb:).

<br>


### A) Organize your crew

1. **Get together:**
    * **On-site course:** locate your team members in the classroom and sit
      together so you can communicate.
    * **Online course:** you will be placed in a breakout-room with your
      teammates. Remember to use the "share screen" function to help each
      other or show to other team members what you are doing on your machine.

2. Organize your crew: within your pirate team, distribute the following roles:
   **Captain**, **Quartermaster** and **First-mate**. If your team is less than
   3 people, assign one person to multiple roles (e.g. one person is Captain
   and the other person is both Quartermaster and First-mate).

<br>


### B) Create a shared Git repo on GitHub/GitLab
The first thing you need to do before embarking on your quest is to
**setup a remote repository** for your crew on [GitHub](https://github.com).
You will use it as a shared remote repo to synchronize your local Git repos
within the team.

As you only need 1 remote for the entire team, the following instructions
should be carried-out **only by 1 member of the team**:
* In your browser, login to [GitHub](https://github.com) and then go to the
  public repository: https://github.com/sibgit/treasure-hunt
* You only have read-access to that repository, but for this exercise, you and
  your team will need a repository where you are allowed to both read and
  write.
  The solution here is to **fork the repository**. Forking allows
  you to get your own copy of a repository (under your GitHub account), on
  which you then have full ownership.
* **Fork the treasure-hunt repository** using the instructions given in the
  **helper slides of exercise 4**.
  * :fire:
    **Important:** make sure that to copy **all branches** when forking the
    repository. For this you must **uncheck "Copy the main branch only"**,
    which is enabled by default.
* Once the forked repo is created, the owner of the repo must **give access**
  to the **other team members**, who must **accept the invitation** to join
  the new repo (you will receive an email from GitHub/GitLab, or you can
  check the notifications in your GitHub/GitLab user account).

<br>

All team members can now go into their `exercise_4/` directory (which should
be empty), and **clone the treasure-hunt repository** that your team just setup
on GitHub.
* :fire:
  **Important:** make sure to clone the forked repository of your team, and
  *not* the original repo at https://github.com/sibgit/treasure-hunt.

:fire:
**IMPORTANT step for Windows users**
**(if you are on Linux or Mac, you should skip this step)**.
 Windows users only - run the following command *inside* the Git repository:
  ```sh
  git config core.filemode false
  # Do not add the `--global` flag, so that this change only affects the current repo.
  ```
 This will instruct Git to ignore differences in *execution permissions* of
 files, and is needed because Windows does not use the same file permission
 system as Linux/MacOS.


<br>


### C) Treasure hunt part one: sign the pirate code
Even pirates have rules! To avoid disputes at sea, you and your fellow pirates
should start your journey by carrying-out a little paperwork: signing the
[pirate code](https://en.wikipedia.org/wiki/Pirate_code).

Signing the **pirate code**, and thereby officializing your participation and
rank in the treasure hunt, is done by adding your name next to your role at the
bottom of the `pirate_code.md` file, which is located at the root of the Git
repo. Pay **particular attention to articles VIII, IX and X** of the contract!

1. **Sign the pirate code:**
    * Each pirate creates a new local personal branch (pointing at the latest
      commit of `main`): the personal branches should be named `add-crew-cp`
      (Captain), `add-crew-qm` (Quartermaster) and `add-crew-fm` (First-mate)
      respectively.
      * :pushpin:
        If one person of the group is having the role of multiple pirates
        (i.e. you are < 3 people in the team), then they should create only
        a single personal branch and do the work for all of their roles on
        that branch. This applies for all quests in this exercise.
    * On your personal branch, sign the pirate code by replacing `NAME HERE`
      with your name (on the line that is matching your rank).  
      :fire:
      **Important:** only sign for yourself, not for others!
    * Make a commit with a **meaningful commit message**.
    * In addition, the **First-mate** should make some changes to article I of
      the pirate code in order to get an equal share of the treasure! This
      change should be added as a new commit to the first-mate's personal
      branch.

2. **Share the signatures:** each pirate can now add their commit to the `main`
   branch by:
    * Pulling new changes on `main` from the remote.
    * **Rebasing** their personal branch on `main` (the first person to add
      their commit does in principle not need to do this).
    * **Merging** their personal branch into `main` - this should now be a
      *fast-forward* merge.
    * Pushing their changes on `main` back to the remote.
    * Inform other team members that they can now pull the changes on `main`
      (so that everyone stays in sync).
    * :sparkles:
      **Tip:** the best practice when merging changes into a shared branch
      such as `main` is to always fetch/pull changes on the branch before
      merging, to make sure that you are up-to-date. This is because in the
      real world, team members will not be contacting each other each time
      they push a change on `main`, and it's your responsibility to stay
      up-to-date.

3. **When everyone has added their changes to `main`** (and everyone has
   pulled the changes), the `pirate_code.md` file in everyone's local `main`
   branch should now contain the signatures of the entire crew.  
   To verify that things were done properly, run the following command
   (while on the `main` branch):
    ```sh
    # Note: you must be at the root of the Git repo to run this command.
    ./verify_contract.sh
    ```
   The names and ranks of all crew-members should be proudly displayed :tada:.

4. It's now time to **make a new "release"** of your work by adding a **tag**:
    * The **Quartermaster** should add a **tag** named **`contract-signed`** on
      the latest commit of `main`, then push the tag to the remote with:
        ```sh
        git push --tags
        ```
    * The **Captain** and the **First-mate** should then run `git fetch` to
      retrieve the newly added tag from the remote.
    * At this point, everyone should have the new tag in their local repo and
      everyone's `main` branch should be pointing to the same (latest) commit.
      Remember that you can use the command
      `git log --all --decorate --oneline --graph` to display your entire
      repo history along with tags.

5. Each pirate can now **delete their personal branch** in their local repo.
    * :owl:
      **Reminder:** if you pushed your personal branch to the remote, you can
      delete it on the remote with `git push origin --delete <branch name>`.

That's it, the paperwork is done! Let's get on that ship and sail! :skull:

<br>


### D) Treasure hunt part two: gear-up!
Wait... did I just say "get on that ship"? Well, the problem is that...
there is no ship... yet! And we will need a flag too! And rum of course, lots
of rum for this long journey.

The second part of this quest is therefore to find those 3 items: **a ship**,
**a flag**, and **rum bottles**. You are 3 in the team, so split the task:
* The **Captain** will search for the **ship**.
* The **Quartermaster** will search for the **flag**.
* The **First-mate** will search for **rum bottles**.

This is how you should proceed:

1. As for the first quest (*Signing the pirate code*), each pirate should
   **create a new personal branch** to work on this quest: `add-supplies-cp`
   (Captain), `add-supplies-qm` (Quartermaster) and `add-supplies-fm`
   (First-mate).  
   As usual, the personal branches should initially be rooted on the latest
   commit of `main`.

2. If you look at the history of the repo, you will see that it has several
   branches that correspond to different locations:
   **`port-royal`**, **`oyster-bay`** and **`blackbird-castle`**.
   **Visit these different locations (by switching to the relevant branch)**
   and ask local pirates for a hint of where you can find the ship, flag and
   rum bottles by running the following command
   in your shell:
    ```sh
    ./ask_a_pirate.sh
    ```

   :dart:
   **Hints:**
    * **Locations in hints given by local pirates correspond to commits!**
      Look at the history of the `port-royal`, `blackbird-castle`, and
      `oyster-bay` branches to find the commit where an item is hidden (based
      on the hints you received from the local pirates).
    * Each item to find corresponds to a file: `ship.ascii`, `flag.ascii` and
      `rhum.ascii`.
      These files **are located in a subdirectory named `supplies/`**.
    * :owl:
      **Reminder:** to see the content of a commit, you can:
      * Use **`git checkout <commit ref>`** to checkout the content of the
        commit. You then enter *detached HEAD mode*, which you can leave by
        switching back to a regular branch (e.g. your personal work branch).
      * Use **`git show <commit ref>`** to show the changes added by a commit.
   <br>

3. Once you have located the commit with the item you are looking for, you
   should **add it to your personal branch by cherry-picking** it onto your
   personal branch.

4. **Merge your personal branch into `main`** and push your changes on `main`
   to the remote.
    * Us the same procedure as in the first part of the quest - see **point 2**
      of *Treasure hunt part one: sign the pirate code* if you need a refresher.
    * :fire:
      If needed, make sure to **rebase your branch** before merging it (to
      keep a cleaner history).

5. After all pirates have added their commit and updated their repo, everyone's
   `main` branch should have 3 new commits (one made by each team member), and
   the 3 files `ship.ascii`, `flag.ascii` and `rhum.ascii` should be present in
   the `supplies/` directory.

6. **Verify that you have all your gear** by running the command (on the
   `main` branch):
    ```sh
    # Note: you must be at the root of the Git repo to run this command.
    ./verify_supplies.sh
    ```
   If your ship is loaded with the correct supplies, a success message will be
   displayed. :flags:

7. If everyone got a success message, it's time to **make a new release** of
   your work:
    * The **First-mate** should add a **tag** named **`ready-to-sail`** on the
      latest commit of `main`, then push the tag to the remote with the
      command:
        ```sh
        git push --tags
        ```
    * The **Captain** and the **Quartermaster** should then run `git fetch` to
      retrieve the newly added tag from the remote.
    * At this point, everyone should have the new tag in their local repo and
      everyone's `main` branch should be pointing to the same (latest) commit.

8. Each pirate can now **delete their personal work branch**.

The ship is loaded and the flag is flying - now we're talking! All hands on
deck and keep the powder dry - get ready for the final step of this
*gitventure*: finding **the treasure!** :whale:

<br>


### E) Treasure hunt part three: visit Skull Rock island to find the treasure
Start by setting sail on `skull-rock-island` (i.e. switch to the branch). The
island was home to **John Longsilver** - a fearsome pirate with a healthy
appetite for treasures. Unfortunately, pirate lives do sometimes take a turn
for the shorter, and so did Longsilver's.

While Longsilver is no more, his **trusty parrot** - a talkative bird if there
ever was one! - is still very much alive. Maybe that bird has some recollection
of where Longsilver has been hiding his treasure?

To hear what the parrot has to say, run the following command in your shell:
 ```sh
 ./listen_to_parrot.sh
 ```
As you can see for yourself, the parrot isn't being helpful... but we can
change this, with a little... rebasing!

Proceed as follows:
 1. **Switch** to the branch `work-in-progress`.
 2. **Squash the commit** `Update the parrot's talking` into the commit
    `Make the parrot more cooperative` using **interactive rebase**: these
    two commits should become a single commit (use the **`fixup`** instruction
    to squash the commits).
 3. **Rebase** the `work-in-progress` branch on `skull-rock-island`. If a
    conflict arises during the rebase, keep the version coming from the
    `work-in-progress` branch (the version that starts with the line
    `# Parrot remembers stuff...`).
 4. After the rebase is completed, run again:
     ```sh
     ./listen_to_parrot.sh
     ```
    The bird should now be more cooperative and give you some hints on where to
    look for **the keys to unlock the treasure chest**.
 5. In addition, you should now also have a new directory named
    `treasure_chest` at the root of your working tree (i.e. working directory).
    You can verify this by running the command `ls -l` in your working
    directory.

To bring the treasure chest aboard your ship, the **First-mate** should do the
following (:fire: **Important:** only the **First-mate** should perform this
task, not the other pirates. Otherwise you will get diverging versions on the
`main` branch):
 1. **Merge `work-in-progress` into `main`**. This will add the treasure chest
    to the `main` branch - along with your new friend the parrot!
 2. **Push the changes** on branch `main` to the remote.

The **Captain** and **Quartermaster** can now update their local repos with the
changes that the **First-mate** just pushed to `main`. At this point everyone
should be synchronized on their `main` branch and have the treasure onboard.

Congratulations, you're *almost* there! Let's celebrate this with a
**new release**:
 * The **Captain** should add a tag named **`treasure-found`** and push it to
   the remote with:
    ```sh
    git push origin --tags
    ```
 * Everyone else can then run `git fetch` to get the new tag.

Alright, let's see what John Longsilver has been hiding in his treasure. To
open it, run:
```sh
# Note: you must be at the root of the Git repo to run this command.
./open_chest.sh
```
*Shiver me timbers!* We are missing **the keys** to open the lock!

<br>

:pushpin:
**Note:** If you are running out of time, you can finish this last part of the
exercise on your own. You simply have to find the 3 keys for the treasure on
your own.

<br>


### F) Treasure hunt final part: opening the treasure
We are now looking for the **3 keys to open the 3 locks of the chest**. To find
where they are hidden, listen to the parrot's hints by running the command:
```sh
./listen_to_parrot.sh
```
Then go back to `port-royal`, `blackbird-castle` and `oyster-bay` to find the
keys.

:dart:
**Hints - please read this carefully _before_ you begin:**
* Unlike in the previous quest, the locations that the parrot gives in its
  hints correspond here to **directories** on disk - *not* to commits!
* The **keys** are files that have the name of the object that contains them or
  is near them. E.g. a file named `candle` would be the "key" file if you think
  that the key is near a candle.
* Each key file must be placed in the correct lock directory, and renamed to
  the correct name:
  * **Key 1** must be placed into `treasure_chest/lock_1` and named `key_1`.
  * **Key 2** must be placed into `treasure_chest/lock_2` and named `key_2`.
  * **Key 3** must be placed into `treasure_chest/lock_3` and named `key_3`.
* Once you have located the correct file (based on the hints given by the
  parrot), **checkout** the file to the `main` branch. Then rename and move it
  to the correct location (see above), and make a new commit.
  * To **retrieve/checkout a single file** from another branch use the command:
    ```sh
    git restore --source=<branch name> <path/to/file>
    ```
    For this exercise, you must run the command while located at the root of
    the working tree (i.e. at the root of `treasure_hunt.git`).
  * To move and rename the file, use the command:
    ```sh
    mv <path/to/file> treasure_chest/lock_1/key_1  # For key 1
    mv <path/to/file> treasure_chest/lock_2/key_2  # For key 2
    mv <path/to/file> treasure_chest/lock_3/key_3  # For key 3
    ```
  * After the file is moved and renamed, you can stage it and make a commit.
* :bomb:
  **Do not modify the content of the key file in any way, this would destroy it**.

As before, this can be done as teamwork and each pirate retrieves one of the
keys. This time however, **to save time** (and because we believe that by now
you have understood the principle), you may
**add your commit directly to the `main` branch**, without creating a temporary
working branch (*crazy!* - I know :sunglasses:).
Make sure to actively coordinate with your team mates so that your `main`
branch is up-to-date before you add a commit to it: you don't want any
divergence in the `main` branch among the team!  

When each pirate has added their key to `main`, and everyone has updated their
local Git repo copies, you can try to **open the treasure again**:
```sh
# Note: you must be at the root of the Git repo to run this command.
./open_chest.sh
```
If the keys are the correct files, have been placed in the correct lock, and
have been correctly renamed, **the treasure should open**!
:tada: :moneybag: :fireworks:

<br>

### For people doing this exercise as an exam :memo:
If you would like to receive credits for the course, please do the following
within 3 days of the end of the course (or whatever deadline has been
agreed-upon during the course):
1. **Take a screenshot** of the output of your Git repo's full history (use
   `git log --all --decorate --oneline --graph`) at the end of your quest.
2. **Create a new branch** named `exam-YOUR_FULL_NAME` rooted on the latest
   commit of `main` (replace `YOUR_FULL_NAME` with your actual name). Add a
   commit with your screenshot to this new branch and push it to the remote.
3. **Send an email** with subject "Git course exam - your name" to the teacher
   of the course with the following information:
    * Your **full name**.
    * The **URL of the remote repo** that you have used for this exercise. The
      repo must be public.
    * The **secret code** you found when opening the chest.
   :pushpin:
   The teacher's email address can be found at the top of the shared document
   used for the class.
4. **Make sure you have signed-up for the exam** on the Google doc of the
   course by highlighting your name in green.

<br>
<br>
<br>
