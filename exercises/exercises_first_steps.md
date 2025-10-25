# Exercises - first steps with Git

<br>

## Before you start

* 📚 **Exercise material setup:** download the
  [exercises_first_steps.zip](../exercises/exercises_first_steps.zip) file to
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

To see the config values that are currently set, the commands are the
following:

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

🚀 **Objective:** learn how to create a new Git repository, add files to it,
and make commits.

Welcome to the first exercise of this Git course !
This is a warm-up, so you will be guided step-by-step on exactly what you need
to do.

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
   directory (the current working directory) with the command:

   ```sh
   git init   # Initialize a new Git repository.
   ```

   Initializing a new Git repo creates a **hidden `.git` directory**. You
   can view this directory by running the shell command:

   ```sh
   ls -la   # You should observe that a new ".git" hidden directory was created.
   ```

   > 🔥 **Important**
   >
   > The `.git` directory is where Git stores the entire history of your
   > repository (as well as various settings). If you delete it, all your
   > version control history (and settings) for this repository
   > **will be permanently lost** (there is no "undo" !).
   >
   > You can nevertheless do this in certain circumstances, e.g. if you want
   > to start this exercise from scratch again.

   <br>

3. **Display the status of files** in the project's working tree:
   * Run the command `git status`.
   * ❓ **Question:** what is the status of the files in your working
     directory ?
     <br>

      <details><summary><b>✅ Solution</b></summary>

      **Running `git status`**, we see - as expected at this point - that
      **all files are untracked**. Here is the output of `git status`:

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

   > 🦉 **Reminders**
   > * _staging_ a file is synonym of _adding to the Git index_.
   > * The command to stage files is: `git add <files or directories>`.
   >   For instance, `git add README.md` will stage the file `README.md`.

   <br>
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

   <details><summary><b>✅ Solution</b></summary>

   There are several ways we can stage all the requested files:

   * By staging individual files:

     ```sh
      git add README.md
      git add script.py
      git add doc/
      git add tests/tests.py
      git add tests/output.csv

      # Note that we can also stage all files in a single command:
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

     Note that in this specific case we cannot use `git restore --staged` to
     remove changes from the Git index, because we do not have any commits yet
     in the repository (and `git restore --staged` needs a commit to restore
     from).

   </details>
   <br>

5. **Add a first commit** to the repo with the commit message
   `Initial commit for test project`.

   The command to make a commit is: **`git commit -m "commit message"`**
   (or, in the long form: `git commit --message "commit message"`).

   After the commit is done, run the following commands:
   * **`git log`**: to display the repository's history. At this point you
     should have a single commit that looks like the following (your exact
     values for commit hash, date, etc. will differ):

     ```txt
     commit a0da6303e9d6dfc34986f959a076721e153f382d (HEAD -> main)
     Author: Your Name <your.email@example.org>
     Date:   Mon Oct 14 13:55:08 2024 +0200

     Initial commit for test project
     ```

   * **`git show`**: to have a look at the content of your commit.

      > 🌈 **Note:** when the amount of text to be printed by `git show`
      > exceeds one screen, the content is shown with the GNU program `less`.
      > In `less`, you can use your keyboard arrow keys to move up/down, and
      > press `q` to exit and return to the shell.

    <br>

   ❓ **Question:** why are the details of the `doc/user-guide.pdf` file not
   displayed by `git show`?

    <details><summary><b>✅ Solution</b></summary>

      ```sh
      git commit -m "Initial commit for test project"
      git log     # At this point the commit history contains a single commit.
      git show    # Show content of the last commit.
      ```

      Looking at the output of `git show`, we can see that the newly added
      content for the file `doc/user-guide.pdf` is _not_ displayed (unlike
      for `README.md` for instance, where the content of the file is shown).

      The reason is that `user-guide.pdf` is a **binary file** and not a
      plain text file. Git does not display details for binary files.

    </details>

   <br>

   > ✨ **Tip:** to crate a commit with a multi-line commit message, we can
   > run the command `git commit` with no addition arguments.
   >
   > This opens a text editor (by default `vim`) where one can manually enter
   > the commit message. The convention for multi-line messages is to have a
   > summary on the first line, followed by a blank line, followed by one or
   > more lines describing. Here is an example:
   >
   > ```txt
   > Initial commit for test project
   >
   > This is the first commit for test-project.
   > Can't want to add more!
   > ```
   >
   > If you want to add even more structure to your commit messages, have
   > a look at [Conventional Commits](https://www.conventionalcommits.org).

<br>

### Part B: commit changes to tracked files

In this section, we will make an update to the `README.md` file, and then
create a new commit that adds the change we made to our Git repo.

1. **Open the `README.md` file** in your favorite text editor.
   * Change the 3rd line of the file to:

     > Demo project for the Git course. This will be great!

   * Save your changes and close the file.
   * Run **`git status`**. The `README.md` file should now be listed as
     modified:

      ```txt
      Changes not staged for commit:
          modified:   README.md

      Untracked files:
          script.pyc
          tests/
      ```

   <br>

2. **Display the changes** to files in the working tree.

   Run the command **`git diff`**. This displays the difference in tracked
   files between the working tree and the Git index (staging area). In other
   words, this shows the modifications made to tracked files that are not
   yet staged.

     ```sh
     git diff
     git diff README.md  # Gives the same result, as only README.md was modified.
     ```

   This should show that `README.md` has one line removed (shown in red,
   prefixed with **`-`**), and one line added (shown in green, prefixed
   with **`+`**).

     ```diff
     -Demo project for the Git course.
     +Demo project for the Git course. This will be great!
     ```

   <br>

3. **Commit the changes** you just made.
   * Add/stage the changes made to `README.md` with **`git add`**.
     Remember that each time you modify a file and want to include these
     changes into your next commit, you have to `git add` that file again.

     > 🦉 **Reminder:** remember that each time you modify a file and want to
     > include these changes into your next commit, you have to `git add` that
     > file again.

     > ✨ **Tip:** to stage all modified files at once, you can use the
     > shortcut **`git add -u`**. Here it does not make a lot of difference as
     > there is only 1 modified file, but if there are many of them, this
     > command can be convenient.

   * Run `git status` again: you should see that the `README.md` file is now
     listed under `Changes to be committed:` (in green).
   * Commit your changes with the message `"Make README file more cheerful"`.

    <details><summary><b>✅ Solution</b></summary>

      ```sh
      git add README.md
      git commit -m "Make README file more cheerful"

      # Alternative: stage all modified files with "git add -u". Since only
      # README.md was modified, this is in the same as staging README.md.
      git add -u
      git commit -m "Make README file more cheerful"

      # Alternative: use a "git commit" shortcuts to stage + commit in a single
      # command.
      git commit -m "Make README file more cheerful" README.md

      # Alternative: stage all modified files and make a new commit.
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

   > ✨ **Tip**: you can create the `.gitignore` in any text editor you like,
   > but you can also easily generate it with a shell command:
   >
   > ```sh
   > echo "*.pyc" > .gitignore
   > ```

    <br>

2. **Run `git status`**: you should see that you still have an untracked
   file: the `.gitignore` file you just created :sweat_smile: !

   Since the ignore rules defined in the `.gitignore` file are useful to all
   users of the repository, this file should be added to the repo.

   * Stage the `.gitignore` file.
   * Make a new commit with commit message `Add *.pyc to ignore list`.

   Your working tree should now be "clean". Running `git status`, should
   output:

      ```txt
        On branch main
        nothing to commit, working tree clean
      ```

   <details><summary><b>✅ Solution</b></summary>

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

3. **Display the (modest) history of our Git repo** with the following
   variations of the **`git log`** command. Observe how history is displayed
   by each command:

    ```sh
    git log                      # Prints the full commit message along with author and date.
    git log --pretty=oneline     # 1 commit per line. Full commit hash/ID (checksum).
    git log --oneline            # 1 commit per line. Abbreviated commit hash/ID.
    git log --all --decorate --oneline --graph  # Shows commits for all branches.
    ```

    > 🌈 **Note** that with the current history of our git repo, the output of
    > `git log --all --decorate --oneline --graph` is the same as
    > `git log --oneline`.
    >
    > This will however change when we start working with **branches**. The
    > longer version of the command will then become very useful.

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

   > ✨ **Tip:** to list your Git aliases, use:
   > `git config --list | grep ^alias`

<br>

### Additional Tasks (if you have time) ✏️

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

**1. Removing content from the Git index (unstaging).**

Start by staging all untracked and modified files with `git add --all`.
The status of your files should look like:

  ```txt
  Changes to be committed:
      new file:   personal_notes.md
      modified:   script.py
  ```

Actually, we do _not_ want to add all these changes to the repository,
so **let's unstage them**.

* Unstage the changes to `script.py` using the command: **`git restore --staged`**

* Unstage the entire file `personal_notes.md`, using either
  **`git restore --staged`** or **`git rm --cached`**.

  > 🦉 **Reminder:** the difference between `git rm --cached` and
  > `git restore --staged` is that `git rm --cached`
  > **deletes the entire file from the index**, while `git restore --staged`
  > **reverts it to the version in the last commit** (`HEAD` commit).
  >
  > The reason why, in this particular case, `git rm --cached` does the same
  > as `git restore --staged` is because `personal_notes.md` is a newly added
  > file.
  >
  > There is thus no difference between removing it completely, or just
  > resetting it back to its version from the latest commit (since it is
  > absent from the latest commit).
  >
  > ⚠️ **Warning**: be careful to _not_ run `git rm` instead of
  > `git rm --cached`, as this would not only remove the file from the
  > Git index, but also delete it from your working tree!

  <br>

* At this point, changes in `script.py` should again be unstaged, and
  `personal_notes.md` should be untracked. Run **`git status`** to confirm
  this:

  ```txt
  Changes not staged for commit:
    modified:   script.py

  Untracked files:
    personal_notes.md
  ```

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
  git add --all
  git restore --staged script.py           # Unstage changes to script.py
  git restore --staged personal_notes.md   # Unstage personal_notes.md

  # To unstage personal_notes.md, we can also use:
  git rm --cached personal_notes.md
```

</details>
<br>

**2. File staging shortcuts: `git add --update` vs. `git add --all`.**

In the task just above, we used `git add --all` to stage all files in the
working directory. Now we would like to stage only the modified file
`script.py`.

* Run the command **`git add -u`**, then look at the status of your files.
  You should see that only `script.py` was staged (because it's a modified
  file), but not `personal_notes.md` (because it's untracked).

    ```sh
    git add -u   # -u is the shortcut for --update
    git status
    ```

  We can see that modifications in `script.py` are now staged.

    ```txt
    Changes to be committed:
      modified:   script.py

    Untracked files:
      personal_notes.md
    ```

* Run `git restore --staged script.py` to unstage the changes to `script.py`.

<br>

> 🌈 **Summary**
>
> * `git add --update`: only adds/stages files that are **already tracked** in
>   Git. Does _not_ stage any new, untracked files.
>
> * `git add --all`: adds **all files** to the Git index (except ignored
>   files), regardless of whether they are already tracked (modified) or not
>   (untracked). In other words, it stages all files in the project directory.
>
> In a sense, `--update` is safer because it prevents you from adding
> completely new files to the Git repo by mistake.

<br>
<details><summary><b>✅ Solution</b></summary>

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

**3. Ignore a file using `.git/info/exclude`**

`personal_notes.md` is a file that we never intend to track and share with
other people. Therefore we would like to **ignore** it. However, since this
file is specific to our own local setup, it should only be ignored by our
local Git repo, and not by everyone else.

We can achieve this by adding the file name `.git/info/exclude`:

* Edit the file **`.git/info/exclude`** to ignore `personal_notes.md`.
  you can do this with a regular text editor, or using the following
  shell command:

  ```sh
    echo "personal_notes.md" >> .git/info/exclude

    # Display the content of the file:
    cat .git/info/exclude
  ```

* Run `git status` again. The file `personal_notes.md` should no longer
  be listed as _untracked_.

<br>

> 🌈 **Summary**
>
> in Git, files/patterns to ignore only in your local repo should be added
> to **`.git/info/exclude`** (rather than `.gitignore`). This is a text file
> that is automatically present in every `.git` repo.

<br>

**4. Reset changes to a file in the working tree.**

If you run **`git diff`**, you will see that we currently have an uncommitted
change in `script.py`:

```diff
+adding a bad line...
```

However, this is not a modification we want to keep. Instead, we would
like to **reset the content of `script.py`** to its previous version, i.e. the
version of `script.py` as found in the Git index or the previous commit.

* Using the command `git restore`, reset the content of `script.py` to its
  version as currently found in the Git index.
* Run `cat script.py` to make sure the "bad line" has been removed from the
  file.
* Run `git diff`: there should be no difference anymore (no output).
* Run `git status`: at this point, your working tree should be clean.

  ```txt
  On branch main
  nothing to commit, working tree clean
  ```

<br>

> ⚠️ **Warning**
>
> As you have just experienced, `git restore <file>` really overwrites
> uncommitted modifications in your files. Use this command carefully to
> avoid losing work by mistake.

<br>
<details><summary><b>✅ Solution</b></summary>

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

**5. Remove a file from a Git repository.**

Currently the file `tests/output.csv` is being tracked in our Git repo.
However, all things considered, this file is not really needed, and we now
would like to delete it from both our repo and working tree.

* Delete the file using the command **`git rm`**.
* Run `git status`: you should see that the was was deleted, and that this
  deletion is already staged.

  ```txt
  On branch main
  Changes to be committed:
    deleted:    tests/output.csv
  ```

* Make a new commit that removes this file from the repo. You can use the
  commit message `"Remove test output"`

<br>

> 🌈 **Note:** while we have delete the file `output.csv` from the Git index
> and the last commit, a copy of it still remains in the history of our
> repository.

<br>
<details><summary><b>✅ Solution</b></summary>

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

**6. Retrieve a file from an older commit.**

Let's imagine that, for some reason, we want to retrieve the file
`tests/output.csv` from our commit history.

* Try to run the following command to retrieve/restore the file `output.csv`
  from your Git repo history. Note that you need to replace `<commit ref>`
  with the commit ID of the commit from where to retrieve the file (this
  indicates the point in your Git history at which to retrieve the file).

  ```sh
  git restore --source <commit ref> tests/output.csv
  ```

  > ✨ **Tip:** you can also use `HEAD~1` to refer to the second-to-last
  > commit.

<br>

<details><summary><b>✅ Solution</b></summary>

The **`--source`** argument is used to indicate from which commit the file
should be restored. You can pass a commit ID (hash), or use a reference to
a commit such as `HEAD~1` which is used in the solution below.
`HEAD~1` refers to the parent of the current `HEAD`.

```sh
git restore --source HEAD~1 tests/output.csv
```

</details>

<br>
<br>
<br>

## Exercise 2 - The Git reference web page  [30 min]

🚀 **Objective:** learn to use a basic branched workflow.

Well done! Your burgeoning Git skills have landed you a job as a junior
web-developer at _Scamazone Inc._, where you have been assigned the gratifying
task of fixing bugs in their website.

Let's get started:

1. Change directory into `/exercise_2`. You will see that it already contains
   a Git repository, as well as an HTML page named `references.html`.
2. Open the `references.html` page in your web browser.
3. Explore the content of the Git repo using the `git log`, `git status` and
   `git branch` commands.

❓ **Questions:**

* How many commits have already been made in the repo ?
* How many branches are present in the repo? How are they named ?
* Are there any uncommitted changes?

<details><summary><b>✅ Solution</b></summary>

```sh
cd exercise_2/
git log
git log --oneline  # There are 3 commits in the repo.
git branch         # There is currently only 1 branch: main
git status         # There is one tracked file with uncommitted changes: references.html
```

</details>
<br>

### A) Fix the broken "ProGit" link

Your first task is to fix the broken link to the "ProGit" book in the HTML
page. Currently, when you click on the "ProGit" link with the webpage open in
your browser, it returns an error.

Since **we want to follow good practices**, we will _not_ work on this fix in
the **`main` branch**. Instead we will create a new branch, fix the link
problem on that branch, test our fix, and then merge it into `main` once we
are confident the problem is solved.

The reason we proceed in this way is because `main` is the branch that is used
to generate the **production version** of the Scamazone website (the version
that customers can see), and we don't want to make changes to the production
version until we are really sure that the changes we introduce in the code are
working as expected.

Let's get to work:

1. Before working on our fix in a new branch, it's best to
   **make sure that our working tree is clean**:
    * Check the Git repo to see if there are any uncommitted changes.
    * If there are, display the uncommitted changes to see what they do. Even
      if you are not familiar with HTML, it should be easy enough to figure-out
      what the changes do.

2. Now that you have figured-out what the uncommitted changes do, stage the
   changes and **make a commit with a meaningful message**. Then verify that
   your working tree is now clean.

3. **Create a new branch named `fix` and switch** to it. This `fix` branch is
   where we will work on our bug fix, so that our changes to the code base
   remain isolated from the `main` branch until we are sure our fix is fine.

4. Open the file `references.html` in a text editor, and fix the link to the
   "ProGit" book. After saving your changes, reload the page in your web
   browser to check that the link now works.

   > 🎯 **Hint:** to fix the link, add `https://` in front of the URL.

5. **Stage** your changes, and then **create a new commit**. Please
   **use a meaningful commit message**.

6. Now that the bug fix is production ready, you can
   **merge the `fix` branch into `main`**.

   Then, run the following command to display your repo history (or use
   `git adog` if you have created this alias):

   ```sh
   git log --all --decorate --oneline --graph
   ```

   Your output should look like this (commit ID values will differ and your
   commit messages may be different):

   ```txt
    * 50a2e7f (HEAD -> main, fix) Fix broken ProGit link
    * e6a6176 Add Git logo placeholder to the Git reference webpage
    * 8a7444c Add Git logo file
    * c99fb57 Add links to Git resources
    * 5b54605 First commit. Add template for the Git reference page
   ```

7. **Delete the `fix` branch** as it is no longer needed. Run `git branch`
   and/or `git log --all --decorate --oneline --graph` to make sure the
   `fix` branch was deleted.

Enjoy your Git reference page. You can have a look at the different links if
you want to learn everything about Git!

<br>
<details><summary><b>✅ Solution</b></summary>

1. Check if the working tree is clean, and see uncommitted changes.

   ```sh
    git status   # This shows that the references.html file has uncommitted changes.
    git diff     # Display the uncommitted changes in the file.
   ```

2. Commit the changes.

    ```sh
     # Stage the changes in references.html, then commit.
     git add references.html
     git commit -m "Add Git logo placeholder to the Git reference webpage"

     # Alternatively, we can also use these shortcut to stage and commit in
     # a singe command.
     git commit -m "Add Git logo placeholder to the Git reference webpage" references.html
     # or (this works because only the `references.html` file was modified).
     git commit -am "Add Git logo placeholder to the Git reference webpage"

     git status  # There are no more uncommitted changes.
    ```

3. Create a new "fix" branch and switch to it.

    ```sh
     git branch fix
     git switch fix

     # Alternatively, we can use the following shortcut to create + switch to
     # a branch in a single command.
     git switch -c fix
    ```

4. Edit the HTML page, then verify in the browser that the link now works.
   You can use any text editor to do this.

    ```sh
    vim references.html
    ```

5. Make a commit with the changes:

    ```sh
     # Stage the changes (i.e. add changes to the Git index).
     git add references.html
     # Make a commit.
     git commit -m "Fix broken ProGit link"

     # Here are shortcuts for the above 2 lines:
     git commit -m "Fix broken ProGit link" references.html
     # or
     git commit -am "Fix broken ProGit link"
    ```

6. Merge `fix` into `main`. Note that no additional commit is created by the
   merge, because this is a "fast-forward" merge.

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

### B) Additional Tasks: add new links ✏️

In this second part of the exercise, you are tasked with adding a couple of new
links to the Git reference page.

Here is what you should do:

1. Create a **new branch** named `dev`.

2. Add the following 2 references at the end of the list in the
   `references.html` HTML page:

    > * `<li><a href="https://www.manning.com/books/`
    >   `learn-git-in-a-month-of-lunches">Learn git in a month of lunches</a></li>`
    > * `<li><a href="https://www.amazon.com/`
    >   `Git-Porch-Willie-Crawford-2006-02-01/dp/B01K95YGYG">Git Porch</a></li>`

   Make sure to check that you did a proper job by reloading the HTML page
   in your browser _before_ you proceed to commit your changes.

3. **Stage** and then **commit** your changes:
    * Use **`git diff`** and **`git diff --cached`** to look at your edits in
      the HTML file, before and after staging them.
    * ❓**Question:** what is the difference between `git diff` and
      `git diff --cached` ?

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# 1. Create and switch to a new "dev" branch.
git switch -c dev

# 2. Add the new book references to the web page.
vim references.html     # Edit HTML page to add the new links...
git diff
git diff --cached

# 3. After having checked that the two new links are working,
#    stage and commit the changes.
git add references.html
git diff
git diff --cached
git commit -m "Add two new books to Git reference page"
```

**Question answer:** the difference between `git diff` and `git diff --cached`
is that the former will display the difference between the working tree
(files on disk) and the git index, while the later shows the difference
between the git index and the latest commit.

</details>
<br>

### C) Additional Tasks: add a logo ✏️

In this last part of the exercise, we further improve our webpage by adding
a logo.

1. **Edit** the `references.html` webpage, replacing the placeholder line
   that starts with `<!-- Add Git logo placeholder` by
   `<img src="git_logo.png">`.

   Make sure to check that you did a proper job by reloading the HTML page
   in your browser _before_ you proceed to commit your changes.

2. **Commit** your changes with the message `Add git logo`.

3. Now that we have added all the features we wanted to our webpage, we can
   **merge** the `dev` branch into `main`.

4. **Run `git log --all --decorate --oneline --graph`** to display your entire
   repository history. It should look like this (commit ID values will differ
   and commit message may be different):

   ```txt
    * ba4687a (HEAD -> main, dev) Add git logo
    * 30b149a Add two new books to Git reference page
    * 50a2e7f Fix broken ProGit link
    * e6a6176 Add Git logo placeholder to the Git reference webpage
    * 8a7444c Add Git logo file
    * c99fb57 Add links to Git resources
    * 5b54605 First commit. Add template for the Git reference page
   ```

5. **Delete the `dev` branch**, you no longer need it. Verify the branch was
   deleted by running `git branch` and/or
   `git log --all --decorate --oneline --graph`.

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# 1. Edit the HTML page to add logo.
vim references.html

# 2. Commit the changes. This is using a shortcut command to stage and
#    commit the file.
git commit -m "Add git logo" references.html

# 3. Merge "dev" into "main".
git switch main  # To merge "dev" into "main", we must be on the "main" branch.
git merge dev

# 4. Show history to verify that "dev" and "main" now point to the same commit.
git log --all --decorate --oneline --graph

# 5. Delete the "dev" branch.
git branch -d dev
```

</details>

<br>
<br>
<br>

## Exercise 3 - The crazy peak sorter script [30 min]

🚀 **Objective:** get familiar with rebasing branches, solving conflicts and
cherry-picking.

<br>

The stakes are raising! You are now taking the lead developer position of the
"peak sorter" project - a mesmerizing bash script that sorts all of the Alp's
4000 m summits in order of decreasing elevation (i.e. highest to lowest). It
also displays the name and elevation of the highest summit in the Alps when
completed.

* Start the exercise by changing your work directory to `exercise_3` - it
  should be empty.
* Clone the Git repo for exercise 3 from GitHub with the command:

    ```sh
    git clone https://github.com/sibgit/peak_sorter.git
    ```

  > 🦉 **Reminder:** `git clone` creates (downloads) a local copy of a Git
  > repository from an online source (typically on GitHub or GitLab). It is
  > probably the most common way of starting to work on a repository.

* You should now have a new directory named "peak_sorter". Enter it with the
  command `cd peak_sorter`.
* To see the peak sorter script in action, run the following command in your
  shell:

    ```sh
    ./peak_sorter.sh
    ```

* Finally, have a look at the history of the Git repo with (or use `git adog`,
  if you created this alias):

    ```sh
    git log --all --decorate --oneline --graph
    ```

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# Clone the Git repository from GitHub.
cd exercise_3/
git clone https://github.com/sibgit/peak_sorter.git

# Test-run the peak sorter script.
cd peak_sorter
./peak_sorter.sh

# Display the Git repository's history.
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
  `main`, would we ? 😇.
2. **Cherry-pick** the commit that contains Jimmy's fix onto your `hotfix`
   branch.
   * 🎯 **Hint:** to identify the commit to cherry-pick, display the history
     of the repo and search for the commit message shown above.

3. When the cherry-pick is completed, test run the `peak_sorter.sh` script to
   make sure that i) the data integrity check was added, and ii) nothing was
   broken.

    ```sh
    ./peak_sorter.sh
    ```

   When running the script, you should now see an additional printed line
   informing you that a data integrity check was performed:

    > Running data integrity check...OK

   This shows us that the cherry-picked commit has indeed added the expected
   feature to our code - well done 😻 !

    > 🌈 **Note:** you can have a look at the changes introduced by the
    > cherry-picking by running `git show HEAD` (or simply `git show`). This
    > will display the content of the last commit on the current branch,
    > which is the one we just cherry-picked.

4. When you are confident things are working as expected,
   **merge the `hotfix` branch into `main`**.
5. **Delete the `hotfix` branch**.

<br>
<details><summary><b>✅ Solution</b></summary>

1. Create a new `hotfix` branch and switch to it:

    ```sh
    git switch -c hotfix
    ```

2. Apply Jimmy's fix using cherry-picking on a temporary `hotfix` branch.

   First we must identify the **hash** (commit ID) of the commit to
   cherry-pick. We can do this by displaying the repo history with the command:

    ```sh
    git log --all --decorate --oneline --graph
    ```

   And searching for the commit message:

   > peak_sorter: add check that input table has the ALTITUDE and PEAK columns"

   We find that the commit ID we are looking for is: `8e0d4fe`

   > ✨ **Tip:** if the history was very long and we did not want to manually
   > search through it (or if we are just lazy...), we can extract the line
   > of our target commit by using simple shell commands:
   >
   > ```sh
   >  git log --all --decorate --oneline --graph | grep "add check"
   > ```

   We can now cherry-pick the commit.

    ```sh
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
the number of [Dahus](https://en.wikipedia.org/wiki/Dahu) observations made on
each alpine peak to the output of the script.

Again, you're in luck, because this feature has already been developed in a
branch of the Git repo. That branch is aptly named `feature-dahu`.

Let's start by having a look at that branch:

* **Checkout (switch to)** the `feature-dahu` branch and display the history
  of the repo (so you can see the history of branches relative to each other).

   > 🌈 **Note:** when switching to a branch that already exists on a remote,
   > there is no need to add the `-c/--create` option to `git switch`.
   >
   > Here, this means that you can simply run `git switch feature-dahu` and
   > Git will automatically create a local branch `feature-dahu` based on
   > `origin/feature-dahu`.

* **Test** whether the new "Dahu count" feature has been implemented properly
  by running:

  ```sh
  ./peak_sorter.sh
  ```

  Verify that the script prints Dahu counts as part of its output on screen.
  A column named `DAHU_POPULATION` should also be present in the output file
  `sorted_peaks.txt`. You can have a look at this file with the command:

  ```sh
  head sorted_peaks.txt
  ```

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# Checkout the `feature-dahu` branch and display repo history.
git switch feature-dahu
git log --all --decorate --oneline --graph

# Run the script to test that the "Dahu count" feature works.
./peak_sorter.sh
```

</details>
<br>

To bring the Dahu count feature from the `feature-dahu` branch into the `main`
branch, we will proceed in 2 steps: first we will **rebase** `feature-dahu`
onto `main`, and then **merge** `feature-dahu` into `main`.

Let's start with the rebase:

* If not already done, display the **history of the Git repo** with:
  `git log --all --decorate --oneline --graph` (i.e. `git adog`). This will
  allow us to compare the history before and after the rebase that we will do
  in the next step.

* **Rebase the `feature-dahu` branch on `main`**.

  > 🔥 **Important:** in this exercise, should any conflict arise during the
  > rebase, always keep the version of the code that is coming from the
  > `feature-dahu` branch (the the version that is _not_ coming from `HEAD`).

* After completing the rebase, **run the peak-sorter script** again:

    ```sh
    ./peak_sorter.sh
    ```

  It should still display the number of observed Dahus as it did before the
  rebase. It should also display the data integrity check message
  `### Running data integrity check...OK` that we added to `main` earlier
  (because our `feature-dahu` branch now also contains the latest commits of
  `main`).

  Look again at your repo's history (`git adog`). Compare it to what you had
  before the merge (scroll up in your shell), to visually see how the rebase
  operation changed the history. Note how the hashes of the commits in the
  `feature-dahu` branch have changed.

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# Start the rebase of `feature-dahu` on `main`.
git rebase main

# There are 3 conflicts, so repeat the steps below 3 times.
vim peak_sorter.sh        # Open file in editor to solve the conflict.
git add peak_sorter.sh
git rebase --continue

# When the rebase is completed, test-run the script to check that
# everything is still working after the rebase.
./peak_sorter.sh

# Display the repo history. You should see that `feature-dahu` is now
# rooted on the latest commit of `main`.
git log --all --decorate --oneline --graph
```

</details>
<br>

Now that we are confident that the Dahu count feature is correctly implemented,
you can **merge `feature-dahu` into the `main` branch**.

* ❓ **Question:** do you expect any conflicts to occur during this merge?

<br>
<details><summary><b>✅ Solution</b></summary>

Merge `feature-dahu` into `main`.

```sh
git checkout main
git merge feature-dahu  # This is now a fast-forward merge -> no conflicts.

# Test run to see if everything is still working after the merge.
./peak_sorter.sh
```

**Question answer:** since we have rebased the branch `feature-dahu` on
`main`, the merge will be **fast-forward** and there will be no conflicts.
</details>
<br>

At the end of the exercise, your Git repo history should look like this (some
commit ID values will differ):

```sh
git log --all --decorate --oneline --graph

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

🌈 **Notes**

* In this exercise, the rebase of `feature-dahu` resulted in lots of conflicts.
  This was here done by design - so that you can train conflicts resolution.
  In real application conflicts do generally not happen so frequently 🍀.
* In a real application, you would regularly push your changes on `main` to the
  remote repository on GitHub with the **`git push`** command. In this exercise
  however, you do not have write permission on the remote repository to perform
  this action.
* Trying to delete the local branch `feature-dahu` with the safe
  **`git branch -d`** option will not work, because changes on the branch
  have not been pushed to the upstream branch `origin/feature-dahu`.
  If you wanted to delete the `feature-dahu` branch, you would need to use the
  `-D` option to **force-delete** the branch: `git branch -D feature-dahu`.
* If you wanted to push changes in `feature-dahu` to the remote, you would
  need to use `git push --force` to overwrite the branch's history on the
  remote. This is because **rebasing a branch modifies its history**: after the
  rebase, the history of the local and remote instance of `feature-dahu` have
  **diverged**.
* To see this divergence in history, you can run
  `git log --all --decorate --oneline --graph` and look at the
  `feature-dahu` and `origin/feature-dahu` branches.

<br>
<br>
<br>

## Exercise 4 - The Awesome Animal Awareness Project [60 min]

🚀 **Objective:** learn to collaborate with others on a project hosted on
a remote (e.g. on GitHub or GitLab).

Congratulations! Your improving Git skills have not gone unnoticed, and you are
now hired by our agile startup to work on the
**Awesome Animal Awareness Project** !

Your mission - should you choose to accept it - is to help us build a new
website. This is a **collaborative effort**, and you will be working in teams
of 3 people.

Each team will contribute a web page about a specific - and awesome - animal.
At the end of the exercise, the page created by your team will be integrated
into the [Awesome Animal Awareness website](https://sibgit.github.io).

> 🔥 **Important**
>
> * Please follow the **naming convention for branches** tightly,
>   as our company's internal Git policies are **very strict**.
> * **Before you start:** make sure that you created a
>   **personal access token (PAT)** on GitHub. This will be needed in
>   order to allow you to push changes to the remote. Please refer to the
>   course slides for instructions on how to create the token (a demo might
>   also be made in the class before the exercise).

<br>

### A) Organize your team

1. **Get together:** check the shared online document to see which team you
   belong to (the **Team** column in the GitHub user names table).
    * **On-site course:** locate your other team members in the classroom and
      sit together so you can communicate.
    * **Online course:** you will be placed in a breakout-room with your
      teammates. Remember that you can use the "share screen" function to
      help each other and show to other team members what you are doing on
      your machine.
   <br>

2. Change into `exercise_4/`. **Clone** the Awesome Animal Awareness project
   repo and enter it.

    ```sh
    git clone https://github.com/sibgit/sibgit.github.io
    cd sibgit.github.io
    ```

3. Among your group, **one person** should **create a new team branch**
   named after your animal's name followed by `-dev`, and then
   **push it to the remote** on GitHub.

   Example branch names: `tiger-dev`, `yeti-dev`, `sunfish-dev`,
   `pallas-cat-dev`, ...

   > 🎯 **Hint**: remember that when pushing a local branch to a remote
   > **for the first time**, we have to indicate an "upstream" remote branch
   > for the branch we are pushing.
   >
   > This is done by using the `-u / --set-upstream` option of `git push`:
   >
   > ```sh
   >  git push --set-upstream origin <branch you want to push>
   >
   >  # Examples:
   >  git push --set-upstream origin sunfish-dev
   >  git push -u origin sunfish-dev  # -u is the shortcut for --set-upstream
   >  ```

   <br>

4. Other team members can now **fetch changes** from the repo and
   **checkout the new team branch** that was just pushed to the remote.

    > 🔥 **Important**
    >
    > Other team members should _not_ create the team branch locally
    > themselves. They should check it out from the remote.
    >
    > For other team members, the `-u / --set-upstream` option is _not_ needed
    > when they push changes to the team branch for the first time, because the
    > upstream was automatically set by Git when checking-out the team branch
    > from the remote.

   <br>

5. Each team member should now **create a personal branch**, using the
   following naming scheme:
   `<animal>-<your name>`, e.g. `tiger-sandra` or `pallas-cat-tom`. Note that
   this branch does not necessarily have to be pushed to the remote: it's your
   personal work branch, so it can stay local.

   > 🌈 **Note:** in a real application, you would probably want to push your
   > personal branch to the remote as a backup (depending on how long-lived your
   > branch is), but this is not necessary for this exercise.

<br>
<details><summary><b>✅ Solution</b></summary>

Clone the Awesome Animal Awareness Project repo.

```sh
cd exercise_4/
git clone https://github.com/sibgit/sibgit.github.io.git
cd sibgit.github.io
```

One person creates the team branch and pushes it to the remote. The example
here is for team `yeti`.

  > `-u` is the short option for `--set-upstream`. This option is needed
  > because, at this point, the local `yeti-dev` branch is not associated
  > to any upstream branch on the remote.

```sh
# This must only be done by 1 member of the team.
git switch -c yeti-dev       # Create the team branch and switch to it.
git push -u origin yeti-dev  # Push the branch to the remote.
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

2. On your personal branch, **edit the HTML file** corresponding to your
   animal.
   * The topics that each member of the team has to work on are listed in the
     shared online document - see the **Task** column of the table.
   * In the HTML file, the `??` mark the positions where you have to add your
     content (make sure to remove the `??` after you are done editing).
   * For the team member with the **task "Animal name"**, make sure to include
     the [binomial name](https://en.wikipedia.org/wiki/Binomial_nomenclature)
     of the species as well, e.g. "Pallas's cat (_Otocolobus manul_)".
   * For the team member with the **task "Picture"**, you can either:
     * Link an existing image from somewhere on the web by setting
       `<img src=https://...>`.
     * Find and download a picture of your animal from the web, add the image
       to the project repo (in the `img/` directory), and insert the file name
       into `<img src="?? image-filename">`,
       e.g. `<img src="img/tiger_image.png">`.

       > 🔥 **Important:** make sure to add the image file to your commit.

3. **Verify the rendering of your HTML file** by opening it with your browser.

4. **Commit your changes** with a meaningful message.

<br>
<details><summary><b>✅ Solution</b></summary>

Each team member creates their personal work branch. The example here is for
`Alice`, working in team `yeti`.

```sh
# Create a new branch and switch to it.
git switch -c yeti-alice

# Edit the web page.
vim yeti.html

# Stage the modified file and create a new commit.
git add yeti.html
git commit -m "Yeti: add habitat and distribution info"
```

</details>
<br>

### C) Merge your branch with your team's animal-dev branch

Each team member should now merge the commit(s) made on their personal branch
(e.g. `tiger-sandra`) into the team's main development branch (e.g.
`tiger-dev`), and then push the changes back to the remote. This is best done
as a **coordinated iterative process**, where each member will in turn:

1. **Do a `git pull`** on the team's main development branch to make sure their
   local copy is up-to-date.

   > 🔥 **Important:** verify that you are on the correct branch before
   > running `git pull`.

   > 🌈 **Note:** in situations where you are not sure whether a remote branch
   > has diverged from your local copy, you can do a `git fetch` + `git status`
   > before running `git pull`. In this way you will see whether the merge
   > that will be done by `git pull` will be fast-forward or not.

   > 🦉 **Reminder:** `git pull` is a shortcut for
   > `git fetch` + `git merge <upstream>`.

2. **Rebase their personal branch** on the team's main development branch.

   > 🌈 **Note:** the first person to add their changes will in principle
   > _not_ need to rebase, since their personal branch will already be rooted
   > at the latest commit of the team's main development branch.

3. **Merge the changes** from their personal branch into the team's main
   development branch.

4. **Push the changes** back to the remote on GitHub. Then let the next team
   member know that they can proceed.

<br>

After all team members have gone through the above steps, the team's main
development branch should contain the work of all 3 team members.

<br>
<details><summary><b>✅ Solution</b></summary>

This assumes that Alice is either the second or third team member to add their
changes, and therefore she has to rebase her personal branch `yeti-alice`
onto `yeti-dev`.

1. Alice updates her local version of the team branch.

```sh
git switch yeti-dev

# Fetch updates from remote and merge them with local yeti-dev branch.
git pull
```

2. Alice rebases her personal branch on the team branch.

```sh
git switch yeti-alice

# Alice starts the rebase. There is a conflict that must be solved manually...
git rebase yeti-dev
# ...once the conflict is resolved, stage the file and continue the rebase.
git add yeti.html
git rebase --continue
```

3. Now that the rebase is completed, Alice merges her branch into `yeti-dev`.

```sh
git switch yeti-dev
git merge yeti-alice   # This is now a simple fast-forward merge.
```

4. Finally, she pushes the updated `yeti-dev` branch to the remote and lets
her team members know that she is done.

```sh
git push

# Optional: Alice can now delete her personal branch, it is no longer needed.
git branch -d yeti-alice
```

</details>
<br>

### D) Create a pull request / merge request

Now that your team branch is all merged and clean, it's time to contribute
your work to the **`main`** branch of the project.

Since you do not have the permission to push commits to the remote on the
`main` branch, you will instead contribute your changes via a **Pull Request**.
In this way, the top-level management of the Awesome Animal Awareness project
will be able to verify and approve your work before it gets added to `main` and
becomes part of the production version of the website.

One person in the team can now **open a Pull Request** (or a
**Merge Request** if using GitLab) for the team branch to be merged into the
project's `main` branch.

1. Creating a Pull Request is done online, in the project's
   [GitHub repository](https://github.com/sibgit/sibgit.github.io).

   * In the **Pull requests** tab, click on **New pull request**.
   * For more details on how to create a pull request, please refer to the
     course slides.

2. Once management approved your work and merged it into `main`, you should
   be able to see your animal's page on the
   [Awesome Animal Awareness website](https://sibgit.github.io) 😻 !

   > 🌈 **Note:** it takes a few minutes before the changes become live
     on the website.

3. After the pull request is merged, each team member can
   **update their local `main` branch** with the new changes that were added
   by the pull request (and also the changes added by the pull requests from
   other teams).

<br>

You made it - well done! Enjoy your success by reading about your awesome
animal and looking-up some of the other teams' pages 🐳.

<br>
<details><summary><b>✅ Solution</b></summary>

After the pull request is merged, each team member can update their local
repository.

```sh
# This check is optional, but can be used to make sure the merge from
# "git pull" will be fast-forward.
git fetch
git status

# Update your local `main` branch with the changes.
git switch main
git pull
```

</details>
<br>

### E) Additional Tasks: branch cleanup ✏️

Now that your team branch is merged into `main`, you can delete your team
branch and personal branches (since they have been merged).

1. Each team member can **delete their personal branch** and their local copy
   of the **team branch** from their local repo.

2. One person in the team can **delete the team branch on the remote**. The
   command for this is:

    ```sh
    git push origin --delete <team branch name>
    ```

   Alternatively, the team branch can also be deleted via the GitHub web
   interface.

3. Finally, each team member can **delete the remote-tracking branch** for
   the team branch (`origin/team-branch-name`) from their local repo.

    ```sh
    git fetch --prune
    ```

    > 🦉 **Reminder:** A **remote-tracking branch** (like `origin/main`) is a
    > local pointer showing the position of a branch on the remote at the
    > last time that data was fetched from the remote (i.e. the last time
    > that `git fetch` or `git pull` was run).

    > 🌈 **Note:** the **`--prune`** option in **`git fetch --prune`**
    > **deletes remote-tracking branches** that no longer exist on the remote.
    >
    > The `--prune` option can also be passed to the `git pull` command:
    > **`git pull --prune`**.

<br>
<details><summary><b>✅ Solution</b></summary>

```sh
# 1. Delete local instances of the team branch and the personal branch.
git branch -d yeti-alice
git branch -d yeti-dev

# 2. Delete the remote instance of the team branch.
#    Note: only one person in the team needs to do this.
git push origin --delete yeti-dev

# 3. Delete the remote-tracking branch for the team branch.
git fetch --prune
```

</details>

<br>
<br>
<br>
