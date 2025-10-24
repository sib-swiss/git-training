# Exercises - Git advanced topics

<br>

## Before you start

* 📚 **Exercise material setup:** download the
  [exercises_advanced.zip](../exercises/exercises_advanced.zip) file to
  your local computer and unzip it.

* ✏️ **Additional Tasks:** at the end of exercises, you will sometimes find a
  section named **Additional Tasks**. These sections contain tasks to complete
  **if you have the time and after having completed the main exercise**.
  Additional tasks sections will not be corrected in class, but their solution
  is given in this document.

* ✅ **Exercise solutions:** all exercises and additional tasks section have
  their solution embedded in this document. Solutions are hidden by default,
  but you can reveal them by clicking on them. Here is an example:

  <details><summary><b>Solution (click to reveal)</b></summary>
  🌈 This reveals the answer 🌈
  </details>

  We encourage you to **not look at the solutions too quickly**, and try to
  solve the exercises without them. Remember that you can always ask the
  course teachers for help.

* ✨ **Tip:** if you are viewing these instructions on GitHub, you can display
  a table of content (outline) of this page by clicking on the small icon that
  looks like a bulleted list near the top-right of this page.

<br>
<br>

## Exercise 1 - The vim cheat-sheet [40 min]

🚀 **Objective:** learn to use **interactive rebase**.

> **Command summary**  
> Here are the main commands you will need for this exercise.
>
> ```sh
> git rebase                 # Rebase a branch.
> git rebase --interactive   # Interactively rebase a branch.
> git switch                 # Switch to a different branch.
> ```

> 💡 **Disclaimer**
>
> In this exercise we will be **rewriting history on the `main` branch**
> of our repository. In a _production_ environment, this
> **should in principle be avoided**.

<br>

### Part A) Re-ordering commits in history

Believe it or not, you have just been hired for a clean-up job 🕵️! No, not
the movie kind, but don't worry, this will still be great.

Your task is to clean up the history of a Git repository that contains
instructions on how to use the `vim` editor.

1. Enter the `exercise_1/vim_cheatsheet` repository and have a look at its
   **commit history**.

   > ✨ **Tip:** if you are using (or would like to use) `vim` as an editor in
   > Git, you can have a look at the content of the files in the repository to
   > learn about some useful `vim` commands.
   >
   > Of course this only scratches the surface. If you have too much time
   > on your hands, you can also try
   > [vim-adventures](https://vim-adventures.com) to learn `vim` commands
   > by playing.

    <br>
    <details><summary><b>✅ Solution</b></summary>

    ```sh
    cd exercise_1/vim_cheatsheet                # Enter exercise directory.
    git log --all --decorate --oneline --graph  # Show history of repo and branches.
    cat *.md                                    # Display the content of all .md files.

    # If we want to also look at the "dev" branch:
    git switch dev   # Switch to `dev` branch.
    ls -l            # List the content of the directory (now in `dev` branch).
    git switch main  # Go back to branch `main`.
    ```

    </details>
    <br>

2. Looking at the **commit history** on the `main` branch, you will see that
   the edits to the different files are all over the place.

   To make things more tidy, we first would like to group (in the history's
   chronology) the edits to each of the 3 files: `README.md`, `normal_mode.md`
   and `command_mode.md`.

   Using **interactive rebase**, your first task is to **re-order the commits**
   on the `main` branch in the following order (here listed from oldest to
   newest):

   ```txt
    1. First commit of the vim cheat-sheet project. Add README file
    2. Edit README file
    3. Edit README file: add open file example
    4. Add 'normal_mode' file: commands for vim's normal mode
    5. Edit 'normal_mode' file: add 'dd' and 'yy' commands
    6. Edit 'normal_mode' file: add more commands
    7. Add 'command_mode' file: commands for vim's command mode
    8. Edit 'command_mode' file: add more commands
   ```

   > 🦉 **Reminder:** in the interactive rebase file, the order of commits
   > is oldest to newest, from top to bottom.

   > 🌈 **Note:** re-ordering commits is only possible if they are independent
   > from each other.
   >
   > In this exercise, we are re-ordering commits that affect completely
   > different files, but we are keeping the order of commits that affect the
   > same file **in the same relative order**, because they
   > "build on each other". E.g. we could _not_ have the commit that edits
   > the file `normal_mode.md` before the commit that creates it.

<br>
<details><summary><b>✅ Solution</b></summary>
Start the interactive rebase with the following command:

```sh
git rebase -i a818d5a
```

Edit the interactive rebase commit list. It should look like this (blank
lines are optional):

```txt
pick 91aa2f3 2. Edit README file
pick 21d712d 3. Edit README file: add open file example

pick 9c7f8b4 4. Add 'normal_mode' file: commands for vim's normal mode
pick be7f832 5. Edit 'normal_mode' file: add 'dd' and 'yy' commands
pick ac17969 6. Edit 'normal_mode' file: add more commands

pick c110031 7. Add 'command_mode' file: commands for vim's command mode
pick d95eb3d 8. Edit 'command_mode' file: add more commands
```

</details>
<br>

3. After you are done with the re-ordering, **display the history** of your
   repo:

    ```sh
     # You can also use `git adog` if you created this alias.
     git log --all --decorate --oneline --graph
    ```

   You should see that branch `dev` still contains the two "old" commits
   (`9c7f8b4` and `c110031`) from the shared history it had with the `main`
   branch before the rebase. These two commits are now duplicated between the
   two branches.

   To get rid of them, **rebase `dev` on `main`**, then return to `main`.

   > 🌈 **Note:** after the rebase completed, you should observe that Git
   > automatically **skipped the duplicated commits** on `dev`, because they
   > have the exact same content as their counterparts on `main`. Git lets us
   > know that the commits were skipped via the following warning:
   >
   > ```txt
   > warning: skipped previously applied commit 9c7f8b4
   > warning: skipped previously applied commit c110031
   > ```

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# Rebase `dev` on `main`. This automatically gets rid of the duplicated
# commits that are left on `dev`.
git switch dev
git rebase main

# Display history of repo to see how it looks like after the rebase.
git log --all --decorate --oneline --graph

# Return on branch `main`.
git switch main
```

</details>
<br>

### Part B) Squashing/merging commits

All things considered, our repo history would look cleaner if, for each file,
we had a **single commit** rather than having multiple small and incremental
commits.

Make the following changes to the repo history:

* **For each file, squash/merge the different commits** so that your history
  looks like what is shown below (the oldest commit is listed at the bottom).
* **Change** the commit message of the commit adding the README file to:
  `README: add vim modes and open file example`.

    ```txt
    * 7. Add 'command_mode' file: commands for vim's command mode
    * 4. Add 'normal_mode' file: commands for vim's normal mode
    * 2. README: add vim modes and open file example
    * 1. First commit of the vim cheat-sheet project. Add README file
    ```

   > 🔥 **Important:** note that the commit message for the second commit is
   > a new message. You will thus need to
   > **edit the commit message during the rebase**.

   > 🌈 **Note:** the `README.md` file still has 2 commits - because its first
   > commit is also the first commit of the repo (and that first commit is more
   > difficult - but not impossible - to change).

<br>
<details><summary><b>✅ Solution</b></summary>

To merge the different commits for each file, we again run an interactive
rebase on the first commit `git rebase -i HEAD~7` (or `git rebase -i a818d5a`).

To merge and rename the commits 2 and 3, there are two possibilities:

* **Use the command `squash / s`** to squash the commits into their parents.
  With this option, Git will open an editor at each squash operation and
  ask us to edit/confirm the commit message manually.  
  
  The edited rebase instructions should look like this (`s` is for `squash`
  and `f` is for `fixup`):

  ```txt
  pick 9cf4b60 2. Edit README file
  s fa952bb 3. Edit README file: add open file example
  pick 32d2385 4. Add 'normal_mode' file: commands for vim's normal mode
  f f4001cc 5. Edit 'normal_mode' file: add 'dd' and 'yy' commands
  f 21a503e 6. Edit 'normal_mode' file: add more commands
  pick 87dc1eb 7. Add 'command_mode' file: commands for vim's command mode
  f 62c8c02 8. Edit 'command_mode' file: add more commands
  ```

* **Use the command `fixup/f`** to automatically discard the message of the
  commit being squashed into its parent. In this case we have to use
  **`reword / r`** for the first commit of the list, since we were explicitly
  asked in the exercise to change the commit message for this
  commit to `README: add vim modes and open file example`.

  The edited rebase instructions should look like this (`r` is for `reword`
  and `f` is for `fixup`):

  ```txt
  r 9cf4b60 2. Edit README file
  f fa952bb 3. Edit README file: add open file example
  pick 32d2385 4. Add 'normal_mode' file: commands for vim's normal mode
  f f4001cc 5. Edit 'normal_mode' file: add 'dd' and 'yy' commands
  f 21a503e 6. Edit 'normal_mode' file: add more commands
  pick 87dc1eb 7. Add 'command_mode' file: commands for vim's command mode
  f 62c8c02 8. Edit 'command_mode' file: add more commands
  ```

</details>
<br>

### Part C) Rebase and remove duplicated commits

If you **display the history** of your repo:

```sh
# You can also use `git adog` if you created this alias.
git log --all --decorate --oneline --graph
```

You will see that, again, **`dev` and `main` have diverged** with
**duplicated commits**.

> 🔥 **Important:** at this point, please temporarily save the hash of
> the commit to which `dev` is currently pointing - you will need shortly.

To get rid of the duplicated commits, we need to **rebase `dev` on `main`**.
However, in this case, a regular rebase will _not_ be able to automatically
remove the duplicated commits, because they no longer exactly match on a
one-to-one basis. As a result, a regular rebase would raise conflicts that we
would then have to manually resolve - doable, but not pleasant 😅.

Luckily, we have an ace up our sleeve: we know which commits are duplicated -
all except the last 2 commits of `dev`. The better approach is therefore to
simply drop these commits in an interactive rebase:

1. Do an **interactive rebase** of `dev` on `main`, and instruct Git to
   **drop the duplicated commits**.

    > 🦉 **Reminder:** to instruct Git to drop a commit in an interactive
    > rebase, we can either use the **`d / drop`** instruction, or delete the
    > line of the commit.

2. To ensure that the rebase was performed properly and that
   **no changes/commits were lost** in the operation, you can run the
   following command:

    ```sh
    git diff <hash before rebase>
    ```

   Where `<hash before rebase>` is the hash you were asked to temporarily
   save earlier.

   This will compare the content of the repo as it was just before the rebase
   to its state after the rebase. If the rebase was done properly,
   **the diff should not yield any difference**.

3. **Switch back to the `main` branch**. At this point, the history of your
   repo should look like this (commit ID values will differ):

    ```txt
    * be67a87 (dev) Maybe we should all switch to emacs...
    * 7c5827f Add image file showing a visual overview of vim modes
    * c778c05 (HEAD -> main) 7. Add 'command_mode' file: commands for vim's command mode
    * 8186e45 4. Add 'normal_mode' file: commands for vim's normal mode
    * c454a04 2. README: add vim modes and open file example
    * a818d5a 1. First commit of the vim cheat-sheet project. Add README file
    ```

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# 1. Rebase `dev` on `main`.
git switch dev
git rebase -i main
```

The rebase instructions list to only keep the 2 non-duplicated commits
should look like this:

```txt
pick 7c5827f Add image file showing a visual overview of vim modes
pick be67a87 Maybe we should all switch to emacs...
```

```sh
# 2. Make sure the output of `git diff` is empty.
git diff <hash before rebase>

# 3. Switch back to `main` and display repo history.
git switch main
git log --all --decorate --oneline --graph
```

> 🌈 **Note:** an alternative approach would be to make a regular rebase,
> and run `git rebase --skip` each time there is a conflict to tell Git to
> skip the conflicting commit.

</details>
<br>

### Additional Tasks: fixup commits and `--autosquash` ✏️

Since we are cleaning things up, let's also **fix a small bug** in the
`README.md` and `normal_mode.md` files. Proceed as follows:

* Make sure you are on branch `main`.
* In the `README.md` file, remove the line starting with `TODO:`
* In the `normal_mode.md` file, remove the last two lines that contain
  duplicated commands (the `dd` and `yy` commands are listed twice).
* For _each_ file to correct, create a `--fixup` commit (meaning you create
  2 fixup commits). You should
  **carefully select to which commit each of the fixup applies**.
* Rebase `main` using the **`--autosquash`** option, so that Git
  automatically squashes the `--fixup` commits into the correct commits.

> 🎯 **Hints**
>
> * To learn about the `--fixup` and `--autosquash` options, look at the
>   supplementary material slides of the course (or ask the trainer).
>
> * _Before_ the interactive rebase, your history on the `main` branch should
>   look like this (note the 2 `fixup!` commits):
>
>    ```txt
>    * 542f88d (HEAD -> main) fixup! Add 'command_mode' file: commands for vim's command mode
>    * f0d33d7 fixup! README: add vim modes and open file example
>    * c778c05 7. Add 'command_mode' file: commands for vim's command mode
>    * 8186e45 4. Add 'normal_mode' file: commands for vim's normal mode
>    * c454a04 2. README: add vim modes and open file example
>    * a818d5a 1. First commit of the vim cheat-sheet project. Add README file
>    ```

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# Display the repo's status: it will show that README.md and normal_mode.md
# have been modified.
git status

# Commit changes to these files in two different "fixup" commits:
git commit --fixup=HEAD~2 README.md
git commit --fixup=HEAD~1 normal_mode.md

# Perform the rebase with the "--autosquash" option enabled.
git rebase --autosquash HEAD~5

# To check the result.
git log --all --decorate --oneline --graph
```

> 🌈 **Note:** since we made `--fixup` commits, we do not necessarily have
> to use the `--interactive / -i` option of rebase, because `--autosquash`
> will do to work of squashing them for us anyway.
>
> Nevertheless, we could also have run
> `git rebase --interactive --autosquash HEAD~5` had we wanted to double check
> or make some additional changes.

</details>
<br>

As we have once more modified `main`, **rebase `dev` on `main`** again.

> 🎯 **Hint:** to easily skip a commit, you can either use interactive
> rebase as earlier, or use a regular rebase and run **`git rebase --skip`**
> when a conflict arises (see also the message that Git is printing when a
> conflict is detected).

After the rebase, switch back to the `main` branch and display the history
of your repository. It should look like this (commit ID values will differ):

```txt
* 062a1e2 (dev) Maybe we should all switch to emacs...
* 07e7d86 Add image file showing a visual overview of vim modes
* 9a0188b (HEAD -> main) 7. Add 'command_mode' file: commands for vim's command mode
* 4c17a23 4. Add 'normal_mode' file: commands for vim's normal mode
* 3becef8 2. Edit README file: add vim modes and open file example
* a818d5a 1. First commit of the vim cheat-sheet project. Add README file
```

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# Switch to the branch to rebase.
git switch dev

# Interactive rebase of `dev` on `main`.
# Important: discard all duplicated commits in the rebase file.
git rebase -i main

# Switch back to main.
git switch main
```

</details>
<br>

Finally, there are 2 more things you can try:

* **Merge the first 2 commits of the repo** into a single one: for this
  you will need to use the **`--root`** option of the `git rebase` command
  (for details, see the course supplementary slides).
* **Change the commit message** of the latest commit of the `dev` branch
  from `Maybe we should all switch to emacs...` to
  `Add xkcd comic image file`. You can do this easily with
  `git commit --amend`.

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# Merge the first two commits.
git rebase -i --root main

# Change the commit message of latest `dev` commit.
git switch dev
git commit --amend -m "Add xkcd comic image file"
```

</details>

<br>
<br>
<br>

## Exercise 2 - The big reset [40 min]

🚀 **Objective:** get familiar with `git reset` and its `--mixed`, `--soft` and
`--hard` options.

> **Command summary**  
> Here are the main commands you will need for this exercise.
>
> ```sh
> git commit --amend --no-edit  # Amend the latest commit, without changing its commit message.
> git reset --soft              # Reset while preserving the index and working tree.
> git reset --mixed             # Reset while preserving only the working tree. `--mixed` is the default
> git reset --hard              # Reset everything: HEAD, index and the working tree.
> ```

> 💡 **Disclaimer:** in order show you some use cases of `git reset`, we will
> in this exercise **intentionally make some mistakes** along the way, so that
> we can then correct them. So don't be unsettled by the fact that this
> exercise keeps asking you to change things: _it's by design_ !

<br>

### Part A)

In this exercise, we will build a Git repo to keep track of our favorite
[Chuck Norris](https://en.wikipedia.org/wiki/Chuck_Norris) quotes. 🎉

Will this really be as useless as it sounds ? Let's find out:

1. Enter the `exercise_2/the_big_reset` directory and initialize a new Git
   repository.

2. Stage the file `README.md`, then make a first commit with the commit message
   `"First commit"` (or any other message you like).

3. Stage the file `my_quotes.md`, and make a new commit with the message
   `"Add a file to keep track of quotes"`.

4. Wait, that last commit message is not nearly dramatic enough for what is
   about to unfold in this exercise. Let's change it to:
   `"Starting The Big Reset"`.

   > 🌈 **Note:** while the optimal way to do this is using
   > `git commit --amend`, we here suggest that you try to use **`git reset`**
   > (with either the **`--soft`** or **`--mixed`** option).

5. Actually, there's still a thing we forgot: there is a
   `chuck_norris_quotes.txt` file in the repo - but we will not track it. So
   let's put that file on the list of files to be ignored by Git and make this
   change **part of the very first commit of the history** (in other words, the
   file you create to ignore `chuck_norris_quotes.txt` should be part of the
   first commit).

   > 🎯 **Hint:** you will need to use a combination of **reset** and
   > **amending**, and then re-do the second commit.

   > ✨ **Tip:** instead of re-doing the second commit, you could also delete
   > the `my_quotes.md` file and then **cherry-pick** the
   > `Starting The Big Reset!` commit you made earlier. This commit will be
   > orphaned after you reset your `HEAD` to the first commit, but it can
   > still be cherry-picked ! 👻
   >
   > If you can't find the commit ID of the commit to cherry-pick displayed
   > somewhere in your shell, you can use the **`git reflog`** command to find
   > it.

   <br>

<br>
<details><summary><b>✅ Solution</b></summary>

1-3. Initialize a new Git repo and make the first 2 commits:

```sh
# 1. Initialize a new Git repo.
cd exercise_2/the_big_reset
git init

# 2. Make a first commit with the `README.md` file.
git add README.md
git commit -m "First commit"

# 3. Make a second commit with the `my_quotes.md` file.
git add my_quotes.md
git commit -m "Add a file to keep track of quotes"
```

4. Amend the commit message of the last commit using "git reset":

```sh
git reset --soft HEAD~1
git commit -m "Starting The Big Reset!"
git log --pretty=oneline                 # To check the commits message was changed.
```

> 🌈 **Notes**
>
> * Since we want to change the commit message (but not the actual content), we
>   use the **`--soft`** option of `git reset`: this resets the `HEAD` to the
>   specified position (in this case `HEAD~1` - the parent of the last commit),
>   but does not modify the git index. As a result, the staged content is
>   already there and we can simply commit.
>
> * Comparing the commit ID values of the second commit before and after having
>   amended its commit message, we can see that they are different, despite the
>   two commits having the same content and commit message.
>
>   The reason is because they were made at a different time, and since time is
>   part of the commit metadata used to compute the commits' SHA-1 hash value,
>   the commit ID values differ.
>
> * In principle the best solution for this task would be to use:
>
>    ```sh
>    git commit --amend -m "Starting The Big Reset"
>    ```
>
>   But the idea of the exercise was to train the **`git reset`** command.

<br>

5. Ignore the `chuck_norris_quotes.txt` file.

```sh
# Create a .gitignore file and add the name of the file to ignore to it.
echo "chuck_norris_quotes.txt" > .gitignore

# Add the .gitignore file to the first commit. We do this by resetting the
# HEAD to the first commit, then amending that first commit.
git reset --mixed HEAD~1   # This is the same as "git reset HEAD~1",
                           # since "--mixed" is the default option.
git add .gitignore
git commit --amend --no-edit

# Display the content of the amended commit to verify that the
# .gitignore file is now part of it.
git show HEAD

# Redo the second commit.
git add my_quotes.md
git commit -m "Starting The Big Reset!"

# Alternatively, we can cherry-pick our initial commit number 2.
rm my_quotes.md              # Needs to be deleted to avoid conflict.
git cherry-pick <commit ID>
```

</details>
<br>

### Part B) Add Chuck Norris quotes

Alright, fixing stuff is fun, but let's try to get some real work done here.

* **Open the `chuck_norris_quotes.txt` file** and chose your 3 favorite
  quotes.
* Add each of your 3 quotes **successively** to the `my_quotes.md` file,
  making a new commit **each time** you add a quote.
* You should now have 3 additional commits in your history, and a total of 5
  commits. Your git history should look like this (commit IDs will differ):

    ```txt
    * 5560a53 (HEAD -> main) Add 3rd favorite quote
    * e78e2ab Add 2nd favorite quote
    * 70c65be Add 1st favorite quote
    * c3d7850 Starting the Big Reset
    * e044feb First commit
    ```

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# Add our 3 favorite quotes in 3 different commits.
echo -e "When Chuck Norris does division, there are no remainders.\n" >> my_quotes.md
git commit -m "Add 1st favorite quote" my_quotes.md
echo -e "When Chuck Norris throws exceptions, it’s across the room.\n" >> my_quotes.md
git commit -m "Add 2nd favorite quote" my_quotes.md
echo -e "'I don't always test my code. But when I do, I do in production' - Chuck Norris\n" >> my_quotes.md
git commit -m "Add 3rd favorite quote" my_quotes.md
```

</details>
<br>

With so many epic quotes to chose from, it a real shame we can chose only 3...
But wait - Git has a solution for us: **branches** ! 🌱

1. Create an alternate branch named `second_choice` at the point in history
   where the `my_quotes.md` file was still empty and switch to it. Verify that
   `my_quotes.md` does indeed not contain any quotes.

   > 🦉 **Reminder:** by default, new branches are created at the
   > current **`HEAD`** position. But you also create them at any arbitrary
   > commit by passing the reference to that commit:
   >
   > ```sh
   > git branch <branch name> <commit ref>     # Create new branch.
   > git switch -c <branch name> <commit ref>  # Create new branch and switch to it.
   > ```

2. Add 3 new Chuck Norris quotes to `my_quotes.md` and commit the changes. This
   time, make a single commit with all quotes.
3. Have a look at your repo's history again:

    ```sh
     # You can also use `git adog` if you created this alias.
     git log --all --decorate --oneline --graph
    ```

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
<details><summary><b>✅ Solution</b></summary>

```sh
# 1. Create a new branch at the second commit. Note that with `switch -c` we
#    create the branch and check it out at the same time.
git switch -c second_choice HEAD~3
cat my_quotes.md                    # Verify there are no quotes in the file.

# 3. Add 3 other quotes in a single commit.
echo -e "Chuck Norris can divide by zero.\n" >> my_quotes.md
echo -e "Chuck Norris never gets a syntax error. Instead, the language gets \
a DoesNotConformToChuck error.\n" >> my_quotes.md
echo -e "Chuck Norris doesn't wear a watch. He simply decides what time it is.\n" >> my_quotes.md
git commit -m "Add alternate favorite quotes" my_quotes.md

# 3. Display repo history.
git log --all --decorate --oneline --graph
```

</details>
<br>

### Part C) Hard reset

Upon reflection, why not put all of our favorite quotes (who said we could
have only 3!) into the `my_quotes.md` file on the `main` branch.

1. **Merge the branch `second_choice` into `main`**. This will be a
   **3-way merge** (i.e. a non-fast-forward merge) - so get ready for some
   possible **conflict resolution** action.

    <details><summary><b>✅ Solution</b></summary>

    ```sh
     # Start the merge...
     git switch main
     git merge second_choice

     # ... but there is a conflict, so we need to solve it manually...
     vim my_quotes.md

     # ... after the conflict is solved, we stage the modifications and run
     # `git commit` to finish the merge.
     git add my_quotes.md
     git commit

     # Display history of repo.
     git log --all --decorate --oneline --graph
    ```

    </details>

2. After the merge is done, let's look at the history of our Git repo again
   with `git log --all --decorate --oneline --graph`.

   You should see that, as expected, the 3-way merge introduced an
   additional **merge commit** (the commit `c6b02ce` in the example below).
   As a result our history is not as clean as could be.

    ```txt
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

    Can we fix it? _Yes, we can !_
     * Reset the repository to its state before the merge.
       > 🎯 **Hint:** time to put that `--hard` option to good use !
     * Rebase `second_choice` on `main`, before merging `second_choice` into
       `main`.
    <br>

    When you are done, run `git log --all --decorate --oneline --graph` and
    marvel at your perfectly clean history (commit IDs will differ). 😻

    ```txt
    * 9f554ad (HEAD -> main, second_choice) Add alternate favorite quotes
    * 5560a53 Add 3rd favorite quote
    * e78e2ab Add 2nd favorite quote
    * 70c65be Add 1st favorite quote
    * c3d7850 Starting the Big Reset
    * e044feb First commit
    ```

    <details><summary><b>✅ Solution</b></summary>

    ```sh
     # Revert the "main" branch to its state as before the merge.
     git reset --hard HEAD~1

     # Now we can rebase "second_choice" on "main" to get a cleaner history...
     git switch second_choice
     git rebase main

     # ... but there is a conflict that we need to solve manually...
     vim my_quotes.md

     # ... after the conflict is solved, we stage the modifications and
     # continue the rebase.
     git add my_quotes.md
     git rebase --continue

     # Merge "second_choice" into "main". This is now fast-forward => no conflicts.
     git switch main
     git merge second_choice

     # Display history of repo:
     git log --all --decorate --oneline --graph
    ```

    </details>

<br>
<br>
<br>

## Exercise 3 - The backport [30 min]

🚀 **Objective:** learn to use `git stash` and `git tag`. Understand the
**detached HEAD** mode.

> **Command summary**  
> Here are the main commands you will need for this exercise.
>
> ```sh
> git stash       # Store all uncommitted changes in the Git stash.
> git stash pop   # Remove changes from the stash and apply them to the working tree.
> git checkout    # Populate the working tree with an earlier version of the repo.
> git tag         # Add a tag to a commit.
> ```

<br>

You are busy working on the `dev` branch of a data analysis pipeline, when you
get a message from a user: they want you to backport the support for a new type
of input data onto an old version of the pipeline (version `1.0.1`).

You try to argue that this is an old version with security vulnerabilities,
and that they should not use it anymore... but they _just don't care_. As
a problem never comes alone, they need this _right now_ !

1. **Change into `exercise_3/backport.git`** and have a look at the Git
   repository's history. Note the different branches and tags.

   > 🦉 **Reminder:** you can use `git log --all --decorate --oneline --graph`
   > to display the entire repo's history - or `git adog`, if you have created
   > this alias.

    <details><summary><b>✅ Solution</b></summary>

    ```sh
     # 1. Enter the repo and explore its content.
     cd exercise_3/backport.git
     git log --all --decorate --oneline --graph  # Show history.
     git status                                  # Show uncommitted changes.
    ```

    We can see that there are 2 branches and 3 tags. Also, the current working
    tree is not clean, there are 2 files with uncommitted changes.
    </details>
    <br>

2. Implementing the backport is urgent, so you will finish your work on the
   `dev` branch later.

   **Stash away any uncommitted change**, so you don't lose your hard work.
   Then go back to version `1.0.1` of the project using the `git checkout`
   command.

    * ❓ **Question 1:** where is the `HEAD` pointer now ?
    * ❓ **Question 2:** has anything else changed in the repository's history ?

   <details><summary><b>✅ Solution</b></summary>

      ```sh
      # Stash uncommitted changes.
      git stash

      # Revert to version 1.0.1
      git checkout v1.0.1

      # Display history.
      git log --all --decorate --oneline --graph
      ```

   Looking at the history, we can now see that:
   * **Answer 1:** `HEAD` is now on commit `d2c319e`, which is where
     the tag `v1.0.1` is attached.
   * **Answer 2:** A new (temporary) "commit" has appeared at the tip
     of the `dev` branch: it's the stashed content.

   </details>
   <br>

3. Implement the backport fix:
    * In the file `functions.py`, add support for JSON files by changing the
      line `if extension in [".img", ".txt", ".csv"]:` to
      `if extension in [".img", ".txt", ".csv", ".json"]:` (see, writing
      software is easy!).
    * Commit your change.

   <br>
   <details><summary><b>✅ Solution</b></summary>

     ```sh
     git commit -m "Backport: add support for 'json' file type" functions.py
     ```

   </details>
   <br>

4. **Go back to the `dev` branch**. As you leave, you should see a warning
   message from Git.

   > Warning: you are leaving 1 commit behind, not connected to any of
   > your branches.

    * ❓ **Question:** what would happen to our latest commit if we
      "leave it behind" ?
    * Take Git's advice and create a new branch named `backport` that points to
      the commit we just left behind.
    * While we are at it, let's also add a **tag** `v1.0.1b` to our new commit.

   <details><summary><b>✅ Solution</b></summary>

    ```sh
     # Switch to the `dev` branch.
     git switch dev

     # Create a new branch named `backport`.
     git branch backport 1a2fa0c  # Note: your commit ID will differ.
     git switch backport
    
     # Add a tag.
     git tag v1.0.1b

     # Note: we could also tag the commit without switching to the backport branch.
     git tag v1.0.1b 1a2fa0c
    ```

   **Question answer:** "orphaned" commits (i.e. commits not part of any
   branch or tag), will eventually be pruned (i.e. deleted) by Git at some
   point. So it's not a safe option for commit that we want to keep.

   </details>
   <br>

5. Technically, after tagging our new commit with `v1.0.1b`, the `backport`
   branch is not really needed anymore, since a tagged commit will not be
   garbage collected. So let's delete this branch (using force deletion if
   needed).

   <details><summary><b>✅ Solution</b></summary>

    Because the `backport` branch is not fully merged, Git will not allow us
    to use `git branch -d`. We must use `-D` to **force delete**.

      ```sh
      # Force-delete the `backport` branch.
      git branch -D backport
      ```

    </details>
    <br>

6. That's it, we're done with the backport. Now we can finally get back to work
   on `dev`.
    * Restore the stashed content on `dev`.
    * Commit the change - you can use the commit message
      `Improve file import tests`.
   <br>

   At this point, your working tree should be clean and you Git history should
   look like this:

    ```txt
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

    <details><summary><b>✅ Solution</b></summary>

      ```sh
      # Switch to the `dev` branch.
      git switch dev

      # Restore the content, and commit it.
      git stash pop
      git commit -am "Improve file import tests"

      # Look the commit history.
      git log --all --decorate --oneline --graph
      ```

    </details>

<br>

### Additional Tasks ✏️

Update the `main` branch with the new commits from `dev`:

* Rebase your `dev` branch onto `main`, before merging it into `main`.
* Add a new tag `v2.0.0` to the latest commit on `main`.

Your Git history should now look like this:

```txt
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
<details><summary><b>✅ Solution</b></summary>

```sh
# Rebase "dev" on "main".
git rebase main

# Merge "dev" into "main".
git switch main
git merge dev

# Add a tag and display repo history.
git tag v2.0.0
git log --all --decorate --oneline --graph
```

</details>

<br>
<br>
<br>

## Exercise 4 - The treasure hunt [120 min]

🚀 **Objective:** collaborative exercise to review the Git commands and
concepts seen during the course.

> 👩‍🎓 **ECTS credits:** for participants who wish to receive ECTS credits for
> attending the course, this exercise also serves as **exam**. Please see the
> instructions at the end of the exercise on how to submit your work.

<br>

### Introductory notes

**We have saved the best for last !** In this collaborative exercise, you will
**team-up with two fellow pirates** in order to retrieve the lost treasure of
the feared pirate
[John Longsilver](https://en.wikipedia.org/wiki/Long_John_Silver) ☠️.
Get ready for a quest that will be _legend_ ... wait for it ... _dary !!_

In your quests throughout this exercise, you will be asked to follow a
**collaborative workflow** that uses the following branches:

* **`main`:** this is the **production branch**, i.e. the branch on which only
  final, production ready, material is published. Do _not_ work directly on the
  `main` branch.
* Short-lived **personal branches** (feature branches) will be used by each
  team member to add their work, before merging it into `main`.
* Each **new release** of your work will be indicated by **a tag**.

> 🦉 **Reminder**
>
> If a divergence in the `main` branch occurs between you local repo and the
> remote, you can either:
>
> * **Rebase** your local changes in `main` onto `origin/main` (this is often
>   the best solution, as it will give you a cleaner branch history than using
>   a merge).
>
>   ```sh
>   git pull --rebase
>   # Which, for the branch `main`, is the same as doing:
>   git fetch
>   git rebase origin/main
>   ```
>
> * **Merge** your local changes in `main` with `origin/main`.
>
>   ```sh
>   git pull --no-rebase
>   # Which, for the branch `main`, is the same as doing:
>   git fetch
>   git merge origin/main
>   ```
>
> * **Hard reset** your local `main` branch to `origin/main`.
>   Use this **with caution**, as it can result in loss of local commits or
>   loss of uncommitted changes to files.
>
>   ```sh
>   git reset --hard origin/main
>   ```

> 🔥 **Important:** please pay particular attention to the following points.
>
> * Keep a **clean history** by avoiding unnecessary merges. Rebase branches
>   to be merged before merging them whenever possible (unless explicitly
>   instructed otherwise).
> * Use **clear and meaningful commit messages** for your commits.
> * **Delete temporary branches** that are no longer needed (e.g. a personal
>   feature branch).
> * **Make sure to fully, carefully, read the instructions and hints** given
>   for each section, before starting the work.
> * **Please ask for help** if you are stuck at any point, especially if you
>   cannot solve one of the riddles (the objective is not to test your
>   puzzle-solving abilities :bulb:).

<br>

### A) Organize your crew

1. **Get together:**
    * **On-site course:** locate your team members in the classroom and sit
      together so you can communicate.
    * **Online course:** you will be placed in a breakout-room with your
      teammates. Remember to use the "share screen" function to help each
      other or show to other team members what you are doing on your machine.

2. **Organize your crew:** within your pirate team, distribute the following
   roles:
    * **Captain**
    * **Quartermaster**
    * **First-mate**

   If your team is less than 3 people, assign one person to multiple roles
   (e.g. one person is Captain and the other person is both Quartermaster and First-mate).

<br>

### B) Create a shared repo on GitHub

The first thing you need to do before embarking on your quest is to
**setup a remote repository** for your crew on [GitHub](https://github.com).
You will use it as a shared remote repo to synchronize your local Git repos
within the team.

As you only need 1 remote for the entire team, the following instructions
should be carried-out **only by 1 member of the team**:

* In your browser, login to [GitHub](https://github.com) and then go to the
  public repository: <https://github.com/sibgit/treasure-hunt>

  > 🦜 **Note:** you only have read-access to that repository, but for this
  > exercise, you and your team will need a repository where you are allowed
  > to both read and write.
  >
  > The solution is to **fork the repository**. Forking allows you to get your
  > own copy of a repository (under your GitHub account), on which you then
  > have full ownership.

* **Fork the "treasure-hunt" repository** using the instructions given in the
  **helper slides of exercise 4**.

  > 🔥 **Important:** when forking the repo, make sure to **copy all branches**.
  > For this you must **uncheck "Copy the main branch only"** option, which is
  > enabled by default.

* Once the forked repo is created, the owner of the repo must **give access**
  to the **other team members**, who must **accept the invitation** to join
  the new repo (you will receive an email from GitHub, or you can check the
  notifications in your GitHub user account).

<br>

All team members can now go into the `exercise_4/` directory (which should
be empty), and **clone the "treasure-hunt" repository** that your team just
setup on GitHub.

> 🔥 **Important:** make sure to clone the newly forked repository of your
> team, and _not_ the original repo.

> 🔥 **Important: Windows users only**
>
> Windows users (Linux/Mac users skip this step) must run the following
> command _inside_ the Git repository:
>
> ```sh
>  # Do not add the `--global` flag. This change should only affect the current repo.
>  git config core.filemode false
> ```
>
> This will instruct Git to ignore differences in _execution permissions_ of
> files, and is needed because Windows does not use the same file permission
> system as Linux/MacOS.

<br>

### C) Treasure hunt part one: the pirate code 📜

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

      > 🦜 **Note:** if one person of the group is having the role of multiple
      > pirates (because there are < 3 people in the team), then they should
      > create only a single personal branch and do the work for all of their
      > roles on that branch. This applies for all quests in this exercise.

    * On your personal branch, sign the pirate code by replacing `NAME HERE`
      with your name (on the line that is matching your rank).

      > 🔥 **Important:** only sign for yourself, not for others!

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
      **fast-forward** merge.
    * Pushing their changes on `main` back to the remote.
    * Inform other team members that they can now pull the changes on `main`
      (so that everyone stays in sync).

    > ✨ **Tip:** the best practice when merging changes into a shared branch
    > such as `main` is to always fetch/pull changes on the branch before
    > merging, to make sure that you are up-to-date. This is because in the
    > real world, team members will not be contacting each other each time
    > they push a change on `main`, and it's your responsibility to stay
    > up-to-date.

3. **When everyone has added their changes to `main`** (and everyone has
   pulled the changes), the `pirate_code.md` file in everyone's local `main`
   branch should now contain the signatures of the entire crew.

   To verify that things were done properly, run the following command
   (while on the `main` branch):

     ```sh
     # You must be at the root of the repo to run this command.
     ./verify_contract.sh
     ```

   The names and ranks of all crew-members should be proudly displayed. 🎉

4. It's now time to **make a new "release"** of your work by adding a **tag**:
    * The **Quartermaster** should add a **tag** named **`contract-signed`**
      on the latest commit of `main`, then push the tag to the remote:

        ```sh
        git push --tags
        ```

    * The **Captain** and the **First-mate** should then run `git fetch` to
      retrieve the newly added tag from the remote.
    * At this point, everyone should have the new tag in their local repo and
      everyone's `main` branch should be pointing to the same (latest) commit.
      Remember that you can use the command
      `git log --all --decorate --oneline --graph` (`git adog`) to display
      your entire repo history along with tags.

5. Each pirate can now **delete their personal branch** in their local repo.
    > 🦉 **Reminder:** if you pushed your personal branch to the remote, you
    > can delete it on the remote with `git push origin --delete <branch name>`.

That's it, the paperwork is done! Let's get on that ship and sail 🏴‍☠️ !

<br>

### D) Treasure hunt part two: gear-up 🏴‍☠️

Wait... did I just say "get on that ship" ? Well, the problem is that...
there is no ship... yet! And we will need a flag too! And rum of course, lots
of rum for this long journey.

The second part of this quest is therefore to find those 3 items: **a ship**,
**a flag**, and **rum bottles**. You are 3 in the team, so split the task:

* The **Captain** will search for the **ship** 🚣‍♀️.
* The **Quartermaster** will search for the **flag** 🏴‍☠️.
* The **First-mate** will search for **rum bottles** 🍹.

This is how you should proceed:

1. As for the first quest (_Signing the pirate code_), each pirate should
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
   rum bottles by running the following command:

    ```sh
    ./ask_a_pirate.sh
    ```

   > 🎯 **Hints**
   > * **Locations in hints given by local pirates correspond to commits!**
   >   Look at the history of the `port-royal`, `blackbird-castle`, and
   >   `oyster-bay` branches to find the commit where an item is hidden (based
   >   on the hints you received from the local pirates).
   > * Each item to find corresponds to a file: **`ship.ascii`**,
   >   **`flag.ascii`** and **`rhum.ascii`**. They are
   >   **located in a subdirectory named `supplies/`**.
   > * 🦉 **Reminder:** to see the content of a commit, you can:
   >   * Use **`git checkout <commit ref>`** to checkout the content of the
   >     commit. You then enter **detached HEAD mode**, which you can leave by
   >     switching back to a regular branch (e.g. your personal work branch).
   >   * Use **`git show <commit ref>`** to show the changes added by a commit.

3. Once you have located the commit with the item you are looking for, you
   should **add it to your personal branch by cherry-picking** it.

4. **Merge your personal branch into `main`** and push your changes on `main`
   to the remote. Use the same procedure as in the first part of the quest -
   see **point 2** of _Treasure hunt part one: sign the pirate code_ if you
   need a refresher.
    > 🔥 **Important:** if needed, make sure to **rebase your branch** before
    > merging it (to keep a cleaner history).

5. After all pirates have added their commit and updated their repo, everyone's
   `main` branch should have 3 new commits (one made by each team member), and
   the 3 files `ship.ascii`, `flag.ascii` and `rhum.ascii` should be present in
   the `supplies/` directory.

6. **Verify that you have all your gear** by running the command (on the
   `main` branch):

    ```sh
     # You must be at the root of the repo to run this command.
     ./verify_supplies.sh
    ```

   If your ship is loaded with the correct supplies, a success message will be
   displayed. 🎏

7. If everyone got a success message, it's time to **make a new release** of
   your work:
    * The **First-mate** should add a **tag** named **`ready-to-sail`** on the
      latest commit of `main`, then push the tag to the remote:

        ```sh
        git push --tags
        ```

    * The **Captain** and the **Quartermaster** should then run `git fetch` to
      retrieve the newly added tag from the remote.
    * At this point, everyone should have the new tag in their local repo and
      everyone's `main` branch should be pointing to the same (latest) commit.

8. Each pirate can now **delete their personal work branch**.

<br>

The ship is loaded and the flag is flying - now we're talking! All hands on
deck and keep the powder dry - get ready for the final step of this
_gitventure_: finding **the treasure** ! 🐳

<br>

### E) Treasure hunt part three: Skull Rock island 🏝️

We're setting sail on `skull-rock-island` ! The island was home to
**John Longsilver** - a fearsome pirate with a healthy appetite for treasures.
Unfortunately, pirate lives do sometimes take a turn for the shorter, and so
did Longsilver's.

While Longsilver is no more, his **trusty parrot** - a talkative bird if there
ever was one 🦜! - is still very much alive. Maybe that bird has some
recollection of where Longsilver has hidden his treasure ?

1. **Switch** to the `skull-rock-island` branch and hear what the parrot has
   to say:

    ```sh
    ./listen_to_parrot.sh
    ```

2. As you can see, the parrot isn't being helpful... But this is Git, we
   can **rewrite history** and make the bird more cooperative with a
   little... **rebasing !** 😀

   Run an **interactive rebase** on the last 4 commits of `skull-rock-island`,
   and make the following changes:
   * Squash the commit `Parrot remembers more things` into the commit
     `Parrot remembers John Longsilver` (they should become a single commit).
     Use the **`fixup`** instruction to squash them.
   * Delete the commit `Parrot forgets`.

   <br>

    > 🎯 **Hint:** after the rebase, the part of the `skull-rock-island`
    > branch diverging from `main` should look like this (commit IDs will
    > differ):
    >
    > ```txt
    > 34633d4 Parrot finds treasure chest
    > db1c6ed Parrot remembers John Longsilver
    > 1f4c68e Longsilver's parrot speaks
    > ```

3. Let's see whether the parrot has recovered its memory:

    ```sh
    ./listen_to_parrot.sh
    ```

   The bird should now give you some hints on where to look for
   **the keys to unlock the treasure chest**.

<br>

And there is more good news: in addition to giving you hints, the parrot has
also brought you to Longsilver's treasure chest! You now have a new directory
named `treasure_chest` at the root of the repo's working tree. To verify,
you run `ls -l` to list the content of the current directory.

To bring the treasure chest aboard your ship, the **First-mate** should do the
following:

 > 🔥 **Important:** only one pirate should perform this task (we suggest
 > the **First-mate**). Otherwise your `main` branch will diverge.

 1. **Merge `skull-rock-island` into `main`**. This will add the treasure chest
    to the `main` branch - along with your new friend the parrot !
 2. **Push the changes** on branch `main` to the remote.

The **Captain** and **Quartermaster** can now update their local repos with the
changes that the **First-mate** just pushed to `main`. At this point everyone
should be synchronized on their `main` branch and have the treasure onboard.

> 🌟 **Bonus:** if you want, you can sync the `skull-rock-island` branch
> across the team:
>
> * The pirate who did the merge (**First-mate**) should push their changes
>   on `skull-rock-island` to the remote. Note that, because of the rebase,
>   the local and remote version of the branch have diverged, and therefore
>   you need to add the **`--force`** option:
>
>   ```sh
>   git push --force
>   ```
>
> * The other pirates can then **reset** their local copy of
>   `skull-rock-island` to the version from the remote (the version
>   pushed by the First-mate).
>
>   ```sh
>   git fetch                                  # Download new changes from remote.
>   git switch skull-rock-island               # Make sure to be on the correct branch.
>   git reset --hard origin/skull-rock-island  # Reset the local branch.
>   ```

<br>

Congratulations, you're _almost_ there! Let's celebrate this with a
**new release**: 🎉

* The **Captain** should add a tag named **`treasure-found`** and push it to
  the remote: `git push --tags`
* Everyone else can then run `git fetch` to get the new tag.

<br>

Alright, let's see what John Longsilver has been hiding in his treasure. To
open it, run:

```sh
# You must be at the root of the repo to run this command.
./open_chest.sh
```

_Shiver me timbers!_ We are missing **the keys** to open the lock !

> 🦜 **Note:** If you are running out of time, you can finish this last part
> of the exercise on your own. You simply have to find the 3 keys for the
> treasure on your own.

<br>

### F) Treasure hunt final part: opening the treasure 🗝️

We are now looking for the **3 keys to open the 3 locks of the chest**.

As before, this can be done as teamwork and each pirate retrieves one of the
keys.

> 🦜 **Note:** for this last quest, to save time (and because we believe that
> by now you have understood the principle), you may add your commits directly
> to the `main` branch, without creating a temporary working branch -
> _crazy !_ , I know 😎.
>
> Make sure to check that your `main` branch is up-to-date before you add a
> commit to it: you don't want any divergence in the `main` branch among the
> team !
>
> If your local `main` diverges from `origin/main`, you can fix the issue by
> rebasing your local `main` on the remote with:
>
> ```sh
>  git pull --rebase
>  # or
>  git rebase origin/main
> ```

<br>

To find where the keys are hidden, listen to the parrot's hints:

```sh
./listen_to_parrot.sh
```

Then go back to `port-royal`, `blackbird-castle` and `oyster-bay` to find the
keys.

> 🎯 **Hints - please read this carefully _before_ you begin**
>
> * Unlike in the previous quest, the locations that the parrot gives in its
>   hints correspond here to **directories** on disk - _not_ to commits.
>   * Example: if the parrot said that a key can be found at the goldsmith in
>     Port-Royal, you would switch to the `port-royal` branch and look for a
>     directory named `goldsmith`. You would then check the content of that
>     directory to see if it contains a key.  
> * The **keys** are files that have the name of the object that contains them
>   or is near them. E.g. a file named `candle` would be a "key" file if you
>   think that the key is near a candle.
>   * **Tip:** you can use `ls -l` to list the content of a directory.
> * To open the treasure, each key file must be placed in the correct lock
>   directory, and renamed to the correct name (more details below).
> * 💣 **Warning: do not modify the content of the key files** in any way,
>   this would destroy them.

<br>

Once you located the correct files (based on the hints given by the parrot),
you should:

1. **Checkout** (retrieve) the file to the `main` branch using the command:

    ```sh
    git restore --source=<branch name> <path/to/file-to-retrieve>
    ```

    > 🔥 **Important:** for this exercise, you must run the command while
    > **located at the root** of the working tree (i.e. at the root of
    > `treasure-hunt`). Also, make sure to be on `main` before running the
    > command.

2. **Move and rename** the file to the correct lock directory in the
   `treasure_chest`.

    ```sh
    mv <path/to/file> treasure_chest/lock_1/key_1  # For key 1
    mv <path/to/file> treasure_chest/lock_2/key_2  # For key 2
    mv <path/to/file> treasure_chest/lock_3/key_3  # For key 3
    ```

3. **Make a new commit** with your key file(s).

<br>

When each pirate has added their key to `main`, and everyone has updated their
local Git repo copies (everyone has the 3 keys), you can try to
**open the treasure again**:

```sh
# You must be at the root of the repo to run this command.
./open_chest.sh
```

If the keys are the correct files, are placed in the correct lock, and have
been correctly renamed, **the treasure should open !** 🎉

<br>

### For people doing this exercise as exam 👩‍🎓

If you would like to receive credits for the course:

1. **Take a screenshot** of the output of your Git repo's full history (use
   `git log --all --decorate --oneline --graph`) at the end of your quest.
2. **Create a new branch** named `exam-YOUR_FULL_NAME` rooted on the latest
   commit of `main` (replace `YOUR_FULL_NAME` with your actual name). Add a
   commit with your screenshot to this new branch and push it to the remote.
3. **Send an email** with subject "Git course exam - your name" to the
   course instructor with the following information:
    * Your **full name**.
    * The **URL of the remote repo** that you have used for this exercise. The
      repo must be public.
    * The **secret code** you found when opening the chest.

      > 🦜 **Note:** the instructor's email address can be found at the top of
        the shared document used for the class.

4. **Make sure you have signed-up for the exam** on the shared online document
   of the course by highlighting your name in green.

<br>
<br>
<br>
