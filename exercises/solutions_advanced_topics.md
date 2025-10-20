# Exercise solutions - Git advanced topics

**Table of Content:**

[[_TOC_]]

<br>

:pushpin:  
**Note:** in these corrections, `git switch` is used to checkout/switch
branches. If you are using a Git version older than `2.23`, `git checkout`
should be used instead.
Similarly, `git switch -c` (create + switch branch) must be replaced by
`git checkout -b`.

<br>
<br>

## Exercise 1 - The vim cheat-sheet rebase

1. Explore the `vim_cheatsheet.git` repository.
    ```sh
    cd exercise_1/vim_cheatsheet.git            # Enter exercise directory.
    git log --all --decorate --oneline --graph  # Show history of repo and branches.
    cat *.md                                    # Display the content of all .md files in the repo.

    # Switch to the "dev" branch and list its content.
    git switch dev   # Switch to `dev` branch.
    ls -l            # List the content of the directory (now in `dev` branch).
    git switch main  # Go back to branch `main`.
    ```

2. Re-order the commits on `main` using **interactive rebase**:
    ```sh
    git rebase -i a818d5a

    # Display history of repo to see how it looks like after the rebase.
    git log --all --decorate --oneline --graph
    ```

    :fire:
    **Important:** remember that in the interactive rebase file, the order of
    commits is oldest to newest from top to bottom. Your re-ordered interactive
    rebase commit list should thus look like (blank lines are optional):
    ```txt
    pick 91aa2f3 2. Edit README file
    pick 21d712d 3. Edit README file: add open file example

    pick 9c7f8b4 4. Add 'normal_mode' file: commands for vim's normal mode
    pick be7f832 5. Edit 'normal_mode' file: add 'dd' and 'yy' commands
    pick ac17969 6. Edit 'normal_mode' file: add more commands

    pick c110031 7. Add 'command_mode' file: commands for vim's command mode
    pick d95eb3d 8. Edit 'command_mode' file: add more commands
    ```

3. Rebase `dev` branch on `main`. This automatically gets rid of the duplicated
   commits that are left on `dev`:
    ```sh
    git log --all --decorate --oneline --graph
    git switch dev
    git rebase main

    # Display history of repo to see how it looks like after the rebase.
    git log --all --decorate --oneline --graph
    git switch main
    ```

4. To merge the different commits for each file, we again run an interactive
   rebase on the first commit `git rebase -i HEAD~7`
   (or `git rebase -i a818d5a`).

   To merge and rename the commits 2 and 3, there are 2 possibilities:
    * **Use the command `squash/s`** to squash the commits into their parents.
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
      `reword/r` for the first commit of the list, since we were explicitly
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



5. Rebase the `dev` branch on `main`:
    ```sh
    git log --all --decorate --oneline --graph
    git switch dev
    git rebase -i main
    ```

   :fire:
   **Important:** in the interactive rebase, we must instruct Git to drop all
   duplicated commits (be either deleting the line of the commit, or by
   using the "d/drop" instruction).  
   The edited rebase instructions should look like this (only the 2
   non-duplicated commits are kept):
    ```txt
    pick 7c5827f Add image file showing a visual overview of vim modes
    pick be67a87 Maybe we should all switch to emacs...
    ```

6. Switch back to the `main` branch and display the history of the repo.
   ```sh
   git switch main
   git log --all --decorate --oneline --graph
   ```

<br>

### Additional Tasks

7. Fix errors in the `README.md` and `normal_mode.md` files, then perform the
   interactive rebase on `main` with the **`--autosquash`** option:
    ```sh
    # Display the repo's status: it will show that README.md and normal_mode.md
    # have been modified.
    git status

    # Commit changes in 2 different "fixup" commits:
    git commit --fixup=HEAD~2 README.md
    git commit --fixup=HEAD~1 normal_mode.md

    # Perform the interactive rebase. Do not forget to add the "--autosquash" option.
    git rebase -i --autosquash HEAD~5
    git log --all --decorate --oneline --graph  # To check the result.
    ```

8. Rebase `dev` on `main`. Make sure to use interactive rebase to discard all
   the duplicated commits, as we did previously:
    ```sh
    git switch dev
    git rebase -i main  # Important: discard all duplicated commits in the rebase file.
    git switch main
    ```

9. Merge the first two commits:
    ```sh
    git rebase -i --root main
    ```

   Change the commit message of latest `dev` commit:
    ```sh
    git switch dev
    git commit --amend -m "Add xkcd comic image file"
    ```


<br>
<br>
<br>


## Exercise 2 - The big reset

1. Initialize a new Git repo.
    ```sh
    cd exercise_2/the_big_reset.git
    git init
    ```

2. Make a first commit with the `README.md` file.
    ```sh
    git add README.md
    git commit -m "First commit"
    ```

3. Make a second commit with the `my_quotes.md` file.
    ```sh
    git add my_quotes.md
    git commit -m "Add a file to keep track of quotes"
    ```

4. Amend the commit message of the last commit we made. Note that the best
   solution for this task would be to use
   `git commit --amend -m "Starting The Big Reset"`, but the idea of the
   exercise is to use the **`git reset`** command.

   Since we simply want to change the commit message, we use the **`--soft`**
   option of `git reset`: this option will reset the `HEAD` to the specified
   position (in this case `HEAD~1` - the parent of the last commit), but will
   not modify the git index. In other words, the `--soft` option leaves staged
   the content that was added between the current commit and the commit to
   which we reset.
    ```sh
    git reset --soft HEAD~1
    git commit -m "Starting The Big Reset!"
    git log --pretty=oneline                 # To check the commits message was changed.
    ```

    :fire:
    Comparing the commit ID values of the second commit before and after having
    amended the commit message, we can see that they are different, despite the
    two commits having the same content and commit message. The reason is
    because they were made at a different time, and since time is part of the
    commit's metadata (and thus used to compute the commits' SHA-1 hash value),
    the values differ.  

5. We must do a reset to the first commit, then add `chuck_norris_quotes.txt`
   to a `.gitignore` file, and amend the first commit with the addition of the
   `.gitignore` file. Then we can redo the second commit.
    ```sh
    # Create the .gitignore file.
    echo "chuck_norris_quotes.txt" > .gitignore

    # Add the .gitignore file to the first commit.
    git reset --mixed HEAD~1   # This is the same as "git reset HEAD~1",
                               # since "--mixed" is the default option.
    git add .gitignore
    git commit --amend --no-edit
    git show HEAD  # We can display the content of the amended commit, if we
                   # want to verify that the .gitignore file is not part of it.

    # Redo the second commit.
    git add my_quotes.md
    git commit -m "Starting The Big Reset!"
    ```
    <br>

    :pushpin:
    **Note:** instead of re-doing the second commit, we can also delete the
    `my_quotes.md` file and then **cherry-pick** the `Starting The Big Reset!`
    commit we made earlier (this commit is orphaned after we ran the
    `git reset --mixed HEAD~1` command, but it can still be cherry-picked!).  
    If you can't find its commit ID displayed in your terminal, you can use
    the **`git reflog`** command to find it).  
    Note that in the solution below, your commit ID of the cherry-pick command
    will differ.
    ```sh
    rm my_quotes.md
    git cherry-pick f35665e
    ```
    <br>

6. Add 3 favorite quotes in 3 different commits.
    ```sh
    echo -e "When Chuck Norris does division, there are no remainders.\n" >> my_quotes.md
    git commit -m "Add 1st favorite quote" my_quotes.md
    echo -e "When Chuck Norris throws exceptions, it’s across the room.\n" >> my_quotes.md
    git commit -m "Add 2nd favorite quote" my_quotes.md
    echo -e "'I don't always test my code. But when I do, I do in production' - Chuck Norris\n" >> my_quotes.md
    git commit -m "Add 3rd favorite quote" my_quotes.md
    ```

7. Create a new branch at the second commit. Note that with `switch -c` we
   create the branch and check it out at the same time.
    ```sh
    git switch -c second_choice HEAD~3
    cat my_quotes.md                    # Verify there are no quotes in the file.
    ```

8. Add 3 other quotes, then commit.
    ```sh
    echo -e "Chuck Norris can divide by zero.\n" >> my_quotes.md
    echo -e "Chuck Norris never gets a syntax error. Instead, the language gets an DoesNotConformToChuck error.\n" >> my_quotes.md
    echo -e "Chuck Norris doesn't wear a watch. He simply decides what time it is.\n" >> my_quotes.md
    git commit -m "Add alternate favorite quotes" my_quotes.md
    ```

9. Merge branch `second_choice` into `main`.
    ```sh
    git switch main
    git merge second_choice
    vim my_quotes.md         # There is a conflict, we need to solve it manually.
    git add my_quotes.md
    git commit

    # Display history of repo.
    git log --all --decorate --oneline --graph
    ```

10. Revert back to before the merge. Then rebase `second_choice` onto `main`
    to get a cleaner history.
    ```sh
    # Revert the "main" branch to its state as before the merge.
    git reset --hard HEAD~1

    # Rebase "second_choice" on "main".
    git switch second_choice
    git rebase main
    vim my_quotes.md         # There is a conflict, we need to solve it manually.
    git add my_quotes.md
    git rebase --continue

    # Merge "second_choice" into "main".
    git switch main
    git merge second_choice

    # Display history of repo:
    git log --all --decorate --oneline --graph
    ```


<br>
<br>
<br>


## Exercise 3 - The backport

1. Enter repo and explore its content. We can see that there are 2 branches
   and 3 tags. Also, the current working tree is not clean, there are 2 files
   with uncommitted changes.
    ```sh
    cd exercise_3/backport.git
    git log --all --decorate --oneline --graph  # Show history.
    git status                                  # Reveal uncommitted changes.
    ```

2. We store uncommitted changes in the **stash**, then proceed to revert to
   version 1.0.1 with a `git checkout`.  
   Looking at the history, we can now see that:
    * `HEAD` is now on commit `d2c319e`, which is where the tag `v1.0.1` is
      attached.
    * A new (temporary) "commit" has appeared at the tip of the `dev` branch:
      it's the stashed content.

    ```sh
    git stash
    git checkout v1.0.1
    git log --all --decorate --oneline --graph
    ```

3. Implement the support for JSON files in `functions.py` (the backport fix),
   then commit the changes.
    ```sh
    git commit -m "Backport: add support for 'json' file type" functions.py
    ```

4. Upon switching to `dev`, Git gives us a warning:

   > "Warning: you are leaving 1 commit behind, not connected to any of your branches:"  

   "Orphaned" commits (i.e. commits not part of any branch or tag), will
   eventually be pruned (i.e. deleted) by Git at some point. So it's not a safe
   option for commit that we want to keep.
   We follow Git's advice and create a new branch. We then switch to the new
   branch, and add a tag `v1.0.1b`.
    ```sh
    git switch dev
    git branch backport 1a2fa0c  # Note: your commit ID will differ.
    git switch backport
    git tag v1.0.1b

    # Note: we could also tag the commit without switching to the backport branch.
    git tag v1.0.1b 1a2fa0c
    ```

5. Go back to `dev`, restore the stashed changes with **`git stash pop`**,
   then make a commit.
    ```sh
    git switch dev
    git stash pop
    git commit -am "Improve file import tests"
    git log --all --decorate --oneline --graph
    ```

6. Delete the `backport` branch. Note that since this branch is not fully
   merged, Git will give an error if we try to use `git branch -d`:

   > error: The branch 'backport' is not fully merged.`

   So we must "force delete" the branch with `git branch -D`.
    ```sh
    git branch -D backport
    ```

<br>

### Additional Tasks

7. Rebase and merge `dev` into `main`. Add a `v2.0.0` tag.
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

<br>
<br>
<br>
