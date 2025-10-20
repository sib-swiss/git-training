# Exercises - first steps with Git

**Table of Content:**

[[_TOC_]]

<br>
<br>

## Before you start

* :pencil:
  **Exercise material setup:** download the `exercises.zip` archive file to
  your local computer and unzip it. This will unpack a directory named
  `exercises`, with all the data needed for the course exercises.

* :pencil2:
  **Additional Tasks:** at the end of exercises, you will sometimes find a
  section named **Additional Tasks**. These sections contain tasks to complete
  **if you have the time and after having completed the main exercise**.
  Additional tasks sections will not be corrected in class, but their solution
  is given in this document.

* :white_check_mark:
  **Exercise solutions:** all exercises and additional tasks section have
  their solution embedded in this document. Solutions are hidden by default,
  but you can reveal them by clicking on them. Here is an example:

  <details><summary><b>Solution (click to reveal)</b></summary>
  :sparkles: This reveals the answer :sparkles:
  </details>

  We encourage you to **not look at the solutions too quickly**, and try to
  solve the exercises without them. Remember that you can always ask the
  course teachers for help.

* :fire:
  **Tip:** if you are viewing these instructions on the GitHub web-interface,
  you can display a table of content (outline) of this page by clicking on the
  small icon that looks like a bulleted list near the top-right of this page.

### Configuring Git

Before starting with the exercises, make sure that you have done the minimal
Git configuration by setting your **user name** and **email** address in Git:

```sh
git config --global user.name "First-name Last-name"
git config --global user.email "your.email@example.com"

# Examples:
git config --global user.name "Alice Smith"
git config --global user.email alice.smith@wonder.org
```

Optionally you can also change the **default editor** used by Git, e.g. if you
are more comfortable with `nano` than `vim`:

```sh
git config --global core.editor nano  # Set default editor to nano.
git config --global core.editor vim   # Set default editor to vim (the default).
```

To see the config values that are currently set, the commands are the following:

```sh
git config --get user.name
git config --get user.email
git config --get core.editor

# Show all config values at once and where they are set.
git config --list --show-origin
```

<br>  
<br>

## Exercise 1 - Your first commit [30 min]

:rocket:
**Objective:** learn to create a new Git repository, add files to it, and
make commits.  

Welcome to the first exercise of this Git course! This is a warm-up, so you
will be guided step-by-step on exactly what you need to do.

### Part A: create a new repo from scratch and make a first commit

1. **Change directory** into `exercise_1/test-project` and list the
   directory's content using the following shell commands:
   ```sh
   cd exercise_1/test-project   # Enter the directory.
   ls -l                        # List files present the directory.
   ```
   You should see that it contains files reminiscent of a simple scripting
   project, e.g. a data analysis pipeline (here written in Python).
   ```txt
     test-project
      ├── doc
      │   └── user-guide.pdf
      ├── README.md
      ├── script.py
      ├── script.pyc
      └── tests
          ├── output.csv
          ├── tests.py
          └── tests.pyc
   ```
   <br>

2. **Initialize a new Git repository** at the root of the `test-project`
   directory:
   * Create a new Git repo in the current working directory with the command:
     ```sh
     git init   # Initialize a new Git repository.
     ```
   * Initializing a new Git repo creates a **hidden `.git` directory**. You
     can view this directory by running the shell command:
     ```sh
     ls -la   # You should observe that a new ".git" hidden directory was created.
     ```
   * :fire:
     **Important:** the **`.git`** directory is where Git stores the entire
     history of your repository (as well as various settings). If you delete
     it, all your version control history (and settings) for this repository
     **will be lost**. You can do this if e.g. you want to start the exercise
     from scratch again.

     <br>

3. **Display the status of files** in the working tree (i.e. the `test-project`
   directory):
   * Run the command `git status`.
   * :question:
     **Question:** what is the status of the files in your working directory?

   <details><summary><b>:white_check_mark: Solution</b></summary>

   **Running `git status`**, we see - as expected at this point - that
   **all files are untracked**.  
   Output of `git status`:

    ```txt
      On branch main
      No commits yet

      Untracked files:
        (use "git add <file>..." to include in what will be committed)
        README.md
        doc/
        script.py
        script.pyc
        tests/
    ```

   </details>
   <br>

4. **Stage the files** `README.md`, `script.py`, `doc/user-guide.pdf`,
   `tests/output.csv` and `tests/tests.py` (i.e. all files except the `*.pyc`
   files - these are "python cache" files we don't want to track).

   :owl:
   **Reminders:**
   * _staging_ a file is a synonym of _adding to the Git index_.
   * The command to stage files is: `git add <files or directories>`. For
     instance, `git add README.md` will stage the file `README.md`.

   To make sure that you have staged the files correctly, run the command
   **`git status`**. The output of the command should look like this:

      ```txt
      Changes to be committed:
          new file:   README.md
          new file:   doc/user-guide.pdf
          new file:   script.py
          new file:   tests/output.csv
          new file:   tests/tests.py

      Untracked files:
          script.pyc
          tests/tests.pyc
      ```

   <details><summary><b>:white_check_mark: Solution</b></summary>

   There are several ways we can stage all the requested files:
   * By staging individual files:
     ```sh
      git add README.md
      git add script.py
      git add doc/
      git add tests/tests.py
      git add tests/output.csv

      # Note that we can also stage all 3 files in a single command:
      git add README.md script.py doc/ tests/tests.py tests/output.csv
     ```
   * By staging all files in the directory, then removing the `*.pyc` files
     from the staging area (Git index):
     ```sh
     # Stage all files in the directory.
     git add --all   # Alternative: git add .

     # Remove the *.pyc files from the staging area.
     # Do not forget the --cached option, otherwise files are deleted on disk!
     git rm --cached script.pyc tests/tests.pyc 
     ```
     Note that in this specific case we can not use `git restore --staged` to
     remove files from the Git index because we do not have any commits yet
     in the repository (and `git restore --staged` needs a commit to restore
     from).

   If we now run `git status`, we should see that all our files except the
   `.pyc` files are displayed as "new file" under "Changes to be committed:",
   and are ready to be committed.

   </details>
   <br>

5. **Add a first commit** to the repo with the commit message
   `Initial commit for test project`.
   * The command to make a commit is: **`git commit -m "commit message"`**
     (or, in the long form: `git commit --message "commit message"`)
   * After the commit is done, run the following commands:  
     * **`git log`**: to display the repository's history. At this point you
       should have a single commit, that looks like the following (your exact
       values for commit hash, date, etc. will differ):
       ```txt
       commit a0da6303e9d6dfc34986f959a076721e153f382d (HEAD -> main)
       Author: Your Name <your.email@example.org>
       Date:   Mon Oct 14 13:55:08 2024 +0200

           Initial commit for test project
       ```
     * **`git show`**: to have a look at the content of your commit.  
     * :pushpin:
       **Note:** when the amount of text to be printed by `git show` exceeds one
       screen, the content is shown with the GNU program `less`. In `less`, you
       can use your keyboard arrow keys to move up/down, and press `q` to exit and
       return to the shell.

   :question:
   **Question:** why are the details of the `doc/user-guide.pdf` file not
   displayed by `git show`?

   <details><summary><b>:white_check_mark: Solution</b></summary>

    ```sh
    git commit -m "Initial commit for test project"
    git log     # At this point the commit history contains a single commit.
    git show    # Show content of the last commit.
    ```

    Looking at the output of **`git show`**, we can see that the newly
    added content for the file `doc/user-guide.pdf` is not displayed
    (unlike for `README.md` for instance, where the content of the file is
    shown).  
    The reason is that `user-guide.pdf` is a **binary file** and not a
    plain text file). Git does not display details for binary files.

   </details>

<br>

### Part B: commit a change to a tracked file

In this section, we will make an update to the `README.md` file, and then
create a new commit that adds the change we made.

1. **Open the `README.md` file** in your favorite text editor.
   * Change the 3rd line of the file to:
     > Demo project for the Git course. This will be great!
   * Save your changes and close the file.
   * Run **`git status`** - `README.md` should now be listed as modified:
      ```txt
      Changes not staged for commit:
          modified:   README.md

      Untracked files:
          script.pyc
          tests/
      ```
   <br>

2. **Display the changes** to files in the working tree:
   * Run the command **`git diff`**, which displays the difference in tracked
     files between the working tree and the Git index (staging area).
     ```sh
     git diff
     git diff README.md  # Gives the same result, as only README.md was modified.
     ```
   * It will show that `README.md` has one line removed (shown in red, prefixed
     with **`-`**), and one line added (shown in green, prefixed with **`+`**).
     ```diff
     -Demo project for the Git course.
     +Demo project for the Git course. This will be great!
     ```
   <br>

3. **Commit the changes** you just made:
   * Add/stage the changes made to `README.md` with **`git add`**.
     Remember that each time you modify a file and want to include these
     changes into your next commit, you have to `git add` that file again.
   * :fire:
     **Tip:** to stage all modified files at once, you can use the shortcut
     **`git add -u`**. Here it does not make a lot of difference as there is
     only 1 modified file, but if there are many of them, this command can be
     useful.
   * Run `git status` again: you should see that the `README.md` file is now
     listed under `Changes to be committed:` (in green).
   * Commit your changes with the message `"Make README file more cheerful"`.

    <details><summary><b>:white_check_mark: Solution</b></summary>

      ```sh
      git add README.md
      git commit -m "Make README file more cheerful"

      # Alternative: stage all modified files with "git add -u". Since only
      # README.md was modified, this is in the same as staging the README.md.
      git add -u
      git commit -m "Make README file more cheerful"

      # Alternative: use a "git commit" shortcuts to stage + commit in a single
      # command.
      git commit -m "Make README file more cheerful" README.md
      git commit --all -m "Make README file more cheerful"
      ```

    </details>

<br>

### Part C: adding files to the `.gitignore` list

At this point, the only files that should be left **untracked** in our
repository are the two `*.pyc` files (you can verify this by running
`git status`). Since we are never going to track these files, we would like
to **permanently ignore** them, so that they stop being listed as _untracked_.

1. At the root of the working tree, **create a text file named `.gitignore`**,
   with the following content:

    ```txt
    *.pyc
    ```

   :fire:
    **Tip**: you can create the `.gitignore` in any text editor you like,
    but you can also easily generate it with a shell command:

     ```sh
     echo "*.pyc" > .gitignore
     ```

    <br>

2. **Run `git status`**: you should see that you still have an untracked
   file: the `.gitignore` file you just created :sweat_smile: !  
   Since the ignore rules defined in the `.gitignore` file are useful to all
   users of the repository, this file should be added to the repo.

   * Stage the `.gitignore` file.
   * Make a new commit with commit message `Add *.pyc to ignore list`.
     At the end of this step, your working tree should now be "clean": when you
     run `git status`, the output should be:
      ```txt
        On branch main
        nothing to commit, working tree clean
      ```

   <details><summary><b>:white_check_mark: Solution</b></summary>

     ```sh
     # Stage the .gitignore file.
     git add .gitignore

     # Make a new commit.
     git commit -m "Add *.pyc to ignore list"

     # The working tree is now clean.
     git status  # -> nothing to commit, working tree clean
     ```

   </details>
   <br>

3. **Display the (modest) history of your Git repo** with the following
   variations of the **`git log`** command. Observe how history is displayed by
   each command:

    ```sh
    git log                                     # Prints the full commit message along with author and date.
    git log --pretty=oneline                    # 1 commit per line. Full commit hash/ID (checksum).
    git log --oneline                           # 1 commit per line. Abbreviated commit hash/ID.
    git log --all --decorate --oneline --graph  # Shows commits for all branches.
    ```

    With the current history of our git repo, the output of
    `git log --all --decorate --oneline --graph` is the same as
    `git log --oneline`. This will however change when we start working with
    **branches** - the longer version of the command will then become very
    useful.

    <br>

4. **Create a Git alias (shortcut)** for the command
   `git log --all --decorate --oneline --graph`, and name it `adog`.

    ```sh
    git config --global alias.adog "log --all --decorate --oneline --graph"
    ```

    * Test your new shortcut by typing: `git adog`.
    * Your commit history should look like this (commit ID values will differ):
      ```txt
      * 81d03aa (HEAD -> main) Add *.pyc to ignore list
      * 029a389 Make README file more cheerful
      * da59f94 Initial commit for test project
      ```
    * :fire:
      **Tip:** to list your Git aliases, use: `git config --list | grep ^alias`

<br>

### Additional Tasks (if you have time)

For some of the next steps, we will need an additional file named
`personal_notes.md`, as well as a change in the `script.py` file.

**Let's generate this file/changes** by running the following commands at the
root of the `test-project` directory:

```sh
echo "Let's keep this local" > personal_notes.md
echo "adding a bad line..." >> script.py

# You can then visualize the changes by running:
git status
git diff
```

<br>

#### 1. Removing content from the Git index (unstaging)

Start by staging all untracked and modified files with `git add --all`.
The status of your files should look like:

```txt
Changes to be committed:
    new file:   personal_notes.md
    modified:   script.py
```

Actually, we do _not_ want to add these changes to the repository,
so **let's unstage them**.

* Unstage the changes to `script.py` using the command: **`git restore --staged`**

* Unstage the entire file `personal_notes.md`, using either
  **`git restore --staged`** or **`git rm --cached`**.
  * :owl:
    **Reminder:** the difference between `git rm --cached` and `git restore --staged`
    is that `git rm --cached` **removes the entire file from the index**,
    while `git restore --staged` **reverts it to the version in the last
    commit** (`HEAD` commit).
  * :pushpin:
    **Note**: The reason why in this particular case `git rm --cached` does
    exactly the same as `git restore --staged` is because
    `personal_notes.md` is a newly added file. There is thus no difference
    between removing it completely, or just resetting it back to its
    version from the latest commit (since it is absent from the latest
    commit).
  * :warning:
    Be careful to _not_ run `git rm` instead of `git rm --cached`, as this
    would not only remove the file from the Git index, but also delete it
    from your working tree!

* At this point, changes in `script.py` should again be unstaged, and
  `personal_notes.md` should be untracked.  
  Run **`git status`** to confirm this:

  ```txt
  Changes not staged for commit:
    modified:   script.py

  Untracked files:
    personal_notes.md
  ```

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

```sh
  git add --all
  git restore --staged script.py           # Unstage changes to script.py
  git restore --staged personal_notes.md   # Unstage personal_notes.md

  # To unstage personal_notes.md, we can also use:
  git rm --cached personal_notes.md
```

</details>
<br>

#### 2. File staging shortcuts: `git add --update` vs. `git add --all`

:owl:
**Reminder:**

* **`git add --all`**: updates the Git index with **all modified and untracked files**.
* **`git add --update`:** updates the Git index only with the new versions
  of files that are **already tracked**. It does _not_ stage any new,
  untracked files. In a sense, `--update` is safer because it prevents you
  from adding completely new files to the Git repo by mistake.

In the task just above, we have used `git add --all`. Now we would like to
stage only the modified file `script.py`.

* Run the command **`git add -u`**, then look at the status of your files.
  You should see that only `script.py` was staged (because it's a modified
  file), but not `personal_notes.md` (because it's untracked).

  ```sh
  git add -u   # -u is the shortcut for --update
  git status
  ```

  ```txt
  Changes to be committed:
    modified:   script.py

  Untracked files:
    personal_notes.md
  ```

* Run `git restore --staged script.py` to unstage the changes to `script.py`.

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

The difference between **`git add -u/--update`** and **`git add --all`** is
that **`--update`** only adds files that are already tracked in Git, while
**`--all`** adds all files (except ignored files), whether they are already
tracked (modified) or not (untracked).

In a sense, `--update` is safer because it prevents you from adding
completely new files to the Git repo by mistake.

```sh
  # Stage all modified files.
  git add -u

  # We can see that modifications in script.py are now staged.
  git status

  # Unstage the modifications.
  git restore --staged script.py
```

</details>
<br>

#### 3. Ignore a file using `.git/info/exclude`

`personal_notes.md` is a file that we never intend to track and share with
other people. Therefore we would like to **ignore** it. However, since this
file is specific to our own local setup, it should only be ignored by our
local Git repo, and not by everyone else.

:owl:
**Reminder:** in Git, files/patterns to ignore only in your local repo
should be added to **`.git/info/exclude`**. This is a text file that is
automatically present in a `.git` repo.

* Edit the file **`.git/info/exclude`** to ignore `personal_notes.md`.
  you can do this with a regular text editor, or using the following
  shell command:

    ```sh
      echo "personal_notes.md" >> .git/info/exclude

      # Display the content of the file:
      cat .git/info/exclude
    ```

* Run `git status` again. The file `personal_notes.md` should not longer
  be listed as _untracked_.

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

```sh
  # Add 'personal_notes.md' to the "exclude" file:
  echo "personal_notes.md" >> .git/info/exclude
  cat .git/info/exclude  # Display the content of the file.

  # 'personal_notes.md' is no longer listed as untracked.
  git status
```

</details>
<br>

#### 4. Undo a changes from `script.py` in your working tree

If you run **`git diff`**, you will see that we currently have an
uncommitted change in the `script.py` file:

```diff
+adding a bad line...
```

However, this is not a modification we want to keep. Instead, we would
like to **reset the content of `script.py`** to its previous version
(as in the Git index and the previous commit).

* Using `git restore`, reset the content of `script.py` to its version in
  the Git index.
* Run `cat script.py` to make sure the  "bad line" has been removed from the
  file.
* Run `git diff`: there should be no difference anymore (no output).
* Run `git status`: at this point, your working tree should be clean.

  ```txt
  On branch main
  nothing to commit, working tree clean
  ```

:warning:
As you have just experienced, `git restore <file>` really overwrites
uncommitted modifications in your files. Use this command carefully to
avoid losing work by mistake.

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

**`git restore script.py`** overwrites the version of `script.py` present in
the working tree with the version from the Git index.

```sh
git restore script.py
cat script.py           # The line "adding a bad line..." is gone.
git diff                # Empty output, which is what we expect.
git status              # No more uncommitted changes.
```

</details>
<br>

#### 5. Remove a file from the repository

Currently the file `tests/output.csv` is being tracked in our Git repo.
However, all things considered, this file is not really needed, and we now
would like to delete it from both our repo and working tree.

* Delete the file with **`git rm`**.
* Run `git status`: you should see that the was was deleted, and that this
  deletion is already stage.
  ```txt
  On branch main
  Changes to be committed:
    deleted:    tests/output.csv
  ```
* Make a new commit that removes this file from the repo. You can use the
  commit message `"Remove test output"`

:owl:
**Reminder:** while we have delete the file `output.csv` from the git index
and the last commit, a copy of it still remains in the history of our
repository.

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

```sh
git rm tests/output.csv
git status
git commit -m "Remove test output"
```

We use **`git rm`** to remove `tests/output.csv` from both the Git index
and the working tree. To delete the file only from the index we would use
`git rm --cached tests/output.csv`.

</details>
<br>

#### 6. Retrieve `output.csv` from an older commit

Let's imagine that, for some reason, we want to retrieve the file
`tests/output.csv` from our commit history.

* Use command **`git restore --source <commit ref> tests/output.csv`**.
  You need to replace `<commit ref>` with the commit ID of the commit
  from where to retrieve the file.
* :fire:
  **Tip:** you can use `HEAD~1` to refer to the second-to-last commit.

<details><summary><b>:white_check_mark: Solution</b></summary>

The **`--source`** argument is used to indicate from which commit the file
should be restored. You can pass a commit ID (hash), or use a reference to
a commit such as `HEAD~1` in the solution below. `HEAD~1` refers to the
parent of the current `HEAD`.

```sh
git restore --source HEAD~1 tests/output.csv
```

</details>

<br>
<br>
<br>

## Exercise 2 - The Git reference web page  [30 min]

:rocket:
**Objective:** learn to use a basic branched workflow.

Well done! Your burgeoning Git skills have landed you a job as a junior
web-developer at _Scamazone Inc._, where you have been assigned the gratifying
task of fixing bugs in their website.

Let's get started:

1. Change directory into `/exercise_2`. You will see that it already contains
   a Git repository, as well as an HTML page named `references.html`.  
2. Open the `references.html` page in your web browser.
3. Explore the content of the Git repo using the `git log`, `git status` and
   `git branch` commands.

:question:
**Questions:**

* How many commits have already been made in the repo?  
* How many branches are present in the repo? How are they named?  
* Are there any uncommitted changes?  

<details><summary><b>:white_check_mark: Solution</b></summary>

```sh
cd exercise_2/
git log
git log --oneline  # There are 3 commits in the repo.
git branch         # There is currently only 1 branch: main.
git status         # There is one tracked file with uncommitted changes: references.html
```

</details>
<br>

### A) Fix the broken "ProGit" link

Your first task is to fix the broken link to the "ProGit" book in the HTML
page (currently when you click on the "ProGit" link with the webpage open in
your browser, it returns an error).

Since **we want to follow good practices**, we will _not_ work on this fix in
the **`main` branch**. Instead we will create a new branch, fix the link
problem on that branch, test our fix, and then merge it into `main` once we
are confident the problem is solved.

The reason we proceed in this way is because `main` is the branch that is used
to generate the **production version** of the Scamazone website (the version
that customers can see), and we don't want to make changes to that production
version until we are really sure that the changes we introduce in the code are
working as expected.

1. Before working on our fix in a new branch, we need to
   **make sure that our working tree is clean**:
    * Check the Git repo to see if there are any uncommitted changes.
    * If there are, display the uncommitted changes to see what they do. Even
      if you are not familiar with HTML, it should be easy enough to figure-out
      what the changes do.

2. Now that you have figured-out what the uncommitted changes do, stage the
   changes and **make a commit with a meaningful message**.  
   Verify that your working tree is now clean.

3. **Create a new branch named `fix`** and switch to it. This `fix` branch is
   where we will work on our bug fix, so that our changes to the code base
   remain isolated from the `main` branch until we are sure our fix is fine.

4. On the new branch, edit the `references.html` file to fix the link to the
   "ProGit" book.  
   :dart:
   **Hint:** to fix the link, add `https://` in front of the URL.  

5. **Verify in your browser** that the link is now working properly (you might
   have to reload the page).  
   If it is the case, you can commit your changes.
   Please **use a meaningful commit message**.

6. Now that our bug fix is production ready, **merge the `fix` branch into `main`**,
   then run `git log --all --decorate --oneline --graph` (or the `git adog`
   command if you have created this alias). At this point, the output should
   look like this
   (commit ID values will differ and your commit messages may be different):

   ```txt
    * 50a2e7f (HEAD -> main, fix) Fix broken ProGit link
    * e6a6176 Add Git logo placeholder to the Git reference webpage
    * 8a7444c Add Git logo file
    * c99fb57 Add links to Git resources
    * 5b54605 First commit. Add template for the Git reference page
   ```

7. **Delete the `fix` branch** as it is no longer needed.  
   Run `git branch` and/or `git log --all --decorate --oneline --graph` to make
   sure the `fix` branch was deleted.  

Enjoy your Git reference page. You can have a look at the different links if
you want to learn everything about Git!

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

1. Check if the working tree is clean, and see uncommitted changes.

   ```sh
    git status   # This shows that the references.html file has uncommitted changes.
    git diff     # Display the uncommitted changes in the file.
   ```

2. Commit the changes.

    ```sh
     git add references.html  # Stage the changes in the references.html file.
     git commit -m "Add Git logo placeholder to the Git reference webpage"

     # You can also use these shortcut for the above 2 lines:
     git commit -m "Add Git logo placeholder to the Git reference webpage" references.html
     # or
     git commit -am "Add Git logo placeholder to the Git reference webpage"

     git status  # There are no more uncommitted changes.
    ```

3. Create a new "fix" branch and switch to it.

    ```sh
     git branch fix
     git switch fix

     # You can use the following shortcut to create + switch to a branch in
     # a single command:
     git switch -c fix
    ```

4. Edit the HTML page, then verify in the browser that the link now works.
   You can use any text editor to do this.

    ```sh
    vim references.html
    ```

5. Make a commit with the changes:

    ```sh
     # Stage your changes (i.e. add changes to the Git index).
     git add references.html
     # Make a commit.
     git commit -m "Fix broken ProGit link"

     # Here are shortcuts for the above 2 lines:
     git commit -m "Fix broken ProGit link" references.html
     # or
     git commit -am "Fix broken ProGit link"
    ```

6. Merge `fix` into `main`.
   Note that no additional commit is created by the merge, because this is a
   "fast-forward" merge.

    ```sh
     git switch main
     git merge fix    

     # Display repo commit history.
     git log --all --decorate --oneline --graph
    ```

7. Delete the `fix` branch.

    ```sh
     git branch -d fix

     # Verify that the "fix" branch is gone.
     git branch

     # Show repo history again.
     git log --all --decorate --oneline --graph
    ```

</details>
<br>

### B) Additional Tasks (if you have time): add an image and new links

In this second part of the exercise, you are tasked to add a couple of new
links to books on the Git reference page.  
Here is what you should do:

1. Work in a **new branch** named `dev`.  

2. **Make a commit** that adds the following 2 references at the end of the
   list in the HTML page:  
   > `<li><a href="https://www.manning.com/books/learn-git-in-a-month-of-lunches">Learn git in a month of lunches</a></li>`  
   > `<li><a href="https://www.amazon.com/Git-Porch-Willie-Crawford-2006-02-01/dp/B01K95YGYG">Git Porch</a></li>`

    * Use **`git diff`** and **`git diff --cached`** to look at your edits in
      the HTML file, before and after staging them.
    * :question:
      **Question:** what is the difference between `git diff` and
      `git diff --cached`?
    * Check whether you did a proper job by refreshing the HTML page in your
      browser _before_ you commit your changes.  
   <br>

3. **Make a commit** that adds the Git logo to the webpage.
    * Replace the placeholder line that starts with `<!-- Add Git logo placeholder`
      by `<img src="git_logo.png">` in the HTML file.
    * :pushpin:
      **Note:** check whether you did a proper job by refreshing the HTML page
      in your browser _before_ you commit your changes.

4. When you have added these new features - and tested that they actually work
   by reloading the `references.html` page in your browser (new links are
   working, logo was added) - merge your `dev` branch into `main`.

5. **Run `git log --all --decorate --oneline --graph`** to display your entire
   repository's history. It should look like this:  
   (commit ID values will differ and commit message may be different)

   ```txt
    * ba4687a (HEAD -> main, dev) Add git logo
    * 30b149a Add two new books to Git reference page
    * 50a2e7f Fix broken ProGit link
    * e6a6176 Add Git logo placeholder to the Git reference webpage
    * 8a7444c Add Git logo file
    * c99fb57 Add links to Git resources
    * 5b54605 First commit. Add template for the Git reference page
   ```

6. **Delete the `dev` branch**, you no longer need it.  
   Verify it was deleted by running `git branch` and/or
   `git log --all --decorate --oneline --graph`.

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

Add new links to the web page:

```sh
# 1. Create and switch to a new "dev" branch.
git switch -c dev

# 2. Add the new references to the web page.
vim references.html     # Edit HTML page to add the new links...
git diff
git diff --cached
# After having checked that the two new links are working, stage and commit the changes.
git add references.html
git diff
git diff --cached
git commit -m "Add two new books to Git reference page"
```

:question:
**Question answer:** the difference between `git diff` and `git diff --cached`
is that the former will display the difference between the working tree
(files on disk) and the git index, while the later shows the difference
between the git index and the latest commit.

Add a Git logo to web page:

```sh
# 3. Edit the HTML page to add logo.
vim references.html
git commit -m "Add git logo" references.html
```

Merge changes into `main`, delete branch `dev`:

```sh
# 4. Merge "dev" into "main"
git switch main  # To merge "dev" into "main", we must be on the "main" branch.
git merge dev

# 5. Verify that both "dev" and "main" now point to the same commit.
git log --all --decorate --oneline --graph

# 6. Delete the "dev" branch.                             
git branch -d dev
```

</details>

<br>
<br>
<br>

## Exercise 3 - The crazy peak sorter script [30 min]

:rocket:
**Objective:** get familiar with rebasing branches, solving conflicts and
cherry-picking.

The stakes are raising! You are now taking the lead developer position of the
"peak sorter" project - a mesmerizing bash script that sorts all of the Alp's
4000 m summits in order of decreasing elevation (i.e. highest to lowest). It
also displays the name and elevation of the highest summit in the Alps when
completed.

* Start the exercise by changing your work directory to `exercise_3/` - it
  should be empty.
* Clone (download) the git repo for exercise 3 from GitHub with the command:
    ```sh
    git clone https://github.com/sibgit/peak_sorter.git
    ```
  :owl:
  **Reminder:** the **`git clone`** command yet creates (downloads) a local
  copy of a Git repository from an online source (typically on GitHub or
  GitLab). It is probably the most common way of starting to work on a
  repository.
  <br>
* You should now have a new directory named "peak_sorter". Enter it with the
  command `cd peak_sorter`.
* To see the peak sorter script in action, run the following command in your
  shell:
    ```sh
    ./peak_sorter.sh
    ```
* Have a look at the history of the git repo with
  `git log --all --decorate --oneline --graph` (or use the alias `git adog`,
  if you have created it).

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

```sh
# Clone the Git repository from GitHub.
cd exercise_3/
git clone https://github.com/sibgit/peak_sorter.git   

# Test-run the peak sorter script.
cd peak_sorter
./peak_sorter.sh                                      

# Display the Git repository's history
git log --all --decorate --oneline --graph
```

</details>
<br>

### A) Add a fix to the `main` branch

Your first task is to add a data integrity check to the `peak_sorter.sh`
script. Luckily a former developer of the project, Jimmy, has already worked on
this issue and made a commit with the fix in his own branch named `dev-jimmy`.
The message of the commit containing the fix is:

> peak_sorter: add check that input table has the ALTITUDE and PEAK columns  

To apply this commit on the `main` branch of the `peak_sorter` script, proceed
as follows:

1. **Create a new `hotfix` branch** - we wouldn't want to work directly on
  `main`, would we?.
2. **Cherry-pick** the commit that contains Jimmy's fix onto your `hotfix`
   branch.
3. When the cherry-pick is completed, test run the `peak_sorter.sh` script to
   **make sure nothing was broken**:
    ```sh
    ./peak_sorter.sh
    ```
   * When running the script, you should now see an additional printed line
     informing you that a data integrity check was performed:
     > Running data integrity check...OK
   * This shows us that the cherry-picked commit has indeed added the expected
     feature to our code.
   * You can also have a look at the changes introduced by the cherry-pick with
     `git show HEAD` to review the last commit on the current branch.
4. When you are confident things are working as expected,
   **merge the `hotfix` branch into `main`**.
5. **Delete the `hotfix` branch**.

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

1. Create a new `hotfix` branch and switch to it:

    ```sh
    git switch -c hotfix
    ```

2. Apply Jimmy's fix using cherry-picking on a temporary `hotfix` branch.

    ```sh
     # Search for the commit containing Jimmy's fix.
     # -> "peak_sorter: add check that input table has the ALTITUDE and PEAK columns"
     #
     # By looking at the output of the command below, we find that the
     # commit ID we are looking for is: 8e0d4fe
     git log --all --decorate --oneline --graph

     # Apply the commit onto our current branch.
     git cherry-pick 8e0d4fe

     # Verify the commit was properly cherry-picked.
     git log --all --decorate --oneline --graph
    ```

3. Test run the script to verify nothing is broken and have a look at the
   changes introduced by the cherry-pick.

    ```sh
     ./peak_sorter.sh
     git show HEAD
    ```

4. Merge the fix back into `main`.

    ```sh
     git switch main
     git merge hotfix

     # Verify that "hotfix" and "main" now point to the same commit.
     git log --all --decorate --oneline --graph

     # Test-run the script and delete the temporary "hotfix" branch.
     ./peak_sorter.sh
    ```

5. Delete the `hotfix` branch.

    ```sh
     git branch -d hotfix
    ```

</details>
<br>

### B) Add the "Dahu count" feature to the `main` branch

Your next task is to add a new feature to the `peak_sorter.sh` script. This new
feature - which will take the peak sorter script to new heights - should add
the number of [Dahu](https://en.wikipedia.org/wiki/Dahu) observations made on
each alpine peak to the output of the script.  

Again, you're in luck, because this feature has already been developed in a
branch of the Git repo. That branch is aptly named `feature-dahu`.  
Proceed as follows:  

1. **Checkout the `feature-dahu` branch** and test whether the new "Dahu count"
   feature has been implemented properly by running:

    ```sh
   ./peak_sorter.sh
   ```

   :pushpin:
   **Note:** when switching to a branch that already exists on a remote,
   there is no need to add the `-c/--create` option to `git switch`. Here,
   this means that you can simply run `git switch feature-dahu` and Git will
   automatically create a local branch `feature-dahu` based on
   `origin/feature-dahu`.

   Verify that the script prints Dahu counts as part of its output. A column
   named `DAHU_POPULATION` should now also be present in the output file
   `sorted_peaks.txt`. You can have a look at this file with the command:

   ```sh
   head sorted_peaks.txt
   ```

   To bring the Dahu count feature from the `feature-dahu` branch into the
   `main` branch, we will proceed in 2 steps: first we will rebase
   `feature-dahu` onto `main`, and then merge `feature-dahu` into `main`.  
   For now, let's display the **history of the git repo** with:
   `git log --all --decorate --oneline --graph` (i.e. `git adog`), so that we
   can compare it before and after the rebase that we will do at the next step.

2. **Rebase the `feature-dahu` branch on `main`**. This will result in
   conflicts that you have to manually resolve. In all 3 conflicts, always keep
   the version that is coming from the feature branch (it's the second version
   when you open the file to manually solve the conflicts - the version that is
   _not_ coming from `HEAD`).

3. When you completed the rebase, run again:

    ```sh
    ./peak_sorter.sh
    ```

   It should still display the number of Dahus observed on the Alps' highest
   peaks as it did before the rebase. And it should also display the data
   integrity check message `### Running data integrity check...OK` that
   we added to `main` earlier (because our `feature-dahu` branch now also
   contains the latest commits of `main`).

   Look again at your repo's history (`git adog`). Compare it to what you had
   before the merge (scroll up in your shell), to visually see how the rebase
   operation changed the history. Note how the hashes of the commits in the
   `feature-dahu` branch have changed.

4. When you are confident that the new Dahu count feature is correctly
   implemented, you can **merge `feature-dahu` into the `main` branch**.
    * :question:
      **Question:** do you expect any conflicts to occur during this merge?

At the end of the exercise, your history (`git log --all --decorate --oneline --graph`)
should look like this:  
(some commit ID values will differ)

```txt
* 02af2d4 (HEAD -> main, feature-dahu) peak_sorter: display highest peak at end of script
* 6d28329 peak_sorter: added authors as comment to script
* 249b8b4 peak_sorter: improved code commenting
* e81dc49 peak_sorter: add Dahu observation counts to output table
* 6c86af7 README: add more explanation about the added Dahu counts
* dfd80eb Add Dahu count table
* e3dc26e peak_sorter: add check that input table has the ALTITUDE and PEAK columns
* 351dca6 (origin/main, origin/HEAD) peak_sorter: added authors to script
* f3d8e22 peak_sorter: display name of highest peak when script completes
| * 076aa80 (origin/feature-dahu) peak_sorter: display highest peak at end of script
| * d29958d peak_sorter: added authors as comment to script
| * 6c0d087 peak_sorter: improved code commenting
| * 89d201f peak_sorter: add Dahu observation counts to output table
| * 9da30be README: add more explanation about the added Dahu counts
| * 58e6152 Add Dahu count table
|/  
* cfd30ce Add gitignore file to ignore script output
* f8231ce Add README file to project
| * 8e0d4fe (origin/dev-jimmy) peak_sorter: add check that input table has the ALTITUDE and PEAK columns
| * ff85686 Ran script and added output
|/  
* 821bcf5 peak_sorter: add +x permission
* 40d5ad5 Add input table of peaks above 4000m in the Alps
* a3e9ea6 peak_sorter: add first version of peak sorter script
```

<br>

:pushpin:
**Notes:**

* In a real application, you would now push your changes on `main` to the
  remote repository on GitHub with the `git push` command. In this exercise
  however, you do not have the permissions on the remote repository to perform
  this action.
* Trying to delete the local branch `feature-dahu` with the safe
  **`git branch -d`** option will not work, because changes on the branch
  have not been pushed to the upstream branch `origin/feature-dahu`.
  If you wanted to delete the `feature-dahu` branch, you would need to use the
  `-D` option to **force-delete** the branch: `git branch -D feature-dahu`.
* If you wanted to push changes in `feature-dahu` to the remote, you would
  need to use `git push --force` to overwrite the branch's history on the
  remote. This is because **rebasing a branch modifies its history**: the
  history of the local and remote instance of the `feature-dahu` branch have
  now **diverged**.
* To see this divergence in history, you can run
  `git log --all --decorate --oneline --graph` and look at the
  `feature-dahu` and `origin/feature-dahu` branches.

<br>

<details><summary><b>:white_check_mark: Solution</b></summary>

1. Checkout the `feature-dahu` branch. Run the script to test that the
   "Dahu count" feature works.

    ```sh
     git switch feature-dahu
     ./peak_sorter.sh

     # Display the repo history, so we can then compare it before and after the merge.
     git log --all --decorate --oneline --graph
    ```

2. Rebase `feature-dahu` on `main`. As there are conflicts, we need to manually
   resolve them by opening the conflicted file in an editor, resolving the
   conflict, then running `git add peak_sorter.sh` and `git rebase --continue`.

    ```sh
     git rebase main

     # There are 3 conflicts, so repeat the steps below 3 times.
     vim peak_sorter.sh        # Open file in editor to solve the conflict.
     git add peak_sorter.sh
     git rebase --continue

     # When the rebase is completed, test-run the script to see if everything is
     # still working after the rebase.
     ./peak_sorter.sh
    ```

3. We are now ready to merge `feature-dahu` into `main`.

    ```sh
     git checkout main
     git merge feature-dahu  # This is now a fast-forward merge -> no conflicts.

     # Test run to see if everything is still working after the merge.
     ./peak_sorter.sh        
    ```

   :question:
   **Question answer:** since we have rebased the branch `feature-dahu` on
   `main`, the merge will be **fast-forward** and there will be no conflicts.

</details>

<br>
<br>
<br>

## Exercise 4 - The Awesome Animal Awareness Project [60 min]

:rocket:
**Objective:** learn to collaborate with others on a project hosted on GitHub
or GitLab.

Congratulations! Your improving Git skills have not gone unnoticed, and you are
now hired by our agile startup to work on the
**Awesome Animal Awareness Project** !

Your mission - should you choose to accept it - is to help us build a new
website. This is a **collaborative effort**, and you will be working in teams
of 3 people.
Each team will contribute a web page about a specific - and awesome - animal.
At the end of the exercise, the page created by your team will be integrated
into the [Awesome Animal Awareness website (GitHub)](https://sibgit.github.io)
or [Awesome Animal Awareness website (GitLab)](https://sib-git-training.gitlab.io/awesome-animal-awareness)
, depending on whether the class is taught with GitHub or GitLab.

:fire:
**Important:**

* Please follow the **naming convention for branches** tightly,
  as our company's internal Git policies are **very strict**.
* **Before you start:** make sure that you created a
  **personal access token (PAT)** on GitHub/GitLab. This will be needed in
  order to allow you to push changes to GitHub/GitLab. Please refer to the
  course slides for instructions on how to create the token (a demo might also
  be made in the class before the exercise).

<br>

### A) Organize your team

1. **Get together:** go to the
   [course's google doc page](https://docs.google.com/document/d/1EX72NInz-eA2d2GOa5aTB8D88GWb91Sk-sCNHwQYXqE)
   and check which team you belong to by looking at the **Team** column in the
   GitHub/GitLab user names table.
    * **On-site course:** locate your other team members in the classroom and
      sit together so you can communicate.
    * **Online course:** you will be placed in a breakout-room with your
      teammates. Remember that you can use the "share screen" function to
      help each other and show to other team members what you are doing on
      your machine.
   <br>

2. Change into `exercise_4/`. Then **clone the Awesome Animal Awareness project**,
   and **enter the cloned repo**. Here are the commands to do this:  
   * If working with **GitHub**:
      ```sh
      git clone https://github.com/sibgit/sibgit.github.io
      cd sibgit.github.io
      ```
   * If working with **GitLab**:
      ```sh
      git clone https://gitlab.com/sib-git-training/awesome-animal-awareness
      cd awesome-animal-awareness
      ```
   * :fire:
     **Important**: make sure to use the correct **GitHub** / **GitLab** repo,
     depending on whether the class is taught with GitHub or GitLab.
   <br>

3. Among your group, **one person** should **create a new team branch**
   named after your animal's name followed by `-dev`, and then
   **push it to the remote** on GitHub/GitLab.
   * Example branch names: `tiger-dev`, `yeti-dev`, `sunfish-dev`,
     `pallas-cat-dev`, ...
   * :dart:
     **Hint**
     * When pushing a local branch to a remote **for the first time**,
       you have to indicate an "upstream" remote branch for the branch you are
       pushing.  
     * This is done by using the `-u / --set-upstream` option of `git push`:
        ```sh
         git push --set-upstream origin <branch you want to push>

         # Examples:
         git push --set-upstream origin sunfish-dev
         git push -u origin sunfish-dev  # -u is the shortcut for --set-upstream
        ```

   <br>

4. Other team members can now **fetch changes** from the repo and
   **checkout the new team branch** that was just pushed to the remote.
    * :fire:
      **Important:** other team members should _not_ create the team branch
      locally themselves. They should check it out from the remote.
    * For other team members, the `-u / --set-upstream` option is _not_ needed
      when they push changes to the team branch for the first time, because the
      upstream was automatically set by Git when checking-out the team branch
      from the remote.
   <br>

5. Each team member should now **create a personal branch**, using the
   following naming scheme:
   `<animal>-<your name>`, e.g. `tiger-sandra` or `pallas-cat-tom`. Note that
   this branch does not necessarily have to be pushed to the remote: it's your
   personal work branch, so it can stay local.

   :pushpin:
   **Note:** in a real application, you would probably want to push your
   personal branch to the remote as a backup (depending on how long-lived your
   branch is), but this is not necessary for this exercise.

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

Clone the Awesome Animal Awareness Project (A3P) repo.

```sh
cd exercise_4/
git clone https://github.com/sibgit/sibgit.github.io.git
cd sibgit.github.io
```

One person now creates the team branch and pushes it to the remote repository
on GitHub/GitLab. The example here is for the team `yeti`.

Note that, in the command below, `-u` is the short option for `--set-upstream`.
This option is needed because, at this point, the local `yeti-dev` branch
is not associated to any upstream branch on the remote.

```sh
# Create the team branch and switch to it.
git switch -c yeti-dev

# Push the branch to the remote
git push -u origin yeti-dev
```

Other team members can now pull the new team branch `yeti-dev` and switch
to it.

```sh
git fetch
git switch yeti-dev

# Display repo history and branches.
git log --all --decorate --oneline --graph
```

</details>
<br>

### B) Add content for your awesome animal

Each team member will now contribute something to the web page of the team's
animal.  

1. Switch to your **personal branch**.

2. On your personal branch, **edit the HTML file corresponding to your animal**.
   The topics that each member of the team has to work on are listed in the
   Google doc - see the **Task** column of the table.
   In the HTML file, the `??` mark the positions where you have to add your
   content (make sure to remove the `??` after you are done editing).
   * For the team member with the task "Animal name", make sure to include the
     [binomial name](https://en.wikipedia.org/wiki/Binomial_nomenclature) of
     the species as well, e.g. "Pallas's cat (_Otocolobus manul_)"
   * For the team member with the **task "Picture"**, you can either:
     * Link an existing image from somewhere on the web by setting
       `<img src=https://...>`.
     * Find and download a picture of your animal from the web, add the image
       to the project repo (at the root of the project directory), and insert
       the file name into `<img src="?? image-filename">`,
       e.g. `<img src="tiger_image.png">`.  
       :fire:
       **Important:** make sure to add the image file to your commit.

3. **Check the rendering of your HTML file** by opening it with your browser.

4. **Commit your changes** with a meaningful message.  

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

Each team member creates their personal work branch. The example here is for
`Alice`, working in team `yeti`.

Alice edits the `yeti.html` page in her favorite editor. When she is done, she
loads the page in her browser to make sure the rendering is looking good. Then
she commits her changes.

```sh
git switch -c yeti-alice
vim yeti.html             # Edit the web page.
git add yeti.html
git commit -m "Yeti: add habitat and distribution info"
```

</details>
<br>

### C) Merge your branch with your team's animal-dev branch

Each team member should now merge the edits made on their personal branch (e.g.
`tiger-sandra`) into the team's main development branch (e.g. `tiger-dev`), and
then push the changes back to the remote repo on GitHub/GitLab.

This is **best done as a coordinated, iterative, process**, where each member
will in turn:

1. **Do a `git pull`** on the team's main development branch to make sure their
   local copy is up-to-date.  
   * :fire:
     **Important:** verify that you are on the correct branch before running
     `git pull`.  
   * :pushpin:
     **Note:** in situations where you are not sure whether a remote branch has
     diverged from your local copy, you can do a `git fetch` + `git status`
     before running `git pull`. In this way you will see whether the merge
     that will be done by `git pull` will be fast-forward or not.
   * :owl:
     Reminder: `git pull` is a shortcut for `git fetch` + `git merge <upstream>`.

2. **Rebase their personal branch** on the team's main development branch. Note
   that the first person to add their changes will in principle _not_ need to
   rebase, since their personal branch will already be rooted at the latest
   commit of the team's main development branch.

3. **Merge the changes** from their personal branch into the team's main
   development branch.

4. **Push the changes** back to the remote repo on GitHub/GitLab. Then let the
   next team member know that they can proceed.

<br>

After all team members have gone through the above steps, the team's main
development branch should contain the work of all 3 team members.

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

Each member of the team must now add the changes they made on their personal
branch to the team branch. Let's assume that Alice is either the second or
third team member to add her changes, and therefore she has to rebase her
branch `yeti-alice` onto `yeti-dev`.

Alice updates her local version of the team branch.

```sh
git switch yeti-dev

# Fetch updates from remote and merge them with local yeti-dev branch.
git pull
```

Alice rebases her personal branch on the team branch.

```sh
git switch yeti-alice
git rebase yeti-dev    # Conflicts will appear. Alice must solve them manually.
git add yeti.html
git rebase --continue
```

Now that the rebase is completed, Alice merges her branch into `yeti-dev`.
Then she pushes the updated `yeti-dev` branch to the remote and lets her
team members know that she is done.

```sh
git switch yeti-dev
git merge alice-dev   # This is now a simple fast-forward merge.
git push

# Optional: Alice can now delete her personal branch, if it is no longer needed.
git branch -d alice-dev
```

</details>
<br>

### D) Create a pull request / merge request

Now that your team branch is all merged and clean, it's time to contribute
your work to the **`main`** branch of the project. Since you do not have the
permission to push commits to the remote on the `main` branch, you will
instead contribute your changes via a **Pull Request** (GitHub) /
**Merge Request** (GitLab).  
In this way, the top-level management of the Awesome Animal Awareness project
will be able to verify and approve your work before it gets added to `main` and
becomes part of the production version of the website.

One person in the team can now **open a Pull Request** (or a
**Merge Request** if using GitLab) for the team branch to be merged into the
project's `main` branch.

1. Creating a Pull Request (Merge Request) is done online, in the project's
   [GitHub repository](https://github.com/sibgit/sibgit.github.io) or
   [GitLab repository](https://gitlab.com/sib-git-training/awesome-animal-awareness).
   In the **Pull requests** / **Merge requests** tab, click on
   **New pull request** / **New Merge request**.
   For more details on how to create a pull request / merge request, please
   refer to the course slides.

2. Once management approved your work and merged it into `main`, you should
   be able to see your animal's page on the
   [Awesome Animal Awareness website (GitHub)](https://sibgit.github.io) or
   [Awesome Animal Awareness website (GitLab)](https://gitlab.com/sib-git-training/awesome-animal-awareness)!

Well done! Enjoy your success by reading about your awesome animal and
looking-up some of the other teams' pages.

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

Now that the animal page is completed, one team member can open a
**pull request** on GitHub/GitLab.

* When the Pull Request is accepted, the commits on `yeti-dev` will be
  merged into the `main` branch of the project.
* All members of the team can then view their work at https://sibgit.github.io.
  Note that it sometimes takes a few minutes before the changes become live
  on the website.

Each team member can now also and update their local repository.

```sh
# This check is optional, but can be used to make sure the merge from
# "git pull" will be fast-forward.
git fetch
git status

# Update the team branch and `main` branch with the changes.
git switch yeti-dev
git pull
git switch main
git pull
```

</details>
<br>

### E) Additional Tasks (if you have time): branch cleanup

After your team branch has been merged into the `main` branch of the project,
you can now delete your team branch and personal branches (since they have been
merged).

1. Each team member can **delete their personal branch** and **team branch**
   from their local repo.

2. One person in the team can **delete the team branch on the remote**. The
   command for this is:

    ```sh
    git push origin --delete <branch name>
    ```

   Alternatively, the team branch can also be deleted via the web interface of
   GitHub/GitLab.

3. Each team member can then **update their local copy of `main`**.

    ```sh
    git fetch --prune
    git switch main
    git pull
    ```

<br>

:pushpin:
**Note:**

* The **`--prune`** option in **`git fetch --prune`**
  **removes references to remote branches** (i.e. remote-tracking references)
  that no longer exist on the remote. For instance, if a team branch was
  deleted on the remote (after it was merged into `main`), then you will
  probably also want to delete your local reference to this remote branch from
  your local copy of the repo.  
* The `--prune` option can also be passed to `git pull`: **`git pull --prune`**.

<br>
<details><summary><b>:white_check_mark: Solution</b></summary>

```sh
# 1. Delete the remote instance of the team branch.  
#    Note: only 1 person in the team needs to do this.
git push origin --delete yeti-dev

# 2. Delete local instances of the team branch and the personal branch.
git branch -d yeti-alice
git branch -d yeti-dev

# 3. Update the local instance of the `main` branch.
#    Note the usage of the `--prune` option to delete the local pointer to
#    the former (now deleted) team branch.
git fetch --prune
git switch main
git pull
```

</details>

<br>
<br>
<br>
